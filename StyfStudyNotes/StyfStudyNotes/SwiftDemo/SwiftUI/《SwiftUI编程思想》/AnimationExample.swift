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
        
//        TransitionExample1()
        
//        BounceExample()
        
//        LineGraphExample()
        
        LikeHeartExample()
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

//反弹动画
struct Bounce: AnimatableModifier {
    var times: CGFloat = 0
    var amplitude: CGFloat = 30
    var animatableData: CGFloat {
        get { times }
        set { times = newValue }
    }
    func body(content: Content) -> some View {
        return content.offset(y: -abs(sin(times * .pi)) * amplitude)
    }
}

extension View {
    func bounce(times: Int) -> some View {
        return modifier(Bounce(times: CGFloat(times)))
    }
}

struct BounceExample: View {
    @State private var taps: Int = 0
    var body: some View {
        Button("点击") {
            withAnimation(.linear(duration: 0.9)) {
                taps += 1
            }
        }
        .background(.yellow)
        .bounce(times: taps * 3)
    }
}

//路径动画
struct LineGraph: Shape {
    let dataPoints: [CGFloat]
    func path(in rect: CGRect) -> Path {
        let perWidth = rect.size.width / Double((dataPoints.count - 1))
        return Path { path in
            path.move(to: CGPoint(x: 0, y: rect.maxY - rect.size.height * dataPoints[0]))
            var i = 1
            while i < dataPoints.count {
                path.addLine(to: CGPoint(x: Double(i) * perWidth, y: rect.maxY - rect.size.height * dataPoints[i]))
                i += 1
            }
        }
    }
}

fileprivate struct PositionOnShapeEffect: GeometryEffect {
    var path: Path
    var at: CGFloat
    
    var animatableData: CGFloat {
        get { at }
        set { at = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        // at 进度 0-1
        let trimmed = path.trimmedPath(from: 0, to: at == 0 ? 0.00001 : at)//路径
        let point = trimmed.currentPoint ?? .zero
        return ProjectionTransform(.init(translationX: point.x - size.width/2, y: point.y - size.height/2))
    }
}

extension View {
    func position<S: Shape>(on shape: S, at amount: CGFloat) -> some View {
        GeometryReader { proxy in
            self
                .modifier(PositionOnShapeEffect(path: shape.path(in: CGRect(origin: .zero, size: proxy.size)), at: amount))
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .topLeading)
        }
    }
}


struct LineGraphExample: View {
    @State var visible = false
    
    let graph = LineGraph(dataPoints: [0.1, 0.7, 0.3, 0.6, 0.45, 1.1])
    
    var body: some View {
        VStack {
            ZStack {
                graph
                    .trim(from: 0, to: visible ? 1 : 0)//裁剪图形显示
                    .stroke(Color.red, lineWidth: 2)
                Circle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
                    .position(on: graph, at: visible ? 1 : 0)
            }
            .aspectRatio(16/9, contentMode: .fit)
            .border(Color.gray, width: 1)
            .padding()
            Button(action: {
                withAnimation(Animation.easeInOut(duration: 2)) {
                    self.visible.toggle()
                }
            }) { Text("Animate") }
        }
    }
}

//点赞动画

struct LikesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 100 ... 200)
    var xDirection = Double.random(in:  -0.05 ... 0.05)
    var yDirection = Double.random(in: -Double.pi ...  0)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * xDirection
        let yTranslation = speed * sin(yDirection) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}

struct LikeTapModifier: ViewModifier {
    @State var time = 0.0
    let duration = 1.0
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .foregroundColor(.red)
                .modifier(LikesGeometryEffect(time: time))
                .opacity(time == 1 ? 0 : 1)
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
            }
        }
    }
}

struct LikeHeartExample: View {
    @State var likes :[LikeView] = []
        
        func likeAction () {
            likes += [LikeView()]
        }
        
        var body: some View {
            ZStack {
                Color.black.ignoresSafeArea()
                ZStack {
                    
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .onTapGesture {
                            likeAction()
                        }
                    
                    
                    ForEach (likes) { like in
                        like.image.resizable()
                            .frame(width: 50, height: 50)
                            .modifier(LikeTapModifier())
                            .padding()
                            .id(like.id)
                    }.onChange(of: likes) { newValue in
                        if likes.count > 5 {
                            likes.removeFirst()
                        }
                    }
                    
                }.foregroundColor(.white.opacity(0.5))
                    .offset(x: 0, y: 60)
            }
        }
}

struct LikeView : Identifiable, Equatable {
    let image = Image(systemName: "heart.fill")
    let id = UUID()
}

struct AnimationExample_Previews: PreviewProvider {
    static var previews: some View {
        AnimationExample()
    }
}
