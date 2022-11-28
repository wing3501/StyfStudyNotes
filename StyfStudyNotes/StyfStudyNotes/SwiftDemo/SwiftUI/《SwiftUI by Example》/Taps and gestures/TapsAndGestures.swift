//
//  TapsAndGestures.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/13.
//

import SwiftUI

struct TapsAndGestures: View {
    var body: some View {
        ScrollView {
            //观察点击视图位置，借助UIKit
            DetectTheLocationOfATap()
            //禁止手势
            UsingAllowsHitTesting()
            //更改点击热区
            UsingContentShape()
            //观察设备晃动
            DetectShakeGestures()
            //创建手势链
            GestureChains()
            //让两个手势同时识别
            UsingSimultaneousGesture()
            //让一个手势识别优先级更高
            BeHighPriorityGesture()
            //获取单击双击手势事件
            DoubleTap()
            //几种手势的基本使用
            AddGestureRecognizer()
        }
    }
}
//--------------------------------
struct DetectTheLocationOfATap: View {
    var body: some View {
        TestWrap("观察点击视图位置") {
            VStack {
                Text("This will track all touches, inside bounds only.")
                    .padding()
                    .background(.red)
                    .onTouch(perform: updateLocation)

                Text("This will track all touches, ignoring bounds – you can start a touch inside, then carry on moving it outside.")
                    .padding()
                    .background(.blue)
                    .onTouch(limitToBounds: false, perform: updateLocation)

                Text("This will track only starting touches, inside bounds only.")
                    .padding()
                    .background(.green)
                    .onTouch(type: .started, perform: updateLocation)
            }
        }
    }
    
    func updateLocation(_ location: CGPoint) {
        print(location)
    }
}

// Our UIKit to SwiftUI wrapper view
struct TouchLocatingView: UIViewRepresentable {
    // The types of touches users want to be notified about
    struct TouchType: OptionSet {
        let rawValue: Int

        static let started = TouchType(rawValue: 1 << 0)
        static let moved = TouchType(rawValue: 1 << 1)
        static let ended = TouchType(rawValue: 1 << 2)
        static let all: TouchType = [.started, .moved, .ended]
    }

    // A closure to call when touch data has arrived
    var onUpdate: (CGPoint) -> Void

    // The list of touch types to be notified of
    var types = TouchType.all

    // Whether touch information should continue after the user's finger has left the view
    var limitToBounds = true

    func makeUIView(context: Context) -> TouchLocatingUIView {
        // Create the underlying UIView, passing in our configuration
        let view = TouchLocatingUIView()
        view.onUpdate = onUpdate
        view.touchTypes = types
        view.limitToBounds = limitToBounds
        return view
    }

    func updateUIView(_ uiView: TouchLocatingUIView, context: Context) {
    }

    // The internal UIView responsible for catching taps
    class TouchLocatingUIView: UIView {
        // Internal copies of our settings
        var onUpdate: ((CGPoint) -> Void)?
        var touchTypes: TouchLocatingView.TouchType = .all
        var limitToBounds = true

        // Our main initializer, making sure interaction is enabled.
        override init(frame: CGRect) {
            super.init(frame: frame)
            isUserInteractionEnabled = true
        }

        // Just in case you're using storyboards!
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            isUserInteractionEnabled = true
        }

        // Triggered when a touch starts.
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            send(location, forEvent: .started)
        }

        // Triggered when an existing touch moves.
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            send(location, forEvent: .moved)
        }

        // Triggered when the user lifts a finger.
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            send(location, forEvent: .ended)
        }

        // Triggered when the user's touch is interrupted, e.g. by a low battery alert.
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            send(location, forEvent: .ended)
        }

        // Send a touch location only if the user asked for it
        func send(_ location: CGPoint, forEvent event: TouchLocatingView.TouchType) {
            guard touchTypes.contains(event) else {
                return
            }

            if limitToBounds == false || bounds.contains(location) {
                onUpdate?(CGPoint(x: round(location.x), y: round(location.y)))
            }
        }
    }
}

// A custom SwiftUI view modifier that overlays a view with our UIView subclass.
struct TouchLocater: ViewModifier {
    var type: TouchLocatingView.TouchType = .all
    var limitToBounds = true
    let perform: (CGPoint) -> Void

    func body(content: Content) -> some View {
        content
            .overlay(
                TouchLocatingView(onUpdate: perform, types: type, limitToBounds: limitToBounds)
            )
    }
}

// A new method on View that makes it easier to apply our touch locater view.
extension View {
    func onTouch(type: TouchLocatingView.TouchType = .all, limitToBounds: Bool = true, perform: @escaping (CGPoint) -> Void) -> some View {
        self.modifier(TouchLocater(type: type, limitToBounds: limitToBounds, perform: perform))
    }
}

