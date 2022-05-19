//
//  AnimationDemo1.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/19.
//

import SwiftUI

struct AnimationDemo1: View {
    var body: some View {
        ScrollView {
            Group {
                //重写动画
                OverrideAnimations()
                //文字尺寸动画
                AnimateSizeOfText()
                //创建自定义转场
                CustomTransitions()
                //创建不对称转场
                AsymmetricTransitions()
            }
            Group {
                //转场动画相结合
                CombineTransitions()
                //通过转场动画添加、移除视图
                TransitionAddAndRemoveViews()
                //两个视图同步动画
                SynchronizeAnimations()
                //对一个View应用多种动画
                ApplyMultipleAnimations()
                //页面显示时开始动画
                StartAnimationAfterViewAppears()
                //延迟一个动画
                DelayAnAnimation()
                //创建显示动画
                ExplicitAnimation()
                //动画改变绑定值
                AnimateChangesBindingValues()
                //弹性动画
                SpringAnimations()
                //基本动画
                BasicAnimations()
            }
        }
    }
}
//-----------------------------
struct OverrideAnimations : View {
    //允许我们在运行时重写动画，例如删除隐式动画并用自定义的内容替换它。
    
    @State private var isZoomed = false
    
    var body: some View {
        TestWrap("重写动画") {
            VStack {
                Button("Toggle Zoom") {
                    //原来的
//                    isZoomed.toggle()
                    
//                    1.首先使用所需的任何动画创建一个新的事务实例
                    var transaction = Transaction(animation: .linear)
//                    2.然后将其disablesAnimations值设置为true,以便覆盖将应用的任何现有动画
                    transaction.disablesAnimations = true
//                    3.使用事务对象调用withTransaction()
                    withTransaction(transaction) {
                        isZoomed.toggle()
                    }
                }

                Spacer()
                    .frame(height: 100)

                Text("Zoom Text")
                    .font(.title)
                    .scaleEffect(isZoomed ? 3 : 1)
                    .animation(.easeInOut(duration: 2), value: isZoomed)
                Spacer()
                    .frame(height: 100)

                Text("Zoom Text 2")
                    .font(.title)
                    .scaleEffect(isZoomed ? 3 : 1)
                    .transaction { t in  //附加到所需的任何视图，从而可以覆盖应用于该视图的任何事务。
                        t.animation = .none    //把Button设置的线性动画，又覆盖了
                    }
            }
        }
    }
}
//-----------------------------
struct AnimateSizeOfText : View {
    //直接用scaleEffect会导致字体模糊，而不会重新渲染
    @State private var fontSize = 32.0
    
    var body: some View {
        TestWrap("文字尺寸动画") {
            VStack {
                Text("文字文字文字")
                    .animatableFont(name: "Georgia", size: fontSize)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1).repeatForever()) {
                                fontSize = 50
                        }
                }
            }
        }
    }
}

// A modifier that animates a font through various sizes.
struct AnimatableCustomFontModifier: ViewModifier, Animatable {
    var name: String
    var size: Double

    var animatableData: Double {
        get { size }
        set { size = newValue }
    }

    func body(content: Content) -> some View {
        content
            .font(.custom(name, size: size))
    }
}

// To make that easier to use, I recommend wrapping
// it in a `View` extension, like this:
extension View {
    func animatableFont(name: String, size: Double) -> some View {
        self.modifier(AnimatableCustomFontModifier(name: name, size: size))
    }
}

//如果要支持系统字体就重新定义一个
struct AnimatableSystemFontModifier: ViewModifier, Animatable {
    var size: Double
    var weight: Font.Weight
    var design: Font.Design

    var animatableData: Double {
        get { size }
        set { size = newValue }
    }

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}

extension View {
    func animatableSystemFont(size: Double, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.modifier(AnimatableSystemFontModifier(size: size, weight: weight, design: design))
    }
}

//-----------------------------
struct CustomTransitions : View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        TestWrap("创建自定义转场") {
            ZStack {
                Color.blue
                    .frame(width: 200, height: 200)

                if isShowingRed {
                    //3 使用transition（）修饰符将该过渡应用于视图。
                    Color.red
                        .frame(width: 200, height: 200)
                        .transition(.iris)
                        .zIndex(1)
                }
            }
            .padding(50)
            .onTapGesture {
                withAnimation(.easeInOut) {
                    isShowingRed.toggle()
                }
            }
        }
    }
}
// 1.创建一个ViewModifier，用于表示任何状态下的过渡。
// A general modifier that can clip any view using a any shape.
struct ClipShapeModifier<T: Shape>: ViewModifier {
    let shape: T

    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}
