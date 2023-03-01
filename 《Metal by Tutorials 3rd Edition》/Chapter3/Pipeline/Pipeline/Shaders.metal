//
//  Shaders.metal
//  Pipeline
//
//  Created by 申屠云飞 on 2023/3/1.
//

#include <metal_stdlib>
using namespace metal;

// 简而言之，CPU向GPU发送了一个顶点缓冲区，该缓冲区是您从模型的网格创建的。您使用顶点描述符配置了顶点缓冲区，该描述符告诉GPU顶点数据的结构。在GPU上，您创建了一个结构来封装顶点属性。顶点着色器将此结构作为函数参数，并通过[[stage_in]]限定符确认该位置通过顶点缓冲区中的[[attribute（0）]]位置来自CPU。顶点着色器然后处理所有顶点，并将其位置作为float4返回。

// 1 创建一个结构VertexIn来描述与前面设置的顶点描述符匹配的顶点属性。在这种情况下，只需定位。
struct VertexIn {
  float4 position [[attribute(0)]];
};
// 2 实现顶点着色器vertex_main，它接受VertexIn结构并以float4类型返回顶点位置。
vertex float4 vertex_main(const VertexIn vertexIn [[stage_in]])
{
    // 请记住，顶点在顶点缓冲区中进行索引。顶点着色器通过[[stage_in]]属性获取当前顶点索引，并在当前索引处解开为顶点缓存的VertexIn结构。
//  return vertexIn.position;
    
    // 火车垂直位置
    float4 position = vertexIn.position;
    position.y -= 1.0;
    return position;
}

fragment float4 fragment_main() {
    return float4(1, 0, 0, 1);
}
