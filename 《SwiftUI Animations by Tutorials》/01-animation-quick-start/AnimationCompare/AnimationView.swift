/// Copyright (c) 2022 Kodeco Inc.
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

struct AnimationView: View {
  var animation: AnimationData
  @Binding var location: Double
  var slowMotion = false

  var currentAnimation: Animation {
    switch animation.type {
    case .easeIn:
      return .easeIn(duration: animation.length)
    case .easeOut:
      return .easeOut(duration: animation.length)
    case .easeInOut:
      return .easeInOut(duration: animation.length)
    default:
      return .linear(duration: animation.length)
    }
  }
  
  var body: some View {
    GeometryReader { proxy in
      Group {
        //Text("Animation")
        HStack {
          Image(systemName: "gear.circle")
            .rotationEffect(.degrees(360 * location))
          Image(systemName: "star.fill")
            .offset(x: proxy.size.width * location * 0.8)
        }
        .font(.title)
//        .animation(.linear(duration: animation.length), value: location)
//        .animation(currentAnimation, value: location)
//        .animation(currentAnimation.delay(animation.delay), value: location)
        // 值小于1将导致动画速度减慢，而值大于1将加快动画速度。
        .animation(currentAnimation.delay(animation.delay).speed(slowMotion ? 0.25 : 1.0), value: location)
      }
    }
  }
}

struct AnimationView_Previews: PreviewProvider {
  static var previews: some View {
    let animation = AnimationData(type: .linear, length: 1.0, delay: 0.0)

    AnimationView(
      animation: animation,
      location: .constant(0.0)
    )
  }
}
