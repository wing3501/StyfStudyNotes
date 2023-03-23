/// Copyright (c) 2023 Razeware LLC
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
#import "Lighting.h"

using namespace metal;

float3 phongLighting(float3 normal,
                     float3 position,
                     constant Params &params,
                     constant Light *lights,
                     float3 baseColor
                     ) {
//  return float3(0); //黑色
    // 这将为你将要进行的所有照明计算设置轮廓。你将累积最终的碎片颜色，由漫反射、镜面反射和环境光组成。
    float3 diffuseColor = 0;
    float3 ambientColor = 0;
    float3 specularColor = 0;
    for (uint i = 0; i < params.lightCount; i++) {
        Light light = lights[i];
        switch(light.type) {
            case Sun: {
                // 1 将灯光的方向设为单位向量。
                float3 lightDirection = normalize(-light.position);
                // 2 计算两个向量的点积。当fragment完全指向光线时，点积将为-1。更容易进行进一步的计算，使该值为正，因此可以否定点积。saturate通过箝位负数来确保该值在0和1之间。这将为您提供曲面的坡度，从而提供漫反射因子的强度
                float diffuseIntensity = saturate(-dot(lightDirection, normal));
                // 3 将基础颜色乘以漫反射强度以获得漫反射着色。如果有多个太阳光，diffuseColor将累积漫反射着色。
                diffuseColor += light.color * baseColor * diffuseIntensity;
                break;
            }
            case Point: {
                break;
            }
            case Spot: {
                break;
            }
            case Ambient: {
                ambientColor += light.color;
                break;
            }
            case unused: {
                break;
            }
        }
    }
    return diffuseColor + specularColor + ambientColor;
}

