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

import MetalKit

// swiftlint:disable implicitly_unwrapped_optional

class Renderer: NSObject {
  static var device: MTLDevice!
  static var commandQueue: MTLCommandQueue!
  static var library: MTLLibrary!
  var pipelineState: MTLRenderPipelineState!
    
    var timer: Float = 0
    
    var count: UInt = 50
    
    lazy var quad: Quad = {
        Quad(device: Renderer.device, scale: 0.8)
    }()

  init(metalView: MTKView) {
    guard
      let device = MTLCreateSystemDefaultDevice(),
      let commandQueue = device.makeCommandQueue() else {
        fatalError("GPU not available")
    }
    Renderer.device = device
    Renderer.commandQueue = commandQueue
    metalView.device = device

    // create the shader function library
    let library = device.makeDefaultLibrary()
    Self.library = library
    let vertexFunction = library?.makeFunction(name: "vertex_main")
    let fragmentFunction =
      library?.makeFunction(name: "fragment_main")

    // create the pipeline state object
    let pipelineDescriptor = MTLRenderPipelineDescriptor()
    pipelineDescriptor.vertexFunction = vertexFunction
    pipelineDescriptor.fragmentFunction = fragmentFunction
    pipelineDescriptor.colorAttachments[0].pixelFormat =
      metalView.colorPixelFormat
    // 使用顶点描述符 GPU现在将期望该顶点描述符所描述的格式的顶点。
//    pipelineDescriptor.vertexDescriptor = MTLVertexDescriptor.defaultLayout
    do {
      pipelineState =
        try device.makeRenderPipelineState(
          descriptor: pipelineDescriptor)
    } catch let error {
      fatalError(error.localizedDescription)
    }

    super.init()
    metalView.clearColor = MTLClearColor(
      red: 1.0,
      green: 1.0,
      blue: 0.8,
      alpha: 1.0)
    metalView.delegate = self
  }
}

extension Renderer: MTKViewDelegate {
  func mtkView(
    _ view: MTKView,
    drawableSizeWillChange size: CGSize
  ) {
  }

  func draw(in view: MTKView) {
    guard
      let commandBuffer = Renderer.commandQueue.makeCommandBuffer(),
      let descriptor = view.currentRenderPassDescriptor,
      let renderEncoder =
        commandBuffer.makeRenderCommandEncoder(
          descriptor: descriptor) else {
        return
    }
      
      renderEncoder.setVertexBytes(&count, length: MemoryLayout<UInt>.stride, index: 0)
    // 1 对于每一帧，您都会更新计时器。您希望立方体在屏幕上上下移动，因此将使用介于-1和1之间的值。使用sin（）是实现这种平衡的好方法，因为正弦值总是-1到1。可以通过更改为每帧添加到此计时器的值来更改动画的速度。
    timer += 0.005
    var currentTime = sin(timer)
    // 如果您只向GPU发送少量数据（比如小于4KB），则setVertexBytes（_：length：index：）是设置MTLBuffer的替代方法。这里，您将缓冲区参数表中的currentTime设置为索引11。为顶点属性（例如顶点位置）保留缓冲区1到10有助于记住哪些缓冲区保存哪些数据。
    renderEncoder.setVertexBytes(&currentTime, length: MemoryLayout<Float>.stride, index: 11)
    
    renderEncoder.setRenderPipelineState(pipelineState)

    // do drawing here
//    renderEncoder.setVertexBuffer(quad.vertexBuffer, offset: 0, index: 0)
    // 使用顶点下标    使用顶点描述符后删除
//    renderEncoder.setVertexBuffer(quad.indexBuffer, offset: 0, index: 1)
    // 设置颜色缓存  使用缓冲区索引1将颜色缓冲区发送到GPU，该索引必须与顶点描述符布局中的索引匹配。
//      renderEncoder.setVertexBuffer(quad.colorBuffer, offset: 0, index: 1)
      
    // 绘制quad的6个顶点
//    renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: quad.vertices.count)
    // 加入顶点下标后的绘制
//      renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: quad.indices.count)
    // 使用顶点描述符后的绘制
//      renderEncoder.drawIndexedPrimitives(type: .triangle, indexCount: quad.indices.count, indexType: .uint16, indexBuffer: quad.indexBuffer, indexBufferOffset: 0)
      // 渲染点
//      renderEncoder.drawIndexedPrimitives(type: .point, indexCount: quad.indices.count, indexType: .uint16, indexBuffer: quad.indexBuffer, indexBufferOffset: 0)
      
      renderEncoder.drawPrimitives(type: .point, vertexStart: 0, vertexCount: Int(count))

    renderEncoder.endEncoding()
    guard let drawable = view.currentDrawable else {
      return
    }
    commandBuffer.present(drawable)
    commandBuffer.commit()
  }
}
