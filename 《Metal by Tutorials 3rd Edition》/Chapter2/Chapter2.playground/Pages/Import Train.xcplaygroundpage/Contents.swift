import PlaygroundSupport
import MetalKit


guard let device = MTLCreateSystemDefaultDevice() else {
 fatalError("GPU is not supported")
}

let frame = CGRect(x: 0, y: 0, width: 600, height: 600)
let view = MTKView(frame: frame, device: device)
view.clearColor =
  MTLClearColor(red: 1, green: 1, blue: 0.8, alpha: 1)
view.isPaused = true
view.enableSetNeedsDisplay = false

let allocator = MTKMeshBufferAllocator(device: device)
//let mdlMesh = MDLMesh(
//  coneWithExtent: [1, 1, 1],
//  segments: [10, 10],
//  inwardNormals: false,
//  cap: true,
//  geometryType: .triangles,
//  allocator: allocator)

guard let assetURL = Bundle.main.url(
  forResource: "train",
  withExtension: "obj") else {
  fatalError()
}

// Metal使用描述符作为创建对象的常用模式。在上一章中，当您设置管道描述符来描述管道状态时，您看到了这种模式。在加载模型之前，您将告诉Metal如何通过创建顶点描述符来布局顶点和其他数据。

// 1 创建一个顶点描述符，用于配置对象需要了解的所有属性。 可以使用相同的值或重新配置的值重用此顶点描述符，以实例化不同的对象。
let vertexDescriptor = MTLVertexDescriptor()
// 2 您告诉描述符xyz位置数据应该加载为float3，这是一种由三个Float值组成的simd数据类型。
vertexDescriptor.attributes[0].format = .float3
// 3 偏移量指定此特定数据将在缓冲区中的何处开始。
vertexDescriptor.attributes[0].offset = 0
// 4 通过渲染编码器将顶点数据发送到GPU时，将其发送到MTLBuffer中，并通过索引标识缓冲区。有31个缓冲区可用，Metal在缓冲区参数表中跟踪它们。此处使用缓冲区0，以便顶点着色器函数能够将缓冲区0中的传入顶点数据与此顶点布局匹配。
vertexDescriptor.attributes[0].bufferIndex = 0

// 1 这里，您指定缓冲区0的步幅。步幅是每组顶点信息之间的字节数。回到前面描述位置、法线和纹理坐标信息的图，每个顶点之间的步幅将是float3+float3+float2。然而，这里你只加载位置数据，所以要到达下一个位置，你要跳一步float3。
vertexDescriptor.layouts[0].stride = MemoryLayout<SIMD3<Float>>.stride
// 2   Model I/O需要稍微不同的格式顶点描述符，因此您可以从Metal顶点描述符创建一个新的Model I/O描述符。如果您有一个模型I/O描述符并且需要一个Metal描述符，MTKMetalVertexDescriptorFromModelIO（）提供了一个解决方案。
let meshDescriptor = MTKModelIOVertexDescriptorFromMetal(vertexDescriptor)
// 3
(meshDescriptor.attributes[0] as! MDLVertexAttribute).name = MDLVertexAttributePosition
// 顶点描述符描述模型顶点的缓冲区格式。使用顶点描述符设置GPU管道状态，以便GPU知道顶点缓冲区格式是什么。
let asset = MDLAsset(
  url: assetURL,
  vertexDescriptor: meshDescriptor,
  bufferAllocator: allocator)
let mdlMesh =
  asset.childObjects(of: MDLMesh.self).first as! MDLMesh

let mesh = try MTKMesh(mesh: mdlMesh, device: device)

guard let commandQueue = device.makeCommandQueue() else {
  fatalError("Could not create a command queue")
}

let shader = """
#include <metal_stdlib>
using namespace metal;

struct VertexIn {
  float4 position [[attribute(0)]];
};

vertex float4
  vertex_main(const VertexIn vertex_in [[stage_in]]) {
  return vertex_in.position;
}

fragment float4 fragment_main() {
  return float4(1, 0, 0, 1);
}
"""

let library =
  try device.makeLibrary(source: shader, options: nil)
let vertexFunction = library.makeFunction(name: "vertex_main")
let fragmentFunction =
  library.makeFunction(name: "fragment_main")

let pipelineDescriptor = MTLRenderPipelineDescriptor()
pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
pipelineDescriptor.vertexFunction = vertexFunction
pipelineDescriptor.fragmentFunction = fragmentFunction

pipelineDescriptor.vertexDescriptor =
    MTKMetalVertexDescriptorFromModelIO(mesh.vertexDescriptor)

let pipelineState =
  try device.makeRenderPipelineState(
    descriptor: pipelineDescriptor)

guard let commandBuffer = commandQueue.makeCommandBuffer(),
  let renderPassDescriptor = view.currentRenderPassDescriptor,
  let renderEncoder =
    commandBuffer.makeRenderCommandEncoder(
    descriptor:  renderPassDescriptor)
else { fatalError() }

renderEncoder.setRenderPipelineState(pipelineState)

renderEncoder.setVertexBuffer(
  mesh.vertexBuffers[0].buffer,
  offset: 0,
  index: 0)
renderEncoder.setTriangleFillMode(.lines)

//guard let submesh = mesh.submeshes.first else {
// fatalError()
//}
//
//renderEncoder.drawIndexedPrimitives(
//  type: .triangle,
//  indexCount: submesh.indexCount,
//  indexType: submesh.indexType,
//  indexBuffer: submesh.indexBuffer.buffer,
//  indexBufferOffset: 0)

// 目前，您只渲染第一个子网格，但由于火车有多个材质组，因此需要循环子网格以渲染所有子网格。
for submesh in mesh.submeshes {
  renderEncoder.drawIndexedPrimitives(
    type: .triangle,
    indexCount: submesh.indexCount,
    indexType: submesh.indexType,
    indexBuffer: submesh.indexBuffer.buffer,
    indexBufferOffset: submesh.indexBuffer.offset
) }

renderEncoder.endEncoding()
guard let drawable = view.currentDrawable else { fatalError() }
commandBuffer.present(drawable)
commandBuffer.commit()

PlaygroundPage.current.liveView = view
