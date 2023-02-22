import PlaygroundSupport //PlaygroundSupport允许您在助手编辑器中查看实时视图
import MetalKit

//创建设备检查合适的GPU：使用iOS Playground此处会报错
guard let device = MTLCreateSystemDefaultDevice() else {
    fatalError("GPU is not supported")
}

let frame = CGRect(x: 0, y: 0, width: 600, height: 600)
let view = MTKView(frame: frame, device: device)
view.clearColor = MTLClearColor(red: 1, green: 1, blue: 0.8, alpha: 1)

//Model I/O是一个与Metal和SceneKit集成的框架。
//其主要目的是加载在Blender或Maya等应用程序中创建的3D模型，并设置数据缓冲区以便于渲染。
//不加载三维模型，而是加载ModelI/O基本三维形状，也称为基本体。
//基本体通常被认为是立方体、球体、圆柱体或环面。

// 1 分配器管理网格数据的内存。
let allocator = MTKMeshBufferAllocator(device: device)
// 2 Model I/O创建具有指定大小的球体，并返回包含数据缓冲区中所有顶点信息的MDLMesh。
let mdlMesh = MDLMesh(sphereWithExtent: [0.75, 0.75, 0.75],
                      segments: [100, 100],
                      inwardNormals: false,
                      geometryType: .triangles,
                      allocator: allocator)
// 3 为了使Metal能够使用网格，可以将其从Model I/O网格转换为MetalKit网格。
let mesh = try MTKMesh(mesh: mdlMesh, device: device)

//每个帧都包含发送到GPU的命令。您可以在渲染命令编码器(render command encoder)中包装这些命令。
//命令缓冲区(render command encoder)组织这些命令编码器，命令队列(command queue)组织命令缓冲区。

// 创建命令队列
guard let commandQueue = device.makeCommandQueue() else {
    fatalError("Could not create a command queue")
}
//着色器函数是在GPU上运行的小程序。
//您可以使用Metal Shading Language 编写这些程序，该语言是C++的一个子集。
//通常，您会创建一个单独的文件，该文件的扩展名为.metal，
//专门用于着色器函数，但现在，请创建一个包含着色器函数代码的多行字符串，并将其添加到您的游乐场：
let shader = """
#include <metal_stdlib>
using namespace metal;
struct VertexIn {
  float4 position [[attribute(0)]];
};
vertex float4 vertex_main(const VertexIn vertex_in [[stage_in]])
{
  return vertex_in.position;
}
fragment float4 fragment_main() {
  return float4(1, 0, 0, 1);
}
"""
//顶点函数(vertex function)是通常操作顶点位置的地方，
//而片段函数(fragment function)是指定像素颜色的地方。

//设置包含这两个函数的Metal library
let library = try device.makeLibrary(source: shader, options: nil)
let vertexFunction = library.makeFunction(name: "vertex_main")
let fragmentFunction = library.makeFunction(name: "fragment_main")
//编译器将检查这些函数是否存在，并使其可用于管道描述符

//在Metal中，为GPU设置管道状态(pipeline state)。
//通过设置此状态，您可以告诉GPU，在状态改变之前，任何事情都不会改变。当GPU处于固定状态时，它可以更高效地运行。
//管道状态包含GPU所需的各种信息，例如应该使用哪种像素格式以及是否应该使用深度渲染。
//管道状态还保存刚刚创建的顶点和片段函数。

//然而，不直接创建管道状态，而是通过描述符创建管道状态。
//这个描述符保存了管道需要知道的所有信息，您只需更改特定渲染情况所需的属性。

let pipelineDescriptor = MTLRenderPipelineDescriptor()
//将像素格式指定为32位，颜色像素顺序为蓝色/绿色/红色/阿尔法
pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
//设置两个着色器函数。
pipelineDescriptor.vertexFunction = vertexFunction
pipelineDescriptor.fragmentFunction = fragmentFunction

//您将向GPU描述如何使用顶点描述符(vertex descriptor)在内存中布置顶点。
//Model I/O在加载球体网格时会自动创建顶点描述符，因此您可以只使用该描述符。
pipelineDescriptor.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(mesh.vertexDescriptor)
//此代码从描述符创建管道状态。
//创建管道状态需要宝贵的处理时间，因此以上所有设置都应该是一次性的。
//在实际应用程序中，您可能会创建多个管道状态来调用不同的着色函数或使用不同的顶点布局。
let pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)


