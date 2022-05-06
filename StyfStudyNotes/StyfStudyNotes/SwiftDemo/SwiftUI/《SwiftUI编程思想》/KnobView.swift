//
//  KnobView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/29.
//

import SwiftUI

struct KnobView: View {
    @State var volume: Double = 0.5
    var body: some View {
        VStack {
            Knob(value: $volume)
            .frame(width: 100, height: 100, alignment: .center)
            .knobPointerSize(0.1)
        Slider(value: $volume, in: (0...1))
                
        }
    }
    
    struct Knob: View {
        // 0 到 1 之间的值
        @Binding var value: Double
//        为了让这个控件能同时适配浅色和深色模式，我们会使用 SwiftUI 的 colorScheme 环境值来从
//        环境里读取当前的配色方案
        @Environment(\.colorScheme) var colorScheme
        
        var pointerSize: CGFloat? = nil
        @Environment(\.knobPointerSize) var envPointerSize
//        如果我们在环境中存储的是一 个对象，并通过 @Environment 观察它，view 并不会由于对象中的一个属性变化而重绘，重绘 只在将 key 设置为整个不同的对象时才会发生。
        var body: some View {
            KnobShape(pointerSize: pointerSize ?? envPointerSize)
                .fill(colorScheme == .dark ? Color.white : Color.black)
                .rotationEffect(Angle(degrees: value * 330))
                .onTapGesture {
                    value = value < 0.5 ? 1 : 0
                }
                .frame(width: 32, height: 32, alignment: .center)
        }
        
        func resizable() -> some View {
            KnobShape(pointerSize: pointerSize ?? envPointerSize)
                .fill(colorScheme == .dark ? Color.white : Color.black)
                .rotationEffect(Angle(degrees: value * 330))
                .onTapGesture {
                    value = value < 0.5 ? 1 : 0
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(idealWidth: 32, idealHeight: 32)
        }
    }
    
    struct KnobShape: Shape {
        var pointerSize: CGFloat = 0.1 // these are relative values
        var pointerWidth: CGFloat = 0.1
        func path(in rect: CGRect) -> Path {
            let pointerHeight = rect.height * pointerSize
            let pointerWidth = rect.width * self.pointerWidth
            let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
            return Path { p in
                p.addEllipse(in: circleRect)
                p.addRect(CGRect(x: rect.midX - pointerWidth/2, y: 0, width: pointerWidth, height: pointerHeight + 2))
            }
        }
    }
    
    
}

fileprivate struct PointerSizeKey: EnvironmentKey {
    static var defaultValue: CGFloat = 0.1
}

extension EnvironmentValues {
    var knobPointerSize: CGFloat {
        get {
            self[PointerSizeKey.self]
        }
        set {
            self[PointerSizeKey.self] = newValue
        }
    }
}

extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        environment(\.knobPointerSize, size)
    }
}

struct KnobView_Previews: PreviewProvider {
    static var previews: some View {
        KnobView()
    }
}
