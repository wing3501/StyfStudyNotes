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
//#import "Common.h"
#import "Lighting.h"

struct VertexIn {
  float4 position [[attribute(Position)]];
  float3 normal [[attribute(Normal)]];
  float2 uv [[attribute(UV)]];
  float3 color [[attribute(Color)]];
};

struct VertexOut {
  float4 position [[position]];
  float2 uv;
  float3 color;
    // 这些将保持世界空间中的顶点位置和顶点法线。
    float3 worldPosition;
    float3 worldNormal;
};

vertex VertexOut vertex_main(
  const VertexIn in [[stage_in]],
  constant Uniforms &uniforms [[buffer(UniformsBuffer)]])
{
  float4 position =
    uniforms.projectionMatrix * uniforms.viewMatrix
    * uniforms.modelMatrix * in.position;
  VertexOut out {
    .position = position,
    .uv = in.uv,
    .color = in.color,
      .worldPosition = (uniforms.modelMatrix * in.position).xyz,//在这里，将顶点位置和法线转换为世界空间。
      .worldNormal = uniforms.normalMatrix * in.normal
  };
  return out;
}
// 在片段着色器中，您可以获取这些值，并将片段颜色乘以点积，以获得片段的亮度。
fragment float4 fragment_main(
  VertexOut in [[stage_in]],
  constant Params &params [[buffer(ParamsBuffer)]],
  constant Light *lights [[buffer(LightBuffer)]],
  texture2d<float> baseColorTexture [[texture(BaseColor)]])
{
  constexpr sampler textureSampler(
    filter::linear,
    address::repeat,
    mip_filter::linear,
    max_anisotropy(8));

  float3 baseColor;
  if (is_null_texture(baseColorTexture)) {
    baseColor = in.color;
  } else {
    baseColor = baseColorTexture.sample(
    textureSampler,
    in.uv * params.tiling).rgb;
  }
//  return float4(baseColor, 1);
    // 在这里，您将世界法线设为单位向量，并使用必要的参数调用新的照明函数。
    float3 normalDirection = normalize(in.worldNormal);
    float3 color = phongLighting(normalDirection, in.worldPosition, params, lights, baseColor);
    return float4(color, 1);
    
}
