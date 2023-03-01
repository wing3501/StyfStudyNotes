//
//  Renderer.swift
//  Pipeline
//
//  Created by 申屠云飞 on 2023/3/1.
//
//与OpenGL相比，Metal有一个主要优势，那就是您可以在前面实例化一些对象，而不是在每一帧中创建它们。
//下图显示了可以在应用程序开始时创建的一些金属对象
// MTLDevice：GPU硬件设备的软件引用
// MTLCommandQueue：负责创建和组织每帧的MTLCommandBuffers。
// MTLLibrary：包含顶点和片段着色器函数的源代码。
// MTLRenderPipelineState：设置绘制的信息，例如要使用的着色器函数、要使用的深度和颜色设置以及如何读取顶点数据。
// MTLBuffer：持有数据，可以发送到GPU的形式保存数据（如顶点信息）。

//通常，应用程序中会有一个MTLDevice、一个MTLCommandQueue和一个MTLLibrary对象。
//您还将拥有多个MTLRenderPipelineState对象，这些对象将定义各种管道状态，以及多个用于保存数据的MTLBuffer。
//然而，在使用这些对象之前，需要初始化它们。
import MetalKit

class Renderer: NSObject {
    
    static var device: MTLDevice!
    static var commandQueue: MTLCommandQueue!
    static var library: MTLLibrary!
    var mesh: MTKMesh!
    var vertexBuffer: MTLBuffer!
    var pipelineState: MTLRenderPipelineState!
    
    init(metalView: MTKView) {
        guard
            let device = MTLCreateSystemDefaultDevice(),
            let commandQueue = device.makeCommandQueue() else {
            fatalError("GPU not available")
        }
        Renderer.device = device
        Renderer.commandQueue = commandQueue
        metalView.device = device
        
        // create the mesh 此代码创建立方体网格
        let allocator = MTKMeshBufferAllocator(device: device)
//        let size: Float = 0.8
//        let mdlMesh = MDLMesh(boxWithExtent: [size, size, size],
//                              segments: [1, 1, 1],
//                              inwardNormals: false,
//                              geometryType: .triangles,
//                              allocator: allocator)
//        do {
//            mesh = try MTKMesh(mesh: mdlMesh, device: device)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        // 设置包含要发送到GPU的顶点数据的MTLBuffer。
//        vertexBuffer = mesh.vertexBuffers[0].buffer
        // 火车模型
        guard let assetURL = Bundle.main.url(
          forResource: "train",
          withExtension: "usd") else {
          fatalError()
        }
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.layouts[0].stride = MemoryLayout<SIMD3<Float>>.stride
        let meshDescriptor = MTKModelIOVertexDescriptorFromMetal(vertexDescriptor)
        (meshDescriptor.attributes[0] as! MDLVertexAttribute).name = MDLVertexAttributePosition
        let asset = MDLAsset(
          url: assetURL,
          vertexDescriptor: meshDescriptor,
          bufferAllocator: allocator)
        let mdlMesh =
          asset.childObjects(of: MDLMesh.self).first as! MDLMesh

        do {
            mesh = try MTKMesh(mesh: mdlMesh, device: device)
        } catch let error {
            print(error.localizedDescription)
        }
        vertexBuffer = mesh.vertexBuffers[0].buffer
        
        // 接下来，您需要设置管道状态，以便GPU知道如何渲染数据。
        // 首先，设置MTLLibrary并确保顶点和片段着色器函数存在。
        let library = device.makeDefaultLibrary()
        Renderer.library = library
        let vertexFunction = library?.makeFunction(name: "vertex_main")
        let fragmentFunction = library?.makeFunction(name: "fragment_main")
        // 要配置GPU的状态，请创建管道状态对象pipeline state object（PSO）。
        // 此管道状态可以是用于渲染顶点的渲染管道状态，也可以是用于运行计算内核的计算管道状态。
        
        // create the pipeline state object
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = metalView.colorPixelFormat
        pipelineDescriptor.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(mdlMesh.vertexDescriptor)
        
        do {
            //为了提高效率，您应该设置缠绕顺序，并在管道状态下启用背面剔除。
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch let error {
            fatalError(error.localizedDescription)
        }
        // PSO保持GPU的潜在状态。GPU需要知道其完整状态，然后才能开始管理顶点。
        // 在这里，您设置GPU将调用的两个着色器函数以及GPU将写入的纹理的像素格式。还可以设置管道的顶点描述符；
        // 这就是GPU如何解释网格数据MTLBuffer中的顶点数据。
        
        // 如果需要使用不同的数据缓冲区布局或调用不同的顶点或片段函数，则需要额外的管道状态。创建管道状态相对耗时，这就是为什么要提前创建管道状态的原因，但在帧期间切换管道状态既快速又高效。
        
        super.init()
        
        metalView.clearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
        metalView.delegate = self
    }
}

extension Renderer: MTKViewDelegate {
    // 每次窗口大小更改时调用。这允许您更新渲染纹理大小和摄影机投影。
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    // 调用每帧。这是编写渲染代码的地方。
    func draw(in view: MTKView) {
        // 您将向包含在命令编码器command encoders中的GPU发送一系列命令。
        // 在一个帧中，可能有多个命令编码器，命令缓冲区command buffer管理这些编码器。
        guard
            let commandBuffer = Renderer.commandQueue.makeCommandBuffer(),
            let descriptor = view.currentRenderPassDescriptor,
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor) else {
            return
        }
        
        // drawing code goes here
        // 您可以设置GPU命令来设置管道状态和顶点缓冲区，并在网格的子网格上执行绘制调用。
        // 当您在绘制结束时提交命令缓冲区时（在：中），您告诉GPU数据和管道已就绪，是GPU接管的时候了。
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        for submesh in mesh.submeshes {
            renderEncoder.drawIndexedPrimitives(type: .triangle, indexCount: submesh.indexCount, indexType: submesh.indexType, indexBuffer: submesh.indexBuffer.buffer, indexBufferOffset: submesh.indexBuffer.offset)
        }
        
        // 1 将GPU命令添加到命令编码器后，结束其编码。
        renderEncoder.endEncoding()
        // 2 将视图的可绘制纹理呈现给GPU。
        guard let drawable = view.currentDrawable else {
            return
        }
        commandBuffer.present(drawable)
        // 3 提交命令缓冲区时，将编码的命令发送到GPU执行。
        commandBuffer.commit()
    }
}
