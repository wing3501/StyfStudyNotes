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
import RegexBuilder



class ProductionsDataProvider {

  func loadData() -> [MarvelProductionItem] {

    let idFieldRef = Reference(Substring.self)
    let titleFieldRef = Reference(Substring.self)
    let yearFieldRef = Reference(Substring.self)
    let premieredOnFieldRef = Reference(Substring.self)
    let urlFieldRef = Reference(URL.self)
    let imdbRatingFieldRef = Reference(Float.self)

    var marvelProductions = [MarvelProductionItem]()

    var content: String = ""
    if let filePath = Bundle.main.path(forResource: "MarvelMovies", ofType: nil) {
      let fileURL = URL(fileURLWithPath: filePath)
      do {
        content = try String(contentsOf: fileURL)
      } catch {
            return []
      }
    }

    // swiftlint:disable opening_brace
    let fieldSeparator = ChoiceOf {
      /[\s\t]{2,}/
      /\t/
    }

    let idField = /tt\d+/

    let titleField = OneOrMore {
      NegativeLookahead { fieldSeparator }
      CharacterClass.any
    }

    let yearField = /\(.+\)/

    let premieredOnField = OneOrMore {
      NegativeLookahead { fieldSeparator }
      CharacterClass.any
    }

    let urlField = /http.+jpg/

    let imdbRatingField = OneOrMore {
      NegativeLookahead { fieldSeparator }
      CharacterClass.any
    }

    let recordMatcher = Regex {
      Capture(as: idFieldRef) { idField }
      fieldSeparator
      Capture(as: titleFieldRef) { titleField }
      fieldSeparator
      Capture(as: yearFieldRef) { yearField }
      fieldSeparator
      Capture(as: premieredOnFieldRef) { premieredOnField }
      fieldSeparator
      TryCapture(as: urlFieldRef) {
        urlField
      } transform: {
        URL(string: String($0))
      }
      fieldSeparator
      TryCapture(as: imdbRatingFieldRef) {
        imdbRatingField
      } transform: {
        Float(String($0))
      }
      /\n/
    }

    let matches = content.matches(of: recordMatcher)
    for match in matches {
      let production = MarvelProductionItem(
        imdbID: String(match[idFieldRef]),
        title: String(match[titleFieldRef]),
        productionYear: ProductionYearInfo.fromString(String(match[yearFieldRef])),
        premieredOn: PremieredOnInfo.fromString(String(match[premieredOnFieldRef])),
        posterURL: match[urlFieldRef],
        imdbRating: match[imdbRatingFieldRef])

      marvelProductions.append(production)
    }

    return marvelProductions
  }
}
// swiftlint:enable opening_brace
