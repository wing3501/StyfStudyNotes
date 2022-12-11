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

struct CardView<Model>: View where Model: TextImageProviding {
  private enum Constants {
    static var swipeThreshold: CGFloat { 0.25 }
  }

  private enum SwipeStatus {
    case like
    case dislike
    case none
  }

  @State private var translation: CGSize = .zero
  @State private var swipeStatus: SwipeStatus = .none

  private let model: Model
  private let onRemove: (_ model: Model, _ isLiked: Bool) -> Void

  init(
    model: Model,
    onRemove: @escaping (_ model: Model, _ isLiked: Bool) -> Void = { _, _ in }
  ) {
    self.model = model
    self.onRemove = onRemove
  }

  var body: some View {
    GeometryReader { proxy in
      VStack(alignment: .center, spacing: 0) {
        Group {
          if let image = model.image {
            Image(uiImage: image)
              .resizable()
          } else {
            Color(uiColor: .systemFill)
          }
        }
        .aspectRatio(contentMode: .fit)
        .frame(
          width: proxy.size.width,
          alignment: .center
        )
        .clipped()
        .overlay {
          Color(
            swipeStatus == .like ? .green.withAlphaComponent(0.4) :
              (swipeStatus == .dislike ? .red.withAlphaComponent(0.4) : .clear)
          )
        }
        .overlay(
          alignment: swipeStatus == .like ? .topLeading : (swipeStatus == .dislike ? .topTrailing : .top)
        ) {
          Image(
            systemName: swipeStatus == .like ? "hand.thumbsup.circle" :
              (swipeStatus == .dislike ? "hand.thumbsdown.circle" : "hand.raised.circle")
          )
          .resizable()
          .imageScale(.large)
          .frame(width: 32, height: 32)
          .foregroundColor(Color(uiColor: .systemBackground))
          .padding(8)
          .background(
            Circle()
              .background(.thinMaterial)
          )
          .clipShape(Circle())
          .padding(8)
          .opacity(swipeStatus == .none ? 0.0 : 1.0)
        }

        Text(model.title)
          .font(.title2)
          .fontWeight(.semibold)
          .multilineTextAlignment(.center)
          .padding(12)
          .minimumScaleFactor(0.7)
          .layoutPriority(1)
      }
      .background(Color(uiColor: .tertiarySystemBackground))
      .cornerRadius(16.0)
      .shadow(radius: 6)
      .offset(x: translation.width, y: 0)
      .rotationEffect(
        .degrees(translation.width / proxy.size.width * 25.0),
        anchor: .bottom
      )
      .gesture(dragGesture(on: proxy))
    }
  }

  private func gestureFraction(
    in geometry: GeometryProxy,
    from gesture: DragGesture.Value
  ) -> CGFloat {
    gesture.translation.width / geometry.size.width
  }

  private func dragGesture(on geometry: GeometryProxy) -> some Gesture {
    DragGesture()
      .onChanged { value in
        translation = value.translation

        switch gestureFraction(in: geometry, from: value) {
        case ...(-Constants.swipeThreshold):
          if swipeStatus != .dislike {
            withAnimation(.spring()) {
              swipeStatus = .dislike
            }
          }
        case Constants.swipeThreshold...:
          if swipeStatus != .like {
            withAnimation(.spring()) {
              swipeStatus = .like
            }
          }
        default:
          if swipeStatus != .none {
            withAnimation(.spring()) {
              swipeStatus = .none
            }
          }
        }
      }
      .onEnded { value in
        if abs(gestureFraction(in: geometry, from: value)) > Constants.swipeThreshold {
          onRemove(model, swipeStatus == .like)
        }
        withAnimation(.spring()) {
          translation = .zero
          swipeStatus = .none
        }
      }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CardView(model: Shirt.black)
        .preferredColorScheme(.light)
      CardView(model: Shirt.black)
        .preferredColorScheme(.dark)
    }
    .frame(width: 300, height: 400)
    .padding()
    .previewDevice("iPhone 13")
  }
}
