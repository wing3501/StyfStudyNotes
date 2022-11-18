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
import QuickLook

struct Document {
  let url: URL

  var name: String {
    url.lastPathComponent
  }
}

extension Document: Identifiable {
  var id: URL {
    url
  }
}

// MARK: - Static helper methods
extension Document {
  static let documents = [
    Bundle.main.url(forResource: "zombiethumb", withExtension: "jpg"),
    Bundle.main.url(forResource: "humanthumb", withExtension: "pdf"),
    Bundle.main.url(forResource: "thumbsup", withExtension: "txt"),
    Bundle.main.url(forResource: "thumbsdown", withExtension: "md"),
    Bundle.main.url(forResource: "thumbsdown", withExtension: "html"),
    Bundle.main.url(forResource: "greenthumb", withExtension: "thumb"),
    Bundle.main.url(forResource: "test", withExtension: "docx"),
    Bundle.main.url(forResource: "test", withExtension: "xlsx")
  ]
  .compactMap { $0 }
  .map { Document(url: $0) }
}


// MARK: - QLThumbnailGenerator
extension Document {
  // ✅ QLThumbnailGenerator 生成缩略图
  func generateThumbnail(
    size: CGSize,
    scale: CGFloat,
    completion: @escaping (UIImage) -> Void
  ) {
    // print("displayScale:\(scale)")
    // 1
    let request = QLThumbnailGenerator.Request(
      fileAt: url,
      size: size,
      scale: scale,
      representationTypes: .all)// 这里取了所有 。.icon, .lowQualityThumbnail and .thumbnail ，太慢的话可以指定一个
    // 这里指定了all,所以会生成3种，可能有几种会失败。
    // ⚠️ 指定all的好处就是至少能生成一个能用。坏处是生成的回调会回调多次，UI也会更新多次
    
    
    // 2
    let generator = QLThumbnailGenerator.shared
    generator.generateRepresentations(for: request) { thumbnail, _, error in
      // 3
      if let thumbnail = thumbnail {
        print("\(name) thumbnail generated")
        completion(thumbnail.uiImage)
      } else if let error = error {
        print("\(name) - \(error)")
      }
    }

  }
}
