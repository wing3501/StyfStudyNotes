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

import SwiftUI

struct CardsStackView<Model>: View where Model: TextImageProviding & Hashable {
  let models: [Model]
  let onRemove: (_ model: Model, _ isLiked: Bool) -> Void

  var body: some View {
    GeometryReader { proxy in
      ZStack {
        ForEach(
          Array(models.enumerated()),
          id: \.element
        ) { index, item in
          if (models.count - 3)...models.count ~= index {
            CardView(
              model: item
            ) { model, isLiked in
              withAnimation(.spring()) {
                onRemove(model, isLiked)
              }
            }
            .frame(
              width: cardWidth(in: proxy, index: index),
              height: Constants.cardHeight
            )
            .offset(x: 0, y: cardOffset(in: proxy, index: index))
          }
        }
      }
      .frame(width: proxy.size.width, alignment: .center)
    }
    .frame(height: Constants.cardHeight + 16.0)
    .transition(.scale)
    .padding(.horizontal)
  }

  private func cardWidth(in geometry: GeometryProxy, index: Int) -> CGFloat? {
    let offset = cardOffset(in: geometry, index: index)

    let addedValue: CGFloat
    if geometry.size.width > 1536 {
      addedValue = 700
    } else if geometry.size.width > 1024 {
      addedValue = 400
    } else if geometry.size.width > 512 {
      addedValue = 100
    } else {
      addedValue = 0
    }

    let result = geometry.size.width - offset - addedValue

    if result <= 0 {
      return nil
    } else {
      return result
    }
  }

  private func cardOffset(in geometry: GeometryProxy, index: Int) -> CGFloat {
    CGFloat(models.count - 1 - index) * 12
  }
}

private enum Constants {
  static let cardHeight: CGFloat = 380
}

struct CardsStackView_Previews: PreviewProvider {
  static var previews: some View {
    CardsStackView(
      models: [Shirt.black]
    ) { _, _ in }
  }
}
