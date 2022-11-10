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

import UIKit.UIImage

struct Shirt: Codable {
  let title: String
  let imageName: String
  let color: Color
  let sleeve: Sleeve
  let design: Design
  let neck: Neck

  enum CodingKeys: String, CodingKey {
    case title
    case imageName = "image_name"
    case color, sleeve, design, neck
  }

  enum Color: String, Codable {
    case black
    case blue
    case red
    case white
  }

  enum Design: String, Codable {
    case nonPlain = "non-plain"
    case plain
  }

  enum Neck: String, Codable {
    case crew
    case polo
    case vneck
  }

  enum Sleeve: String, Codable {
    case long
    case none
    case short
  }
}

extension Shirt: Hashable, Identifiable, TextImageProviding {
  var id: String {
    imageName
  }
}

extension Shirt {
  var image: UIImage? {
    UIImage(named: imageName)
  }
}

extension Shirt {
  static var black: Shirt {
    Shirt(
      title: "Plain Polo Short-Sleeve Black",
      imageName: "black-short-plain-polo",
      color: .black,
      sleeve: .short,
      design: .plain,
      neck: .polo
    )
  }
}
