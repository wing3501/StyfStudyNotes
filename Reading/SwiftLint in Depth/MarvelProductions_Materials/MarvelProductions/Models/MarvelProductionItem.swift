/// Copyright (c) 2023 Kodeco Inc.
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

public struct MarvelProductionItem {
  let id = UUID()
  let imdbID: String
  let title: String
  let productionYear: ProductionYearInfo
  let premieredOn: PremieredOnInfo
  let posterURL: URL?
  let imdbRating: Float?

  public init(
    imdbID: String,
    title: String,
    productionYear: ProductionYearInfo,
    premieredOn: PremieredOnInfo,
    posterURL: URL?,
    imdbRating: Float?
  ) {
    self.imdbID = imdbID
    self.title = title
    self.productionYear = productionYear
    self.premieredOn = premieredOn
    self.posterURL = posterURL
    self.imdbRating = imdbRating
  }

  static func sample() -> MarvelProductionItem {
    MarvelProductionItem.init(
      imdbID: "tt10234724",
      title: "Moon Knight",
      productionYear: ProductionYearInfo.produced(year: 2022),
      premieredOn: PremieredOnInfo.definedDate(Date.fromString("Mar 30, 2022")),
      posterURL: URL(string: "https://m.media-amazon.com/images/M/MV5BYTc5OWNhYjktMThlOS00ODUxLTgwNDQtZjdjYjkyM2IwZTZlXkEyXkFqcGdeQXVyNTA3MTU2MjE@._V1_Ratio0.6800_AL_.jpg"),
      imdbRating: 7.3)
  }
}
