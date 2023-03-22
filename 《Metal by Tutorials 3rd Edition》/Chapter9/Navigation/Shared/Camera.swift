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

import CoreGraphics
// 摄影机有一个位置和旋转，因此它们应该符合“可变换”。所有相机都有一个投影和视图矩阵，以及在窗口大小更改和每个帧更新时执行的方法。
protocol Camera: Transformable {
    var projectionMatrix: float4x4 { get }
    var viewMatrix: float4x4 { get }
    mutating func update(size: CGSize)
    mutating func update(deltaTime: Float)
}
// 您创建了第一人称相机。最终，当您按下W键时，此相机将向前移动。
struct FPCamera: Camera {
    var transform = Transform()
    
    var aspect: Float = 1.0
    var fov = Float(70).degreesToRadians
    var near: Float = 0.1
    var far: Float = 100
    var projectionMatrix: float4x4 {
        float4x4(projectionFov: fov, near: near, far: far, aspect: aspect)
    }
    
//    var viewMatrix: float4x4 {
//        (float4x4(rotation: rotation) * float4x4(translation: position)).inverse
//    }
    //然而，你不希望第一人称相机中的相机绕着世界原点旋转：你希望它绕着自己的原点旋转
    //在这里，您可以反转矩阵乘法的顺序，以便相机绕其自身原点旋转。
    var viewMatrix: float4x4 {
        (float4x4(translation: position) * float4x4(rotation: rotation)).inverse
    }
    
    mutating func update(size: CGSize) {
        aspect = Float(size.width / size.height)
    }
    // 此方法在每帧重新定位相机
    mutating func update(deltaTime: Float) {
        // 使用在“Movement”中计算的变换更新摄影机的旋转。
        let transform = updateInput(deltaTime: deltaTime)
        rotation += transform.rotation
        position += transform.position
    }
}

extension FPCamera: Movement {}

struct ArcballCamera: Camera {
    var transform = Transform()
    
    var aspect: Float = 1.0
    var fov = Float(70).degreesToRadians
    var near: Float = 0.1
    var far: Float = 100
    var projectionMatrix: float4x4 {
        float4x4(projectionFov: fov, near: near, far: far, aspect: aspect)
    }
    
    var viewMatrix: float4x4 {
        let matrix: float4x4
        if target == position {
            matrix = (float4x4(translation: target) * float4x4(rotationYXZ: rotation)).inverse
        }else {
            matrix = float4x4(eye: position, center: target, up: [0, 1, 0])
        }
        return matrix
    }
    
    let minDistance: Float = 0.0
    let maxDistance: Float = 20
    var target: float3 = [0, 0, 0]
    var distance: Float = 2.5
    
    mutating func update(size: CGSize) {
        aspect = Float(size.width / size.height)
    }
    // 此方法在每帧重新定位相机
    mutating func update(deltaTime: Float) {
        // 根据鼠标滚动值更改距离。
        let input = InputController.shared
        let scrollSensitivity = Settings.mouseScrollSensitivity
        distance -= (input.mouseScroll.x + input.mouseScroll.y) * scrollSensitivity
        distance = min(minDistance, distance)
        distance = max(minDistance, distance)
        input.mouseScroll = .zero
        // 如果玩家用鼠标左键拖动，则更新相机的旋转值。
        if input.leftMouseDown {
            let sensitivity = Settings.mouseScrollSensitivity
            rotation.x += input.mouseDelta.y * sensitivity
            rotation.y += input.mouseDelta.x * sensitivity
            rotation.x = max(-.pi / 2, min(rotation.x, .pi / 2))
            input.mouseDelta = .zero
        }
        // 完成计算以旋转距离矢量，并将目标位置添加到新矢量中。
        let rotateMatrix = float4x4(rotationYXZ: [-rotation.x, rotation.y, 0])
        let distanceVector = float4(0, 0, -distance, 0)
        let rotateVector = rotateMatrix * distanceVector
        position = target + rotateVector.xyz
    }
}

//有时候，在一个大场景中看到正在发生的事情有点困难。为了帮助实现这一点，您将构建一个自上而下的相机，它可以显示整个场景，而不会出现任何透视失真。
struct OrthographicCamera: Camera, Movement {
    var transform = Transform()
    // aspect是窗口的宽度与高度之比。viewSize是场景的单位大小。您将计算出长方体形状的投影截头体。
    var aspect: CGFloat = 1
    var viewSize: CGFloat = 10
    var near: Float = 0.1
    var far: Float = 100
    
    var viewMatrix: float4x4 {
        (float4x4(translation: position) * float4x4(rotation: rotation)).inverse
    }
    
    var projectionMatrix: float4x4 {
        // 在这里，您可以使用视图大小和纵横比计算截头体前面的矩形
        let rect = CGRect(x: -viewSize * aspect * 0.5, y: viewSize * 0.5, width: viewSize * aspect, height: viewSize)
        return float4x4(orthographic: rect, near: near, far: far)
    }
    
    mutating func update(size: CGSize) {
        aspect = size.width / size.height
    }
    
    mutating func update(deltaTime: Float) {
//        使用前面的Movement代码使用WASD键在场景中移动。您不需要旋转，因为您要将相机定位为自上而下。使用鼠标滚动可以更改视图大小，从而可以放大和缩小场景。
        let transform = updateInput(deltaTime: deltaTime)
        position += transform.position
        let input = InputController.shared
        let zoom = input.mouseScroll.x + input.mouseScroll.y
        viewSize -= CGFloat(zoom)
        input.mouseScroll = .zero
    }
}
