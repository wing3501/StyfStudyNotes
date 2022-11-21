//
//  AnimationPlacement.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/11/21.
//  When .animation animates more (or less) than it’s supposed to
//  https://oleb.net/2022/animation-modifier-position/
//  动画修饰符的不同表现
//  ✅ 对于“非渲染”型View,animation修饰符位置对是否做动画无关紧要
//  In iOS 16/macOS 13, the placement of the animation modifier with respect to non-rendering modifiers is irrelevant for deciding if a change gets animated or not.
// ✅
// 非渲染型修饰符 (不全):
// Layout modifiers (frame, padding, position, offset)
// Font modifiers (font, bold, italic, fontWeight, fontWidth)
// Other modifiers that write data into the environment, e.g. foregroundColor, foregroundStyle, symbolRenderingMode, symbolVariant

// 渲染型修饰符 (不全):
// clipShape, cornerRadius
// Geometry effects, e.g. scaleEffect, rotationEffect, projectionEffect
// Graphical effects, e.g. blur, brightness, hueRotation, opacity, saturation, shadow

import SwiftUI

struct AnimationPlacement: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AnimationPlacement_Previews: PreviewProvider {
    static var previews: some View {
        AnimationPlacement()
    }
}
