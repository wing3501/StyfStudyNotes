/// Copyright (c) 2020 Razeware LLC
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
import QuickLook


class File: NSObject {
  let url: URL

  init(url: URL) {
    self.url = url
  }

  var name: String {
    url.deletingPathExtension().lastPathComponent
  }
}

// MARK: - Helper extension
extension File {
  static func loadFiles() -> [File] {
    let fileManager = FileManager.default
    guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }

    let urls: [URL]
    do {
      urls = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
    } catch {
      fatalError("Couldn't load files from documents directory")
    }

    return urls.map { File(url: $0) }
  }

  static func copyResourcesToDocumentsIfNeeded() {
    guard UserDefaults.standard.bool(forKey: "didCopyResources") else {
      let files = [
        Bundle.main.url(forResource: "Cover Charm", withExtension: "docx"),
        Bundle.main.url(forResource: "Light Charm", withExtension: "pdf"),
        Bundle.main.url(forResource: "Parapluie Spell", withExtension: "txt"),
        Bundle.main.url(forResource: "Water Spell", withExtension: "html"),
        Bundle.main.url(forResource: "Dark Magic", withExtension: "zip")
      ]
      files.forEach {
        guard let url = $0 else { return }
        do {
          let newURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(url.lastPathComponent)
          try FileManager.default.copyItem(at: url, to: newURL)
        } catch {
          print(error.localizedDescription)
        }
      }

      UserDefaults.standard.set(true, forKey: "didCopyResources")
      return
    }
  }
}

// MARK: - QLPreviewItem
extension File: QLPreviewItem {
  var previewItemURL: URL? {
    url
  }
}

// MARK: - QuickLookThumbnailing
extension File {
  func generateThumbnail(completion: @escaping (UIImage) -> Void) {
    // 1
    let size = CGSize(width: 128, height: 102)
    let scale = UIScreen.main.scale
    // 2
    let request = QLThumbnailGenerator.Request(
      fileAt: url,
      size: size,
      scale: scale,
      representationTypes: .all)
    
    // 3
    let generator = QLThumbnailGenerator.shared
//    generator.generateBestRepresentation(for: request) { thumbnail, error in
      generator.generateRepresentations(for: request) { thumbnail, _, error in
          // ✅ 先回调一个低质量的，再回调高质量的
      if let thumbnail = thumbnail {
        completion(thumbnail.uiImage)
      } else if let error = error {
        // Handle error
        print(error)
      }
    }
  }
}
