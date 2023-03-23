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

#ifndef Common_h
#define Common_h

#import <simd/simd.h>

typedef struct {
  matrix_float4x4 modelMatrix;
  matrix_float4x4 viewMatrix;
  matrix_float4x4 projectionMatrix;
//    计算法线的新位置与顶点位置计算有点不同。MathLibrary.swift包含一个矩阵方法，用于从另一个矩阵创建法线矩阵。这个法线矩阵是一个3×3的矩阵，因为首先，你将在不需要投影的世界空间中进行照明，其次，平移对象不会影响法线的斜率。因此，您不需要第四个W维度。但是，如果在一个方向（非线性）缩放对象，则对象的法线将不再正交，这种方法将不起作用。只要你决定你的引擎不允许非线性缩放，那么你就可以使用模型矩阵的左上3×3部分，这就是你在这里要做的。
  matrix_float3x3 normalMatrix; //这将保持世界空间中的法线矩阵。
} Uniforms;

typedef struct {
  uint width;
  uint height;
  uint tiling;
  
  uint lightCount;
  vector_float3 cameraPosition;
} Params;

typedef enum {
  Position = 0,
  Normal = 1,
  UV = 2,
  Color = 3
} Attributes;

typedef enum {
  VertexBuffer = 0,
  UVBuffer = 1,
  ColorBuffer = 2,
  UniformsBuffer = 11,
  ParamsBuffer = 12,
  LightBuffer = 13
} BufferIndices;

typedef enum {
  BaseColor = 0
} TextureIndices;

//创建将要使用的灯光类型的枚举：
typedef enum {
    unused = 0,
    Sun = 1,
    Spot = 2,
    Point = 3,
    Ambient = 4
} LightType;

//添加定义灯光的结构：
typedef struct {
    LightType type;
    vector_float3 position;
    vector_float3 color;
    vector_float3 specularColor;
    float radius;
    vector_float3 attenuation;
    float coneAngle;
    vector_float3 coneDirection;
    float coneAttenuation;
} Light;

#endif /* Common_h */
