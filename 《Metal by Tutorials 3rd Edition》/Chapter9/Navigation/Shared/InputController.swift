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

import GameController

class InputController {
    static let shared = InputController()
    // 在该set中，InputController会跟踪当前按下的所有键。
    var keysPressed: Set<GCKeyCode> = []
    // 将这些属性添加到InputController以记录鼠标移动：
    var leftMouseDown = false // 跟踪玩家左键点击
    var mouseDelta = Point.zero // 自上次追踪到的移动后的移动。
    var mouseScroll = Point.zero// 跟踪玩家使用鼠标滚轮滚动的次数。
    
    // 要跟踪键盘，您需要设置一个观察者。
    private init() {
        // 在这里，当键盘第一次连接到应用程序时，您添加了一个观察者来设置keyChangedHandler。当玩家按下或举起一个键时，keyChangedHandler代码会运行，并从集合中添加或删除该键。
        let center = NotificationCenter.default
        center.addObserver(forName: .GCKeyboardDidConnect, object: nil, queue: nil) { notification in
            let keyboard = notification.object as? GCKeyboard
            keyboard?.keyboardInput?.keyChangedHandler = { _, _, keyCode, pressed in
                if pressed {
                    self.keysPressed.insert(keyCode)
                }else {
                    self.keysPressed.remove(keyCode)
                }
            }
        }
        //在这里，仅在macOS上，您可以通过处理任何按键并告诉系统在按键时不需要采取行动来中断视图的响应器链。iPadOS不需要这样做，因为iPad不会发出键盘噪音。
        
        // 在这段代码中，您可以将键添加到keysPressed中，而不用使用观察器。然而，这在iPadOS上不起作用，而且GCKeyCode比NSEvent提供的原始键值更容易读取。
        #if os(macOS)
        NSEvent.addLocalMonitorForEvents(matching: [.keyUp, .keyDown]) { _ in
            nil
        }
        #endif
        
        center.addObserver(forName: .GCMouseDidConnect, object: nil, queue: nil) { notification in
            let mouse = notification.object as? GCMouse
            // 1 当用户按住鼠标左键时进行记录。
            mouse?.mouseInput?.leftButton.pressedChangedHandler = { _, _, pressed in
                self.leftMouseDown = pressed
            }
            // 2 跟踪鼠标移动。
            mouse?.mouseInput?.mouseMovedHandler = { _, deltaX, deltaY in
                self.mouseDelta = Point(x: deltaX, y: deltaY)
            }
            // 3 记录滚轮的移动。xValue和yValue是介于-1和1之间的标准化值。如果您使用游戏控制器而不是鼠标，第一个参数是dpad，它会告诉您哪个方向板元素发生了更改
            mouse?.mouseInput?.scroll.valueChangedHandler = { _, xValue, yValue in
                self.mouseScroll.x = xValue
                self.mouseScroll.y = yValue
            }
        }
    }
    
    struct Point {
        var x: Float
        var y: Float
        static let zero = Point(x: 0, y: 0)
    }
    
    
}