//从现在起，代码应该每帧执行一次。
//MTKView有一个运行每一帧的委托方法，但是当您进行一个简单的渲染，只需填充一个静态视图时，您不需要在每一帧都刷新屏幕。

//当执行图形渲染时，GPU的最终任务是从3d场景输出单个纹理。
//该纹理类似于物理相机创建的数字图像。纹理将在每帧显示在设备的屏幕上。

//如果要实现逼真的渲染，则需要考虑阴影、照明和反射。其中每一个都需要大量计算，通常在单独的渲染过程(render passes)中完成。
//例如，阴影渲染过程(shadow render pass)将渲染三维模型的整个场景，但仅保留灰度阴影信息。
//第二次渲染过程将以全色渲染模型。然后，您可以组合阴影和颜色纹理以生成最终输出纹理，该纹理将显示在屏幕上。

//方便的是，MTKView提供了一个渲染过程描述符(render pass descriptor)，它将保存一个称为可绘制(drawable)的纹理。

// 1 创建命令缓冲区。这将存储您将要求GPU运行的所有命令。
guard let commandBuffer = commandQueue.makeCommandBuffer(),
// 2 获得对视图渲染过程描述符的引用(render pass descriptor)。描述符保存渲染目标的数据，称为附件(attachments)。每个附件都需要信息，例如要存储的纹理，以及是否在整个渲染过程中保留纹理。渲染过程描述符用于创建渲染命令编码器(render command encoder)。
let renderPassDescriptor = view.currentRenderPassDescriptor,
// 3 从命令缓冲区中，可以使用渲染过程描述符获得渲染命令编码器。渲染命令编码器保存发送到GPU所需的所有信息，以便绘制顶点。
let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
else { fatalError() }
// 这段代码为渲染编码器提供了之前设置的管道状态。
renderEncoder.setRenderPipelineState(pipelineState)

// 前面加载的球体网格包含一个包含简单顶点列表的缓冲区。
// 将此缓冲区提供给渲染编码器
// offset是缓冲区中顶点信息开始的位置。index是GPU顶点着色器函数如何定位此缓冲区。
renderEncoder.setVertexBuffer(mesh.vertexBuffers[0].buffer, offset: 0, index: 0)

//网格由子网格组成。当艺术家创建3D模型时，他们使用不同的材质组进行设计。这些转换为子网格。例如，如果要渲染汽车对象，则可能会有闪亮的车身和橡胶轮胎。一种材料是闪亮的油漆，另一种是橡胶。导入时， Model I/O将创建两个不同的子网格，这些子网格将索引到该组的正确顶点。一个顶点可以由不同的子网格渲染多次。该球体只有一个子网格，因此将仅使用一个子网格。
guard let submesh = mesh.submeshes.first else {
    fatalError()
}

//在这里，指示GPU渲染一个顶点缓冲区，该缓冲区由顶点按子网格索引信息的正确顺序放置的三角形组成。
//这段代码不会进行实际渲染，直到GPU接收到所有命令缓冲区的命令后才会进行渲染。
renderEncoder.drawIndexedPrimitives(
  type: .triangle,
  indexCount: submesh.indexCount,
  indexType: submesh.indexType,
  indexBuffer: submesh.indexBuffer.buffer,
  indexBufferOffset: 0)

//要完成向渲染命令编码器发送命令并完成帧，请添加以下代码：
// 1 告诉渲染编码器不再有绘制调用，并结束渲染过程。
renderEncoder.endEncoding()
// 2 您可以从MTKView中获取drawable。MTKView由核心动画CAMetalLayer支持，该层拥有可绘制的纹理，Metal可以读取和写入该纹理。
guard let drawable = view.currentDrawable else {
  fatalError()
}
// 3 要求命令缓冲区显示MTKView的可绘制文件并提交给GPU。
commandBuffer.present(drawable)
commandBuffer.commit()

PlaygroundPage.current.liveView = view

// 总结
// * 渲染是指从三维点创建图像。
// * 帧是GPU每秒渲染60次（最佳）的图像。
// * device是硬件GPU的软件抽象。
// * 三维模型由顶点网格组成，其中着色材质分组在子网格(submeshes)中。
// * 在应用程序开始时创建命令队列。此操作组织着 创建每个帧的命令缓冲区和命令编码器。
// * 着色器函数是在GPU上运行的程序。在这些程序中定位顶点并为像素着色。
// * 渲染管道状态将GPU固定到特定状态(render pipeline state)。它可以设置GPU应该运行哪些着色器函数以及顶点布局的格式。

