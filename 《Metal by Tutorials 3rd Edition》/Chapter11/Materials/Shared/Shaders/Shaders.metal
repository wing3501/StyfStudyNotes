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
#import "Lighting.h"

struct VertexIn {
  float4 position [[attribute(Position)]];
  float3 normal [[attribute(Normal)]];
  float2 uv [[attribute(UV)]];
  float3 color [[attribute(Color)]];
  float3 tangent [[attribute(Tangent)]];
  float3 bitangent [[attribute(Bitangent)]];
};

struct VertexOut {
  float4 position [[position]];
  float2 uv;
  float3 color;
  float3 worldPosition;
  float3 worldNormal;
  float3 worldTangent;
  float3 worldBitangent;
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
    .worldPosition = (uniforms.modelMatrix * in.position).xyz,
    .worldNormal = uniforms.normalMatrix * in.normal,
    .worldTangent = uniforms.normalMatrix * in.tangent,
    .worldBitangent = uniforms.normalMatrix * in.bitangent
  };
  return out;
}

fragment float4 fragment_main(
  VertexOut in [[stage_in]],
  constant Params &params [[buffer(ParamsBuffer)]],
  constant Light *lights [[buffer(LightBuffer)]],
  texture2d<float> baseColorTexture [[texture(BaseColor)]],
  texture2d<float> normalTexture[[texture(NormalTexture)]],
  constant Material &_material [[buffer(MaterialBuffer)]]
                              ){
                                  
  Material material = _material;
                                  
  constexpr sampler textureSampler(
    filter::linear,
    address::repeat,
    mip_filter::linear,
    max_anisotropy(8));

//  float3 baseColor;
//  if (is_null_texture(baseColorTexture)) {
//    baseColor = in.color;
//  } else {
//    baseColor = baseColorTexture.sample(
//    textureSampler,
//    in.uv * params.tiling).rgb;
//  }
    //如果纹理存在，请使用从纹理中提取的颜色替换材质的基本颜色。否则，您已经在材质中加载了基本颜色。
  if (!is_null_texture(baseColorTexture)) {
      material.baseColor = baseColorTexture.sample(textureSampler, in.uv * params.tiling).rgb;
  }
    
  
    // 现在您正在传输法线纹理贴图，第一步是将其应用于小屋，就像它是一个颜色纹理一样。
    // 这将从纹理中读取normalValue（如果有）。如果此模型没有法线贴图纹理，请设置默认法线值。返回只是临时的，以确保应用程序正确加载法线贴图，并且法线贴图和UV匹配。
    float3 normal;
    if (is_null_texture(normalTexture)) {
        normal = in.worldNormal;
    }else {
        normal = normalTexture.sample(textureSampler, in.uv * params.tiling).rgb;
        normal = normal * 2 - 1;
        //此代码将法线方向重新计算为切线空间，以匹配法线纹理的切线空间。
        normal = float3x3(in.worldTangent, in.worldBitangent, in.worldNormal) * normal;
    }
    normal = normalize(normal);
//    return float4(normal, 1);
    
    float3 normalDirection = normalize(in.worldNormal);
//  float3 color = phongLighting(
//    normalDirection,
//    in.worldPosition,
//    params,
//    lights,
//    baseColor
//  );
    float3 color = phongLighting(
      normal,
      in.worldPosition,
      params,
      lights,
//      baseColor
      material
    );
  return float4(color, 1);
}
