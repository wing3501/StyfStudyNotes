//
//  AnimationExample.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/6.
//

import SwiftUI

struct AnimationExample: View {
    
    var body: some View {
//        AnimatedButton()
        
//        LoadingIndicator()
        
//        TransitionExample()
           
//        LoadingIndicator1()
        
//        ShakeExample()
        
        TransitionExample1()
    }
    
}

struct AnimatedButton: View {
    @State var selected: Bool = false
    var body: some View {
        Button {
            selected.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(selected ? .red : .green)
                .frame(width: selected ? 100 : 50, height: selected ? 100 : 50, alignment: .center)
        }
//        .animation(.default, value: selected)
//        .animation(
//            .linear(duration: 1)
//            .speed(0.1)
//            .delay(2)
//            .repeatCount(2)
//            , value: selected)
//        .animation(
//            .spring()
//            .interactiveSpring()
//            .interpolatingSpring(stiffness: <#T##Double#>, damping: <#T##Double#>)
//            , value: selected)
    }
}

struct TransitionExample: View {
    @State var visible = false
    var body: some View {
        VStack {
            Button {
                visible.toggle()
            } label: {
                Text("Toggle")
            }
            if visible {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
//                    .transition(.slide)
//                    .transition(AnyTransition.move(edge: .leading).combined(with: .opacity)) //也可以组合多个过渡效果
                    .transition(.asymmetric(insertion: .slide, removal: .slide))//可以让我们为 view 的插入指定一种过渡，同时为 view 的移出指定另一种过渡
//                    .animation(.default, value: visible)
                    .animation(.default)
                
            }
        }
    }
}

struct LoadingIndicator: View {
    @State private var animating = false
    var body: some View {
        VStack {//不套一层就没有动画
            Image(systemName: "rays")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .rotationEffect(animating ? .degrees(360) : .zero)
                .animation(
                    .linear(duration: 1)
                    .repeatForever(autoreverses: false), value: animating)
                .onAppear {
                    animating = true
                }
        }
    }
}

struct LoadingIndicator1: View {
    @State private var appeared = false
    let animation = Animation
                        .linear(duration: 2)
                        .repeatForever(autoreverses: false)
    var body: some View {
        Circle()
            .fill(Color.accentColor)
            .frame(width: 5, height: 5, alignment: .center)
            .offset(y: -20)
            .rotationEffect(appeared ? .degrees(360) : .zero)
            .onAppear {
                withAnimation(animation) {//显示动画避免屏幕翻转引起隐式动画问题
                    appeared = true
                }
            }
    }
}


// 自定义动画
struct Shake: AnimatableModifier {
    var times: CGFloat = 0 //我们的目标是 当这个属性被增加 1 时，晃动一次 view，当增加 2 时晃动两次
    let amplitude: CGFloat = 10
    var animatableData: CGFloat {
        get { times }
        set {
            times = newValue
            print("value=\(newValue)")
        }
    }
    func body(content: Content) -> some View {
        return content.offset(x: sin(times * .pi * 2) * amplitude)
    }
}

extension View {
    func shake(times: Int) -> some View {
        return modifier(Shake(times: CGFloat(times)))
    }
}

struct ShakeExample: View {
    @State private var taps: Int = 0
    var body: some View {
        Button("点击") {
            withAnimation(.linear(duration: 0.5)) {
                taps += 1
            }
        }
        .shake(times: taps * 3)
    }
}

//当我们的动画修饰器需要进行动画的值可以被表示为仿射变换 (不论 2D 还是 3D) 时，我们也可 以使用 GeometryEffect 来代替 AnimatableModifier
struct ShakeEffect: GeometryEffect {
    var times: CGFloat = 0
    let amplitude: CGFloat = 10
    
    var animatableData: CGFloat {
    get { times }
    set { times = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: sin(times * .pi * 2) * amplitude, y: 0))
    }
}
//自定义过渡
//要自定义 view 的插入和移除动画，我们可以使用 AnyTransition 的 modifier(active:identity:) 方法来创建自定义过渡。
//一个用于过渡发生时，另一个用于过 渡结束时

struct Blur: ViewModifier {
    var active: Bool
    func body(content: Content) -> some View {
        return content
            .blur(radius: active ? 50 : 0)
            .opacity(active ? 0 : 1)
    }
}

extension AnyTransition {
    static var blur: AnyTransition {
        .modifier(active: Blur(active: true), identity: Blur(active: false))
    }
}

struct TransitionExample1: View {
    @State var visible = false
    var body: some View {
        VStack {
            Button {
                withAnimation(.linear(duration: 1)) {
                    visible.toggle()
                }
            } label: {
                Text("Toggle")
            }
            if visible {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                    .transition(.blur)
            }
        }
    }
}


struct AnimationExample_Previews: PreviewProvider {
    static var previews: some View {
        AnimationExample()
    }
}
