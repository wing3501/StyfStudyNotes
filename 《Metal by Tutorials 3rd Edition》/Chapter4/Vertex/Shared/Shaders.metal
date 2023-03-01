/// Copyright (c) 2022 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

#include <metal_stdlib>
using namespace metal;

// 当将指针传递到顶点函数时，必须指定地址空间（常量或设备）。常量被优化以并行访问多个顶点函数上的同一变量。该设备最适合通过并行函数访问缓冲区的不同部分，例如当使用点和颜色数据交错的缓冲区时。
// [[vertex_id]]是一个属性限定符，用于提供当前顶点。可以将其用作顶点中保存的数组的条目。

//虽然可能会得到不同的渲染，但顶点的位置不对，因为float3类型比三个Float类型占用更多内存。SIMD float3类型被填充，占用的内存与float4类型相同，为16字节。将此参数更改为packed_float3将修复错误，因为packed_ffloat3占用12个字节。
//或者，可以将浮点数组顶点定义为simd_float3的数组。在这种情况下，您可以在顶点函数中使用float3，因为这两种类型都需要16个字节。然而，每个顶点发送16字节的效率略低于每个顶点发送12字节的效率。
//vertex float4 vertex_main(constant packed_float3 *vertices [[buffer(0)]], uint vertexID [[vertex_id]]) {
//    float4 position = float4(vertices[vertexID], 1);
//    return position;
//}

// 加入定时器参数后
//vertex float4 vertex_main(
//                          constant packed_float3 *vertices [[buffer(0)]],
//                          constant float &timer [[buffer(11)]],
//                          uint vertexID [[vertex_id]]) {
////您在缓冲区11中接收单值计时器作为浮点数。将计时器值添加到y位置，然后从函数返回新位置。
//    float4 position = float4(vertices[vertexID], 1);
//    position.y += timer;
//    return position;
//}

// 加入顶点下标参数后
//vertex float4 vertex_main(
//                          constant packed_float3 *vertices [[buffer(0)]],
//                          constant ushort *indices [[buffer(1)]],
//                          constant float &timer [[buffer(11)]],
//                          uint vertexID [[vertex_id]]) {
//    ushort index = indices[vertexID];
//    float4 position = float4(vertices[index], 1);
////    position.y += timer;
//    return position;
//}

// 使用顶点描述符后
//vertex float4 vertex_main(float4 position [[attribute(0)]] [[stage_in]],
//                          constant float &timer [[buffer(11)]]) {
//    // 使用[[stage_in]]属性描述每个逐顶点输入。GPU现在查看管道状态的顶点描述符。
////    [[attribute（0）]]是描述位置的顶点描述符中的属性。即使您将原始顶点数据定义为三个Float，也可以在此处将位置定义为float4。GPU可以进行转换。
////    值得注意的是，当GPU将w信息添加到xyz位置时，它将添加1.0。正如您将在以下章节中看到的，这个w值在光栅化过程中非常重要。
//    return position;
//}

// 加入颜色缓冲区后  只能对一个参数使用[[stage_in]],所以新建一个结构体
struct VertexIn {
    float4 position [[attribute(0)]];
    float4 color [[attribute(1)]];
};

struct VertexOut {
    float4 position [[position]];
    float4 color;
    float pointSize [[point_size]];
};

vertex VertexOut vertex_main(VertexIn in [[stage_in]],
                          constant float &timer [[buffer(11)]]) {
//    现在，您将返回位置和颜色，而不是仅从顶点函数返回位置。指定一个位置属性，让GPU知道此结构中的哪个属性是位置。
    VertexOut out {
        .position = in.position,
        .color = in.color,
        .pointSize = 30
    };
    return out;
}

fragment float4 fragment_main(VertexOut in [[stage_in]]) {
    // [[stage_in]]属性表示GPU应该从顶点函数获取VertexOut输出，并将其与光栅化片段匹配。在这里，返回顶点颜色。请记住，在第3章“渲染管道”中，每个片段的输入都是插值的。
    return in.color;
}
