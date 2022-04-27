//
//  OverlaySheet.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/27.
//

import SwiftUI

//SwiftUI 提供了三种对手势进行组合的方式，分别是代表手势需要顺次发生的 SequenceGesture、需要同时发生的 SimultaneousGesture 和只能有一个发 生的 ExclusiveGesture。

struct OverlaySheet<Content: View>: View {
    
    private let isPresented: Binding<Bool>
    private let makeContent: () -> Content
    //@GestureState 你可以将它的行为简单地认为和普 通的 @State 等效。
//    被标记为 @GestureState 的变量，除了具有和普通 @State 类似的行为外，还会在 panelDraggingGesture 手势结束后被自动置回初始值 0。
    @GestureState private var translation = CGPoint.zero
    
//    对于只和 View 相关，且是用户操作造成的 UI 暂态，使用 private 的 @State 把状态限制在 View 的内部，对维护 app 状态 (或者称为模型状态) 的简洁，无疑是更明智的 选择。

    
    init(isPresented: Binding<Bool>,
         @ViewBuilder content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.makeContent = content
    }
    
    var body: some View {
        VStack {
            Spacer()
            makeContent()
        }
        .offset(y: (isPresented.wrappedValue ? 0 : UIScreen.main.bounds.height) + max(0, translation.y))//我们在计算 offset 时 设定了 max(0, translation.y)，也就是忽略了手势向上的情况
        // 添加动画
        .animation(.interpolatingSpring(stiffness: 70, damping: 12), value: isPresented.wrappedValue)
        .edgesIgnoringSafeArea(.bottom)
        .gesture(panelDraggingGesture)
    }
    
    var panelDraggingGesture: some Gesture {
        DragGesture()
//            .updating(<#T##state: GestureState<State>##GestureState<State>#>) { <#DragGesture.Value#>, <#inout State#>, <#inout Transaction#> in
//                <#code#>
//            }
//        updating 的尾随闭包 中第二个参数是一个标记为 inout 的待设定值。对这个值进行设置，SwiftUI 将可以通过 $translation 对 @GestureState 状态进行更新。
//        这里我们在每次 手势状态更新后都记录了手势当前所处位置相对于起始位置的位移高度。
            .updating($translation) { current, state, _ in
                state.y = current.translation.height
            }
        
//        @State private var translation = CGPoint.zero
//        DragGesture().onChanged { state in
//                  self.translation = CGPoint(x: 0, y: state.translation.height)
//            }
//        普通的 @State 和 @GestureState 最大的不同在于，当手势结束时， @GestureState 的值会被隐式地置为初始值。当这个特性正是你所需要的时
//        候，它可以简化你的代码，但是如果你的状态值需要在手势结束后依然保持不 变，则应该使用 onChanged 的版本。
        
//            .onEnded { <#DragGesture.Value#> in
//                <#code#>
//            }
            .onEnded { state in
//                在手势结束时，判断相对于原始位置，手势是否下划超过了 250 point。
                if state.translation.height > 250 {
                    isPresented.wrappedValue = false
                }
            }
    }
}
