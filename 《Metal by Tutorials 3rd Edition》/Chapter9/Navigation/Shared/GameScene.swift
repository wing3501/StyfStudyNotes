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

import MetalKit

struct GameScene {
    lazy var house: Model = {
        Model(name: "lowpoly-house.obj")
    }()
    
    lazy var ground: Model = {
        var ground = Model(name: "plane.obj")
        ground.tiling = 16
        ground.scale = 40
        return ground
    }()
    lazy var models: [Model] = [ground, house]
//    var camera = FPCamera()
//    var camera = ArcballCamera()
    var camera = OrthographicCamera()
    
    init() {
        camera.position = [0, 1.5, -5]
        // 使用弧形球相机，可以设置目标和距离以及位置。
//        camera.distance = length(camera.position)
//        camera.target = [0, 1.2, 0]
        // 使用自上而下的相机
//        camera.position = [3, 2, 0]
//        camera.rotation.y = -.pi / 2
        
        camera.position = [0, 2, 0]
        camera.rotation.x = .pi / 2
    }
    
    mutating func update(deltaTime: Float) {
        ground.scale = 40
//        ground.rotation.y = sin(deltaTime)
//        house.rotation.y = sin(deltaTime)
        // 现在，你可以很容易地旋转相机，而不是旋转地面和房子。
//        camera.rotation.y = sin(deltaTime)
        camera.update(deltaTime: deltaTime)
        
//        if InputController.shared.keysPressed.contains(.keyH) {
//            print("H key pressed")
//        }
    }
    
    mutating func update(size: CGSize) {
        camera.update(size: size)
    }
}
