/// Copyright (c) 2021 Razeware LLC
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

import Foundation
import UIKit

actor EmojiArtModel: ObservableObject {
  @Published @MainActor private(set) var imageFeed: [ImageFile] = [] // 将imageFeed从EmojiArtModel的串行执行器，移到了MainActor

  private(set) var verifiedCount = 0
  
  func verifyImages() async throws {
    try await withThrowingTaskGroup(of: Void.self) { group in
      await imageFeed.forEach { file in
        group.addTask { [unowned self] in
          try await Checksum.verify(file.checksum)
//          self.verifiedCount += 1 // ❌ 并发修改状态，触发数据竞争
//          ❌ Actor-isolated property 'verifiedCount' can not be mutated from a Sendable closure
          // ✅ 解决在actor外部环境，修改actor属性
          await self.increaseVerifiedCount()
        }
      }
      try await group.waitForAll() // ✅ 这里必须使用try,否则编译器觉得是一个不抛出异常的group，而不再往上抛出异常
    }
  }
  
  private func increaseVerifiedCount() {
   verifiedCount += 1
 }
  // ✅ loadImages和downloadImage没有修改状态，所以是安全的，可以标记为非隔离。性能上会有提升，并发调用的时候，速度会提升
  nonisolated func loadImages() async throws {
    await MainActor.run {
     imageFeed.removeAll()
    }
    guard let url = URL(string: "http://localhost:8080/gallery/images") else {
      throw "Could not create endpoint URL"
    }
    let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw "The server responded with an error."
    }
    guard let list = try? JSONDecoder().decode([ImageFile].self, from: data) else {
      throw "The server response was not recognized."
    }
    await MainActor.run {
     imageFeed = list
   }
  }

  /// Downloads an image and returns its content.
  nonisolated func downloadImage(_ image: ImageFile) async throws -> Data {
    guard let url = URL(string: "http://localhost:8080\(image.url)") else {
      throw "Could not create image URL"
    }
    let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)

    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw "The server responded with an error."
    }
    return data
  }
}
