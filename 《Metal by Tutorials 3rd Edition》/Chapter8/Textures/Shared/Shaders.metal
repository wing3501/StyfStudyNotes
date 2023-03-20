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

struct VertexIn {
  float4 position [[attribute(Position)]];
  float3 normal [[attribute(Normal)]];
  float2 uv [[attribute(UV)]];
};

struct VertexOut {
  float4 position [[position]];
  float3 normal;
  float2 uv;
};

vertex VertexOut vertex_main(
  const VertexIn in [[stage_in]],
  constant Uniforms &uniforms [[buffer(UniformsBuffer)]])
{
  float4 position =
    uniforms.projectionMatrix * uniforms.viewMatrix
    * uniforms.modelMatrix * in.position;
  float3 normal = in.normal;
  VertexOut out {
    .position = position,
    .normal = normal,
    .uv = in.uv
  };
  return out;
}

fragment float4 fragment_main(
  constant Params &params [[buffer(ParamsBuffer)]],
  VertexOut in [[stage_in]],
  texture2d<float> baseColorTexture [[texture(BaseColor)]]) //增加纹理参数
{
//  float4 sky = float4(0.34, 0.9, 1.0, 1.0);
//  float4 earth = float4(0.29, 0.58, 0.2, 1.0);
//  float intensity = in.normal.y * 0.5 + 0.5;
//  return mix(earth, sky, intensity);
    // 读取或采样纹理时，可能无法精确地落在特定像素上。在纹理空间中，采样的单位称为纹素，您可以决定如何使用采样器处理每个纹素。
//    constexpr sampler textureSampler;
    // 地面纹理会拉伸以适应地平面，纹理中的每个像素都可以由几个渲染片段使用，从而使其具有像素化的外观。通过更改其中一个采样器参数，可以告诉Metal如何处理比指定片段小的纹素。
//    constexpr sampler textureSampler(filter::linear);//nearest
    
    // 在这里，使用顶点函数发送的插值UV坐标对纹理进行采样，然后检索RGB值。在“Metal Shading Language”中，可以使用rgb将浮点元素作为xyz的等效元素进行寻址。然后从fragment函数返回纹理颜色。
//    float3 baseColor = baseColorTexture.sample(textureSampler, in.uv).rgb;
    // 此代码将UV坐标乘以16，并访问0到1的允许限制之外的纹理。address：：repeat更改采样器的寻址模式，因此它将在平面上重复纹理16次。
    //constexpr sampler textureSampler(filter::linear, address::repeat);
    // 使用mipmap  mip_filter的默认值为none。但是，如果您提供.lineral或.snearless，则GPU将对正确的mipmap进行采样。
    constexpr sampler textureSampler(filter::linear, address::repeat, mip_filter::linear);
    
//    float3 baseColor = baseColorTexture.sample(textureSampler, in.uv * 16).rgb; //房子的纹理也被平铺了
    float3 baseColor = baseColorTexture.sample(textureSampler, in.uv * params.tiling).rgb;
    return float4(baseColor, 1);
}