// 2.创建一个AnyTransition扩展，该扩展将视图修改器用于活动状态和标识状态。
// A custom transition combining ScaledCircle and ClipShapeModifier.
extension AnyTransition {
    static var iris: AnyTransition {
        .modifier(
            active: ClipShapeModifier(shape: ScaledCircle(animatableData: 0)),
            identity: ClipShapeModifier(shape: ScaledCircle(animatableData: 1))
        )
    }
}

struct ScaledCircle: Shape {
    // This controls the size of the circle inside the
    // drawing rectangle. When it's 0 the circle is
    // invisible, and when it’s 1 the circle fills
    // the rectangle.
    var animatableData: Double

    func path(in rect: CGRect) -> Path {
        let maximumCircleRadius = sqrt(rect.width * rect.width + rect.height * rect.height)
        let circleRadius = maximumCircleRadius * animatableData

        let x = rect.midX - circleRadius / 2
        let y = rect.midY - circleRadius / 2

        let circleRect = CGRect(x: x, y: y, width: circleRadius, height: circleRadius)

        return Circle().path(in: circleRect)
    }
}
//-----------------------------
struct AsymmetricTransitions : View {
    
    @State private var showDetails = false
    
    var body: some View {
        TestWrap("创建不对称转场") {
            VStack {
                Button("Press to show details") {
                    withAnimation {
                        showDetails.toggle()
                    }
                }

                if showDetails {
                    Text("Details go here.")
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .bottom)))
                }
            }
        }
    }
}
//-----------------------------
struct CombineTransitions : View {
    
    @State private var showDetails = false
    
    var body: some View {
        TestWrap("转场动画相结合") {
            Button("Press to show details") {
                withAnimation {
                    showDetails.toggle()
                }
            }

            if showDetails {
                //移动结合 淡入
                Text("Details go here.")
//                     .transition(AnyTransition.opacity.combined(with: .slide))
                    .transition(.moveAndScale)
            }
        }
    }
}
//封装复用
extension AnyTransition {
    static var moveAndScale: AnyTransition {
        AnyTransition.move(edge: .bottom).combined(with: .scale)
    }
}
//-----------------------------
struct TransitionAddAndRemoveViews : View {
    
    @State private var showDetails = false
    
    var body: some View {
        TestWrap("通过转场动画添加、移除动画") {
            Button("Press to show details") {
                withAnimation {
                    showDetails.toggle()
                }
            }

            if showDetails {
                Text("Details go here.")
                // Moves in from the bottom
                Text("Details go here.")
                    .transition(.move(edge: .bottom))

                // Moves in from leading out, out to trailing edge.
                Text("Details go here.")
                    .transition(.slide)

                // Starts small and grows to full size.
                Text("Details go here.")
                    .transition(.scale)
            }
        }
    }
}
//-----------------------------
struct SynchronizeAnimations : View {
    
    var body: some View {
        TestWrap("两个视图同步动画") {
//            SynchronizeAnimationsDemo1()
            SynchronizeAnimationsDemo2()
        }
    }
}

struct SynchronizeAnimationsDemo2: View {
    @Namespace private var animation
    @State private var isZoomed = false

    var frame: Double {
        isZoomed ? 300 : 44
    }
    var body: some View {
        VStack {
            Spacer()

            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .frame(width: frame, height: frame)
                        .padding(.top, isZoomed ? 20 : 0)

                    if isZoomed == false {
                        Text("Taylor Swift – 1989")
                            .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                            .font(.headline)
                        Spacer()
                    }
                }

                if isZoomed == true {
                    Text("Taylor Swift – 1989")
                        .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                        .font(.headline)
                        .padding(.bottom, 60)
                    Spacer()
                }
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    isZoomed.toggle()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 400)
            .background(Color(white: 0.9))
            .foregroundColor(.black)
        }
    }
}

struct SynchronizeAnimationsDemo1: View {
    //首先，需要使用@Namespace属性包装器为视图创建全局名称空间
    @Namespace private var animation
    
    @State private var isFlipped = false
    var body: some View {
        
        VStack {
            //接下来需要添加。将EdgeometryEffect（id:YourIdentifierHere，in:animation）匹配到要使用同步效果设置动画的所有视图。
            //YourIdentifierHere部件应替换为某个唯一的编号，该编号由您的配对中的每个部件共享。
            if isFlipped {
                Circle()
                    .fill(.red)
                    .frame(width: 44, height: 44)
                    .matchedGeometryEffect(id: "Shape", in: animation)
                Text("Taylor Swift – 1989")
                    .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                    .font(.headline)
            } else {
                Text("Taylor Swift – 1989")
                    .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                    .font(.headline)
                Circle()
                    .fill(.blue)
                    .frame(width: 44, height: 44)
                    .matchedGeometryEffect(id: "Shape", in: animation)
            }
        }
        .onTapGesture {
            withAnimation {
                isFlipped.toggle()
            }
        }
    }
}

