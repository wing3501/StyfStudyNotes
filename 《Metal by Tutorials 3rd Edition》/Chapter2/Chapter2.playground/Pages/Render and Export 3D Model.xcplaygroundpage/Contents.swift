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
//  sphereWithExtent: [0.75, 0.75, 0.75],
//  segments: [100, 100],
//  inwardNormals: false,
//  geometryType: .triangles,
//  allocator: allocator)
// 这段代码将生成一个基本圆锥体网格来代替球体。运行操场，你会看到线框圆锥体。
let mdlMesh = MDLMesh(
  coneWithExtent: [1,1,1],
  segments: [10, 10],
  inwardNormals: false,
  cap: true,
  geometryType: .triangles,
  allocator: allocator)
let mesh = try MTKMesh(mesh: mdlMesh, device: device)

// 要导出圆锥体，请在创建网格后添加以下代码：

// begin export code
// 1 Model I/O中场景的顶层是MDLAsset。可以通过向资源添加子对象（如网格、摄影机和灯光）来构建完整的场景层次。
let asset = MDLAsset()
asset.add(mdlMesh)
// 2 检查Model I/O是否可以导出.obj文件类型。
let fileExtension = "obj"
guard MDLAsset.canExportFileExtension(fileExtension) else {
  fatalError("Can't export a .\(fileExtension) format")
}
// 3 将圆锥体导出到Shared Playground Data目录。
do {
    let url = playgroundSharedDataDirectory //文档下新建Shared Playground Data文件夹
  .appendingPathComponent("primitive.\(fileExtension)")
    try asset.export(to: url)
} catch {
    fatalError("Error \(error.localizedDescription)")
}
// end export code
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

guard let submesh = mesh.submeshes.first else {
 fatalError()
}
// 这段代码告诉GPU渲染线而不是实心三角形。
renderEncoder.setTriangleFillMode(.lines)

renderEncoder.drawIndexedPrimitives(
  type: .triangle,
  indexCount: submesh.indexCount,
  indexType: submesh.indexType,
  indexBuffer: submesh.indexBuffer.buffer,
  indexBufferOffset: 0)

renderEncoder.endEncoding()
guard let drawable = view.currentDrawable else { fatalError() }
commandBuffer.present(drawable)
commandBuffer.commit()

PlaygroundPage.current.liveView = view
