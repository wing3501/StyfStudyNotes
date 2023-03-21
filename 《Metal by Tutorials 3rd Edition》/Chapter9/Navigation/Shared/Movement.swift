/// Copyright (c) 2023 Razeware LLC
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

enum Settings {
    static var rotationSpeed: Float { 2.0 } // 相机在一秒钟内应该旋转多少弧度。您将计算相机在增量时间内应旋转的量。
    static var translationSpeed: Float { 3.0 } // 相机每秒应该移动的距离。
    static var mouseScrollSensitivity: Float { 0.1 } // 用于调整鼠标跟踪和滚动的设置。
    static var mousePanSensitivity: Float { 0.008 }
}
// 你的游戏可能会移动玩家的物体，而不是相机，所以让移动代码尽可能灵活。现在，您可以为任何可变换对象指定“移动”。
protocol Movement where Self: Transformable {
    
}

extension Movement {
    // 你会发现按键Pressed是否包含箭头键。如果是，则更改变换旋转值。
    func updateInput(deltaTime: Float) -> Transform {
        var transform = Transform()
        let rotationAmount = deltaTime * Settings.rotationSpeed
        let input = InputController.shared
        if input.keysPressed.contains(.leftArrow) {
            transform.rotation.y -= rotationAmount
        }
        if input.keysPressed.contains(.rightArrow) {
            transform.rotation.y += rotationAmount
        }
        return transform
    }
}