//-----------------------------
struct ApplyMultipleAnimations : View {
    @State private var isEnabled = false
    
    var body: some View {
        TestWrap("对一个View应用多种动画") {
            VStack {
                Button("Press Me") {
                    isEnabled.toggle()
                }
                .foregroundColor(.white)
                .frame(width: 200, height: 200)
                .background(isEnabled ? .green : .red)
                .animation(nil, value: isEnabled) //控制，要圆角动画，不要背景色动画
                .clipShape(RoundedRectangle(cornerRadius: isEnabled ? 100 : 0))
                .animation(.default, value: isEnabled)
            }
        }
    }
}
//-----------------------------
struct StartAnimationAfterViewAppears : View {
    @State var scale = 1.0
    
    var body: some View {
        TestWrap("页面显示时开始动画") {
            VStack {
                Circle()
                    .frame(width: 200, height: 200)
                    .scaleEffect(scale)
//                    .onAppear {
//                        let baseAnimation = Animation.easeInOut(duration: 1)
//                        let repeated = baseAnimation.repeatForever(autoreverses: true)
//
//                        withAnimation(repeated) {
//                            scale = 0.5
//                        }
//                    }
                
                //使用扩展简化使用
                    .animateForever(autoreverses: true) { scale = 0.5 }
            }
        }
    }
}

extension View {
    func animate(using animation: Animation = .easeInOut(duration: 1), _ action: @escaping () -> Void) -> some View {
        onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
}

extension View {
    func animateForever(using animation: Animation = .easeInOut(duration: 1), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)

        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}

//-----------------------------
struct DelayAnAnimation : View {
    @State var rotation = 0.0
    
    var body: some View {
        TestWrap("延迟一个动画") {
            VStack {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(rotation))
                    .animation(.easeInOut(duration: 3).delay(1), value: rotation)
                    .onTapGesture {
                        rotation += 360
                    }
            }
        }
    }
}
//-----------------------------
struct ExplicitAnimation : View {
    @State private var opacity = 1.0
    //显式动画通常很有用，因为它们会使每个受影响的视图都设置动画，而不仅仅是那些附加了隐式动画的视图。
    var body: some View {
        TestWrap("创建显示动画") {
            VStack {
                Button("Press here") {
//                    withAnimation(.linear(duration: 3))
                    withAnimation {
                        opacity -= 0.2
                    }
                }
                .padding()
                .opacity(opacity)
            }
        }
    }
}
//-----------------------------
struct AnimateChangesBindingValues : View {
    @State private var showingWelcome = false
    
    var body: some View {
        TestWrap("动画改变绑定值") {
            VStack {
//                Toggle("Toggle label", isOn: $showingWelcome.animation())
                Toggle("Toggle label", isOn: $showingWelcome.animation(.spring()))

                if showingWelcome {
                    Text("Hello World")
                }
            }
        }
    }
}
//-----------------------------
struct SpringAnimations : View {
    @State private var angle: Double = 0
    
    var body: some View {
        TestWrap("弹性动画") {
            VStack {
                Button("Press here") {
                    angle += 45
                }
                .padding()
                .rotationEffect(.degrees(angle))
//                .animation(.spring(), value: angle)
                //控制更多参数 对象的质量、弹簧的刚度、弹簧减速的速度以及弹簧在启动时开始移动的速度。
                .animation(.interpolatingSpring(mass: 1, stiffness: 1, damping: 0.5, initialVelocity: 10), value: angle)
            }
        }
    }
}
//-----------------------------
struct BasicAnimations : View {
    @State private var scale = 1.0
    
    @State private var angle = 0.0
    @State private var borderThickness = 1.0
    var body: some View {
        TestWrap("基本动画") {
            VStack {
                Button("Press here") {
                    scale += 1
                }
                .scaleEffect(scale)
//                .animation(.linear(duration: 1), value: scale)
                .animation(.easeIn, value: scale)
                
                
                Button("Press here") {
                    angle += 45
                    borderThickness += 1
                }
                .padding()
                .border(.red, width: borderThickness)
                .rotationEffect(.degrees(angle))
                .animation(.easeIn, value: angle)
            }
        }
    }
}
//-----------------------------
struct AnimationDemo1_Previews: PreviewProvider {
    static var previews: some View {
        AnimationDemo1()
    }
}
