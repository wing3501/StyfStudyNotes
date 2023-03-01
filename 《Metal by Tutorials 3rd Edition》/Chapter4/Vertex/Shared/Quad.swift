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

import MetalKit
//使用两个三角形创建四边形，每个三角形有三个顶点，总共六个顶点。
// [-1,1,0](0,3)    [1,1,0](4)
//
// [-1,-1,0](2)   [1,-1,0](1,5)

struct Quad {
//    var vertices: [Float] = [
//        -1,  1, 0, // triangle 1
//         1, -1, 0,
//        -1, -1, 0,
//        -1,  1, 0, // triangle 2
//         1,  1, 0,
//         1, -1, 0
//    ]
    
//    在这些顶点中，0和3与1和5位于相同的位置。如果渲染具有数千甚至数百万个顶点的网格，则尽可能减少重复非常重要。您可以使用索引渲染来执行此操作。
    
    var vertices: [Float] = [
        -1,  1, 0,
         1,  1, 0,
        -1, -1, 0,
         1, -1, 0
    ]
    
    var indices: [UInt16] = [
        0, 3, 2,
        0, 1, 3
    ]
    
    var colors: [simd_float3] = [
        [1, 0, 0],  // red
        [0, 1, 0],  // green
        [0, 0, 1],  // blue
        [1, 1, 0]   // yellow
    ]
    
    let vertexBuffer: MTLBuffer
    let indexBuffer: MTLBuffer
    let colorBuffer: MTLBuffer
    
    init(device: MTLDevice, scale: Float = 1) {
        // 使用此代码，可以使用顶点数组初始化Metal缓冲区。您可以按比例乘以每个顶点，这样可以在初始化期间设置四边形的大小。
        vertices = vertices.map({
            $0 * scale
        })
        guard let vertexBuffer = device.makeBuffer(bytes: &vertices, length: MemoryLayout<Float>.stride * vertices.count, options: []) else {
            fatalError("Unable to create quad vertex buffer")
        }
        self.vertexBuffer = vertexBuffer
        
        guard let indexBuffer = device.makeBuffer(bytes: &indices, length: MemoryLayout<UInt16>.stride * indices.count, options: []) else {
            fatalError("Unable to create quad index buffer")
        }
        self.indexBuffer = indexBuffer
        
        guard let colorBuffer = device.makeBuffer(bytes: &colors, length: MemoryLayout<simd_float3>.stride * colors.count, options: []) else {
            fatalError("Unable to create quad color buffer")
        }
        self.colorBuffer = colorBuffer
    }
}
