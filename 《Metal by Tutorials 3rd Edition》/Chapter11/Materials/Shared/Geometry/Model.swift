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

// swiftlint:disable force_try
// swiftlint:disable vertical_whitespace_opening_braces

import MetalKit

class Model: Transformable {
  var transform = Transform()
  let meshes: [Mesh]
  var tiling: UInt32 = 1
  var name: String

  init(name: String) {
    guard let assetURL = Bundle.main.url(
      forResource: name,
      withExtension: nil) else {
      fatalError("Model: \(name) not found")
    }

    let allocator = MTKMeshBufferAllocator(device: Renderer.device)
    let meshDescriptor = MDLVertexDescriptor.defaultLayout
    let asset = MDLAsset(
      url: assetURL,
      vertexDescriptor: meshDescriptor,
      bufferAllocator: allocator)
//    let (mdlMeshes, mtkMeshes) = try! MTKMesh.newMeshes(
//      asset: asset,
//      device: Renderer.device)
//      尝试重新加载顶点法线并覆盖平滑。
      
      var mtkMeshes: [MTKMesh] = []
      let mdlMeshes = asset.childObjects(of: MDLMesh.self) as? [MDLMesh] ?? []
      _ = mdlMeshes.map({ mdlMesh in
          //      现在，您将首先加载MDLMeshe，并在初始化MTKMeshe之前对其进行更改。您要求模型I/O重新计算折痕阈值为1的法线。该折痕阈值介于0和1之间，用于确定平滑度，其中1.0是不平滑的。
//          mdlMesh.addNormals(withAttributeNamed: MDLVertexAttributeNormal, creaseThreshold: 1.0)
          
//          提供的所有模型都有Blender提供的法线，但没有切线和二切线。此新代码生成并加载顶点切线和二切线值。
          mdlMesh.addTangentBasis(forTextureCoordinateAttributeNamed: MDLVertexAttributeTextureCoordinate, tangentAttributeNamed: MDLVertexAttributeTangent, bitangentAttributeNamed: MDLVertexAttributeBitangent)
          
          mtkMeshes.append(try! MTKMesh(mesh: mdlMesh, device: Renderer.device))
      })
      
    meshes = zip(mdlMeshes, mtkMeshes).map {
      Mesh(mdlMesh: $0.0, mtkMesh: $0.1)
    }
    self.name = name
  }
}

// Rendering
extension Model {
  func render(
    encoder: MTLRenderCommandEncoder,
    uniforms vertex: Uniforms,
    params fragment: Params
  ) {
    var uniforms = vertex
    uniforms.modelMatrix = transform.modelMatrix
    uniforms.normalMatrix = uniforms.modelMatrix.upperLeft
    var params = fragment
    params.tiling = tiling

    encoder.setVertexBytes(
      &uniforms,
      length: MemoryLayout<Uniforms>.stride,
      index: UniformsBuffer.index)

    encoder.setFragmentBytes(
      &params,
      length: MemoryLayout<Params>.stride,
      index: ParamsBuffer.index)

    for mesh in meshes {
      for (index, vertexBuffer) in mesh.vertexBuffers.enumerated() {
//          此代码包括发送切线缓冲区和双切线缓冲区。您应该知道发送到GPU的缓冲区的数量。在Common.h中，您已经将UniformsBuffer设置为索引11，但如果您将其定义为索引4，那么现在将与bitangent缓冲区发生冲突。
        encoder.setVertexBuffer(
          vertexBuffer,
          offset: 0,
          index: index)
      }

      for submesh in mesh.submeshes {

        // set the fragment texture here
        encoder.setFragmentTexture(
          submesh.textures.baseColor,
          index: BaseColor.index)
        //将法线纹理发送到GPU。
          encoder.setFragmentTexture(submesh.textures.normal, index: NormalTexture.index)
          
          encoder.setFragmentTexture(submesh.textures.roughness, index: 2)
          
          // 此代码将材质结构发送到片段着色器。只要你的材料结构步长小于4k字节，那么你就不需要创建和保存特殊的缓冲区。
          var material = submesh.material
          encoder.setFragmentBytes(&material, length: MemoryLayout<Material>.stride, index: MaterialBuffer.index)

        encoder.drawIndexedPrimitives(
          type: .triangle,
          indexCount: submesh.indexCount,
          indexType: submesh.indexType,
          indexBuffer: submesh.indexBuffer,
          indexBufferOffset: submesh.indexBufferOffset
        )
      }
    }
  }
}
