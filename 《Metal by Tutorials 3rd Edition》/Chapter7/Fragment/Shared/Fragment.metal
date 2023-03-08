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
#import "Common.h"
#import "ShaderDefs.h"

//fragment float4 fragment_main(VertexOut in [[stage_in]])
//{
////  return float4(0.2, 0.5, 1.0, 1);
//    // 在这里，光栅化器插入in.position并将其转换为屏幕空间。您在ContentView.swift中将Metal视图的宽度定义为400点。使用新添加的代码，您可以说如果x位置小于200，则将颜色设置为黑色。否则，使颜色为白色。
//    float color;
//    in.position.x < 200 ? color = 0 : color = 1;
//    return float4(color, color, color, 1);
//}

// 接收纹理尺寸参数
fragment float4 fragment_main(constant Params &params [[buffer(ParamsBuffer)]],
                              VertexOut in [[stage_in]])
{
//  return float4(0.2, 0.5, 1.0, 1);
    // 在这里，光栅化器插入in.position并将其转换为屏幕空间。您在ContentView.swift中将Metal视图的宽度定义为400点。使用新添加的代码，您可以说如果x位置小于200，则将颜色设置为黑色。否则，使颜色为白色。
//    float color;
//    in.position.x < 200 ? color = 0 : color = 1;
//    in.position.x < params.width * 0.5 ? color = 0 : color = 1;
    
    // 除了sin、abs和length等标准数学函数外，还有一些其他有用的函数。
    // step 结果是，当step的结果为0时，左侧为黑色，当step结果为1时，右侧为白色。
//    float color = step(params.width * 0.5, in.position.x);
//    return float4(color, color, color, 1);
    
//    //让我们用棋盘图案进一步了解一下。
//    uint checks = 8;
//    // 1 UV坐标形成值介于0和1之间的网格。网格的中心位于[0.5，0.5]。UV坐标通常与将顶点映射到纹理相关
//    float2 uv = in.position.xy / params.width;
//    // 2 fract（x）返回x的分数部分。将UV的分数值乘以检查次数的一半，得到的值介于0和1之间。若要使UV居中，请减去0.5。
//    uv = fract(uv * checks * 0.5) - 0.5;
//    // 3 如果xy乘法的结果小于零，则结果为0或黑色。否则，它是1或白色。
//    float3 color = step(uv.x * uv.y, 0.0);
//    return float4(color, 1.0);
    
    // length函数  创建一个圆
//    float center = 0.5;
//    float radius = 0.2;
//    float2 uv = in.position.xy / params.width - center;
//    float3 color = step(length(uv), radius);
//    return float4(color, 1.0);
    
    // smoothstep函数  smoothstep（edge0，edge1，x）返回0到1之间的平滑Hermite插值。
    // edge1必须大于edge0，x应为edge0<=x<=edge1。
    // 在两种边缘情况之间，颜色是在黑色和白色之间插值的渐变。在这里，您使用smoothstep计算颜色，但也可以使用它在任意两个值之间进行插值。例如，可以使用smoothstep在顶点函数中设置位置动画。
//    float color = smoothstep(0, params.width, in.position.x);
//    return float4(color, color, color, 1);
    
    // mix 函数  mix（x，y，a）产生与x+（y-x）*a相同的结果。
    // mix0产生全红色。mix1产生全蓝色。这些颜色加在一起，红色和蓝色的混合度达到60%。
//    float3 red = float3(1, 0, 0);
//    float3 blue = float3(0, 0, 1);
//    float3 color = mix(red, blue, 0.6);
//    return float4(color, 1);
    
    // 组合使用mix 和 smoothstep
//    float3 red = float3(1, 0, 0);
//    float3 blue = float3(0, 0, 1);
//    float result = smoothstep(0, params.width, in.position.x);
//    float3 color = mix(red, blue, result);
//    return float4(color, 1);
    
    // normalize 函数
    // 如果两个向量的大小相同，比较它们的方向更容易，因此可以将向量归一化为单位长度。normalize（x）返回相同方向但长度为1的向量x。
    
    // fragment函数应该返回RGBA颜色，每个元素都在0和1之间。但是，因为位置在屏幕空间中，所以每个位置在[0，0，0]和[800，800，0]之间变化，这就是为什么四边形渲染为黄色（仅在左上角的0和1之间）。
//    return in.position;
//    return float4(1, 1, 0, 1);
    // 这里，将.position.xyz中的向量归一化为长度为1。所有颜色现在都保证在0和1之间。标准化后，右上角的位置（800,0,0）包含1，0，0，这是红色的。
//    float3 color = normalize(in.position.xyz);
//    return float4(color, 1);
    
    // normals
//    法线是表示顶点或曲面所面向的方向的向量
//    return float4(in.normal, 1);
    
    // mix（x，y，z）根据第三个值在前两个值之间进行插值，该值必须介于0和1之间。正常值介于-1和1之间，因此可以在0和1之间转换强度。
    float4 sky = float4(0.34, 0.9, 1.0, 1.0);
    float4 earth = float4(0.29, 0.58, 0.2, 1.0);
    float intensity = in.normal.y * 0.5 + 0.5;
    return mix(earth, sky, intensity);
}
