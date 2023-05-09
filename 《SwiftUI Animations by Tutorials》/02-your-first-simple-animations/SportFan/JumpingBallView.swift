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

import SwiftUI

struct JumpingBallView: View {
  @State private var isAnimating = false
  @State private var rotation = 0.0
  @State private var scale = 1.0
  
  var currentYOffset: CGFloat {
    isAnimating ? Constants.maxOffset - Constants.ballSize / 2 - Constants.ballSpacing : -Constants.ballSize / 2 - Constants.ballSpacing
  }
  
    var body: some View {
        Ball()
        .rotationEffect(Angle(degrees: rotation), anchor: .center)
        .scaleEffect(x: 1.0 / scale, y: scale, anchor: .bottom)//当球碰到底部的表面时，通过沿x轴与y轴相反的方向缩放球，使球在其底侧挤压。
      // 顺序很重要
        .offset(y: currentYOffset)
        .onAppear {
          animate()
        }
    }
  
  private func animate() {
    withAnimation(.easeInOut(duration: Constants.jumpDuration).repeatForever()) {
      isAnimating = true
    }
    // 若要使球无限期旋转而不改变其方向，请禁用自动反转。通过将持续时间加倍，你可以迫使球在返回顶部位置之前进行一次完整的旋转。
    withAnimation(.linear(duration: Constants.jumpDuration * 2).repeatForever(autoreverses: false)) {
      rotation = 360
    }
    // 你可以使用.seaseOut来挤压球，因为你希望球在撞击表面时稍微减速，以放大效果。使比例小于1会在水平方向上增加球，在垂直方向上缩小球，模仿挤压。
    withAnimation(.easeOut(duration: Constants.jumpDuration).repeatForever()) {
      scale = 0.85
    }
  }
}

struct JumpingBallView_Previews: PreviewProvider {
    static var previews: some View {
        JumpingBallView()
    }
}
