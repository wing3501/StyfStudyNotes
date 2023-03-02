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
    
  var uniforms = Uniforms()

  lazy var model: Model = {
    Model(device: Renderer.device, name: "train.usd")
  }()

  var timer: Float = 0

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

    // create the pipeline state
    let pipelineDescriptor = MTLRenderPipelineDescriptor()
    pipelineDescriptor.vertexFunction = vertexFunction
    pipelineDescriptor.fragmentFunction = fragmentFunction
    pipelineDescriptor.colorAttachments[0].pixelFormat =
      metalView.colorPixelFormat
    pipelineDescriptor.vertexDescriptor =
      MTLVertexDescriptor.defaultLayout
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
      blue: 0.9,
      alpha: 1.0)
    metalView.delegate = self
      // 将modelMatrix设置为向右平移0.5个单位，向下平移0.4个单位，逆时针旋转45度。
//      let translation = float4x4(translation: [0.5, -0.4, 0])
//      let rotation = float4x4(rotation: [0, 0, Float(45).degreesToRadians])
//      uniforms.modelMatrix = translation * rotation
      
      // 创建视图矩阵，完成世界空间向相机空间转换
      // 请记住，场景中的所有对象都应该以与摄影机相反的方向移动。inverse做相反的变换。因此，当相机向右移动时，世界上的一切似乎都向左移动了0.8个单位。使用此代码，您可以在世界空间中设置摄影机，然后添加.inverse，这样对象将以与摄影机相反的关系作出反应。
      uniforms.viewMatrix = float4x4(translation: [0.8, 0, 0]).inverse
      // 此代码确保您在应用程序开始时设置投影矩阵。
      mtkView(metalView, drawableSizeWillChange: metalView.bounds.size)
  }
}

extension Renderer: MTKViewDelegate {
  func mtkView(
    _ view: MTKView,
    drawableSizeWillChange size: CGSize
  ) {
      // 设置投影矩阵
      // 每当视图大小更改时，都会调用此委托方法。因为纵横比会改变，所以必须重置投影矩阵。
      // 你使用的是45度的视野；近平面为0.1，远平面为100个单位。
      let aspect = Float(view.bounds.width) / Float(view.bounds.height)
      // 投影矩阵将顶点从截头体投影到范围为-w到w的立方体。顶点沿管道离开顶点函数后，GPU执行透视除法，并将x、y和z值除以其w值。w值越高，坐标越靠后。此计算的结果是所有可见顶点现在都在NDC内。
      // 为了避免被零除，平面附近的投影值应始终略大于零。
      let projectionMatrix = float4x4(projectionFov: Float(70).degreesToRadians, near: 0.1, far: 100, aspect: aspect)
      uniforms.projectionMatrix = projectionMatrix
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

    renderEncoder.setRenderPipelineState(pipelineState)
      //要渲染一个固体火车就删除这一行
//    renderEncoder.setTriangleFillMode(.lines)
    // 添加动画
    // 在这里，您重置相机视图矩阵，并用围绕y轴的旋转替换模型矩阵。
    // 可以看到，当火车旋转时，z轴上大于1.0的任何顶点都将被剪裁。Metal NDC外的任何顶点都将被剪裁。
    timer += 0.005
//    uniforms.viewMatrix = float4x4.identity
      // 因为有了投影矩阵，现在z坐标的测量方式不同了，所以你在火车上被放大了。
    uniforms.viewMatrix = float4x4(translation: [0, 0, -3]).inverse
//    let translationMatrix = float4x4(translation: [0, -0.6, 0])
//    let rotationMatrix = float4x4(rotationY: sin(timer))
//    uniforms.modelMatrix = translationMatrix * rotationMatrix
      // 增加Transform结构体后，重构
      model.postion.y = -0.6
      model.rotation.y = sin(timer)
      uniforms.modelMatrix = model.transform.modelMatrix
      
    // 矩阵传参
    renderEncoder.setVertexBytes(&uniforms, length: MemoryLayout<Uniforms>.stride, index: 11)

      
    model.render(encoder: renderEncoder)

    renderEncoder.endEncoding()
    guard let drawable = view.currentDrawable else {
      return
    }
    commandBuffer.present(drawable)
    commandBuffer.commit()
  }
}
