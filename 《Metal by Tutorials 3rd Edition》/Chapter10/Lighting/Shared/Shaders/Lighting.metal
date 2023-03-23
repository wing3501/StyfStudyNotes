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
    // 这些保持了表面材质的光泽因子和镜面反射颜色的属性。由于这些是曲面属性，您应该从每个模型的材质中获取这些值，您将在下一章中进行此操作。
    float materialShininess = 32;
    float3 materialSpecularColor = float3(1, 1, 1);
    
    
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
                
                if (diffuseIntensity > 0) {
                    // 1 (R)  对于镜面反射颜色的计算，您需要（L）光、（R）反射、（N）法线和（V）视图。您已经有了（L）和（N），所以在这里您可以使用Metal Shading Language函数reflect来获得（R）。
                    float3 reflection = reflect(lightDirection, normal);
                    // 2 (V)  对于（V），您需要片段和摄影机之间的视图向量。
                    float3 viewDirection = normalize(params.cameraPosition);
                    // 3 现在计算镜面反射强度。使用点积可以找到反射和视图之间的角度，使用饱和将结果夹在0和1之间，并使用pow将结果提高到亮度。然后使用该强度来计算碎片的镜面反射颜色。
                    float specularIntensity = pow(saturate(dot(reflection, viewDirection)), materialShininess);
                    specularColor += light.specularColor * materialSpecularColor * specularIntensity;
                }
                break;
            }
            case Point: {
                // 1 你可以找到灯光和fragment位置之间的距离。
                float d = distance(light.position, position);
                // 2 对于定向太阳光，您使用该位置作为光的方向。在这里，您可以计算从fragment位置到灯光位置的方向。
                float3 lightDirection = normalize(light.position - position);
                // 3 使用衰减公式和距离计算衰减，看看fragment会有多亮。
                float attenuation = 1.0 / (light.attenuation.x + light.attenuation.y * d + light.attenuation.z * d * d);
                float diffuseIntensity = saturate(dot(lightDirection, normal));
                float3 color = light.color * baseColor * diffuseIntensity;
                // 4 像计算太阳光那样计算漫反射颜色后，将此颜色乘以衰减。
                color *= attenuation;
                diffuseColor += color;
                break;
            }
            case Spot: {
                // 1 计算距离和方向，就像对点光源所做的那样。这条光线可能在聚光锥的外面。
                float d = distance(light.position, position);
                float3 lightDirection = normalize(light.position - position);
                // 2 计算光线方向和聚光灯指向的方向之间的余弦角（即点积）。
                float3 coneDirection = normalize(light.coneDirection);
                float spotResult = dot(lightDirection, -coneDirection);
                // 3 如果该结果在圆锥体角度之外，则忽略光线。否则，计算点光源的衰减。指向同一方向的矢量的点积为1.0。
                if (spotResult > cos(light.coneAngle)) {
                    float attenuation = 1.0 / (light.attenuation.x + light.attenuation.y * d + light.attenuation.z * d * d);
                    // 4 使用锥形衰减作为功率计算聚光灯边缘的衰减。
                    attenuation *= pow(spotResult, light.coneAttenuation);
                    float diffuseIntensity = saturate(dot(lightDirection, normal));
                    float3 color = light.color * baseColor * diffuseIntensity;
                    color *= attenuation;
                    diffuseColor += color;
                }
                
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

