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

import UIKit

// ✅ @globalActor的使用
// 可以在任何地方使用单例方法访问ImageDatabase.shared
// 可以用使用@ImageDatabase注解方法，使方面通过ImageDatabase的串行执行器执行
@globalActor actor ImageDatabase {
  static let shared = ImageDatabase()
  
  let imageLoader = ImageLoader() // ImageLoader不会引入线程问题，因为本身是actor
//  private let storage = DiskStorage()
  private var storage: DiskStorage!
  private var storedImagesIndex: [String] = []
  
  @MainActor private(set) var inDiskAccess: AsyncStream<Int>? // ✅ 使用MainActor在主线程上给异步序列生产值
    private var inDiskAcccessContinuation: AsyncStream<Int>.Continuation?
    private var inDiskAccessCounter = 0 {
      didSet {
        inDiskAcccessContinuation?.yield(inDiskAccessCounter)
      }
    }
  
  // 防止外部创建
  private init() {
    
  }
  
  deinit {
    inDiskAcccessContinuation?.finish()
  }
  
  func setUp() async throws {
    storage = await DiskStorage()
    for fileURL in try await storage.persistedFiles() {
      storedImagesIndex.append(fileURL.lastPathComponent)
    }
    
    let accessStream = AsyncStream<Int> { continuation in
      inDiskAcccessContinuation = continuation
    }
    await MainActor.run { inDiskAccess = accessStream }
    
    await imageLoader.setUp()
  }
  
  func store(image: UIImage, forKey key: String) async throws {
    guard let data = image.pngData() else {
      throw "Could not save image \(key)"
    }
    let fileName = DiskStorage.fileName(for: key)
    try await storage.write(data, name: fileName)
    storedImagesIndex.append(fileName)
  }
  
  func image(_ key: String) async throws -> UIImage {
    if await imageLoader.cache.keys.contains(key) {
      print("Cached in-memory")
      return try await imageLoader.image(key)
    }
    
    do { // 1
      let fileName = DiskStorage.fileName(for: key)
      if !storedImagesIndex.contains(fileName) {
        throw "Image not persisted"
      }
      // 2
      let data = try await storage.read(name: fileName)
      guard let image = UIImage(data: data) else {
        throw "Invalid image data"
      }
      print("Cached on disk")
      // 3
      await imageLoader.add(image, forKey: key)
      inDiskAccessCounter += 1
      return image
    } catch {
      // 4
      let image = try await imageLoader.image(key)
      try await store(image: image, forKey: key)
      return image
    }
  }
  
  func clear() async {
    for name in storedImagesIndex {
      try? await storage.remove(name: name)
    }
    storedImagesIndex.removeAll()
  }
  
  func clearInMemoryAssets() async {
   await imageLoader.clear()
 }
}