//--------------------------------
struct UsingAllowsHitTesting: View {
    var body: some View {
//        SwiftUI允许我们使用allowsHitTesting（）修饰符阻止视图接收任何类型的点击。
//        如果某个视图不允许进行点击测试，则任何点击都会自动在该视图中继续到其背后的任何内容。
        TestWrap("禁止手势") {
            ZStack {
                Button("Tap Me") {
                    print("Button was tapped")
                }
                .frame(width: 100, height: 100)
                .background(.gray)

                Rectangle()
                    .fill(.red.opacity(0.2))
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .allowsHitTesting(false)
            }
        }
    }
}
//--------------------------------
struct UsingContentShape: View {
    @State var num = 0
    var body: some View {
        TestWrap("更改点击热区") {
            VStack {
                Image(systemName: "person.circle").resizable().frame(width: 50, height: 50)
                Spacer().frame(height: 50)//这块区域原来不能响应手势
                Text("Paul Hudson\(num)")
            }
            .contentShape(Rectangle())//更改热区后可以响应了
            .onTapGesture {
                num += 1
                print("Show details for user")
            }
        }
    }
}
//--------------------------------
struct DetectShakeGestures: View {
    var body: some View {
        TestWrap("观察设备晃动") {
            Text("Shake me!")
                .onShake {
                    print("Device shaken!")
                }
        }
    }
}

extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//extension UIWindow {
//     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        if motion == .motionShake {
//            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
//        }
//     }
//}
//
//struct DeviceShakeViewModifier: ViewModifier {
//    let action: () -> Void
//
//    func body(content: Content) -> some View {
//        content
//            .onAppear()
//            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
//                action()
//            }
//    }
//}
//
//extension View {
//    func onShake(perform action: @escaping () -> Void) -> some View {
//        self.modifier(DeviceShakeViewModifier(action: action))
//    }
//}

//--------------------------------
struct GestureChains: View {
    @State private var message = "Long press then drag"
    var body: some View {
        TestWrap("创建手势链") {
            let longPress = LongPressGesture()
                .onEnded { _ in
                    message = "Now drag me"
                }

            let drag = DragGesture()
                .onEnded { _ in
                    message = "Success!"
                }
            //firstGesture.sequenced(before: secondGesture)
            let combined = longPress.sequenced(before: drag)

            Text(message)
                .gesture(combined)
        }
    }
}
//--------------------------------
//SwiftUI 提供了三种对手势进行组合的方式，分别是代表手势需要顺次发生的 SequenceGesture、需要同时发生的 SimultaneousGesture 和只能有一个发 生的 ExclusiveGesture。
struct UsingSimultaneousGesture: View {
    var body: some View {
        TestWrap("让两个手势同时识别") {
            VStack {
                Circle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        print("Circle tapped")
                    }
            }
//            您应该将Simultaneous手势（）与原本无法执行的手势一起使用，否则它将无法工作
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        print("VStack tapped")
                    }
            )
        }
    }
}
//--------------------------------
struct BeHighPriorityGesture: View {
    var body: some View {
        TestWrap("让一个手势识别优先级更高") {
            VStack {
                Circle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .onTapGesture {
                        print("Circle tapped")
                    }
            }
//            .onTapGesture {
//                print("VStack tapped")
//            }
            
            .highPriorityGesture(
                TapGesture()
                    .onEnded { _ in
                        print("VStack tapped")
                    }
            )
        }
    }
}
//--------------------------------
struct DoubleTap: View {
    var body: some View {
        TestWrap("获取单击双击手势事件") {
            Text("Tap me!")
                .onTapGesture {
                    print("Tapped!")
                }
            Image("baike")
                .onTapGesture(count: 2) {
                    print("Double tapped!")
                }
        }
    }
}

//--------------------------------
struct AddGestureRecognizer: View {
    @State private var scale = 1.0
    @State private var dragCompleted = false
    @State private var dragOffset = CGSize.zero
    var body: some View {
        TestWrap("几种手势的基本使用") {
            //点击手势
            Image("baike")
                .scaleEffect(scale)
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            scale += 0.1
                        }
                )
            //长按手势
            Image("baike")
                .scaleEffect(scale)
                .gesture(
                    LongPressGesture(minimumDuration: 1)
                        .onEnded { _ in
                            scale *= 2
                        }
                )
            //拖拽手势
            VStack {
                Image("baike")
                    .gesture(
                        DragGesture(minimumDistance: 50)
                            .onEnded { _ in
                                dragCompleted = true
                            }
                    )

                if dragCompleted {
                    Text("Drag completed!")
                }
            }
            
            VStack {
                Image("baike")
                    .offset(dragOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                dragOffset = gesture.translation
                            }
                            .onEnded { gesture in
                                dragOffset = .zero
                            }
                    )
            }
        }
    }
}

struct TapsAndGestures_Previews: PreviewProvider {
    static var previews: some View {
        TapsAndGestures()
    }
}
