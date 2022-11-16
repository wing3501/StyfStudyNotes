//
//  AvoidRepeatedCalculations.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/11/16.
//  避免 SwiftUI 视图的重复计算  https://www.fatbobman.com/posts/avoid_repeated_calculations_of_SwiftUI_views/

// 可以驱动视图进行更新的源被称之为 Source of Truth，它的类型有：
// 1 使用 @State、@StateObject 这类属性包装器声明的变量
// 2 视图类型（ 符合 View 协议 ）的构造参数
// 3 例如 onReceive 这类的事件源   onReceive、onChange、onOpenURL、onContinueUserActivity 等

// ✅ 1. 避免非必要的声明
//  任何可以在当前视图之外进行改动的 Source of Truth，只要在视图类型中声明了，无论是否在视图 body 中被使用，在它给出刷新信号时，当前视图都将被刷新。
//struct EnvObjectDemoView:View{
//    @EnvironmentObject var store:Store  ❌  类型的情况在 @ObservedObject、@Environment 上也会出现
//    var body: some View{
//        Text("abc")
//    }
//}

// ✅ 2 其他建议
//      2.1 需要跳跃视图层级时，考虑使用 Environment 或 EnvironmentObject
//      2.2 对于不紧密的 State 关系，考虑在同一个视图层级使用多个 EnvironmentObject 注入，将状态分离
//      2.3 在合适的场景中，可以使用 objectWillChange.send 替换 @Published
//      2.4 可以考虑使用第三方库，对状态进行切分，减少视图刷新几率
//      2.5 无需追求完全避免重复计算，应在依赖注入便利性、应用性能表现、测试难易度等方面取得平衡
//      2.6 不存在完美的解决方案，即使像 TCA 这类的热门项目，面对切分粒度高、层次多的 State 时，也会有明显的性能瓶颈

// ✅ 3 化整为零  StudentNameView(name: student.name) // 仅传递需要的数据
// ✅ 4 让视图符合 Equatable 协议以自定义比对规则
//      也许由于某种原因，你无法采用上面的方法来优化构造参数，SwiftUI 还提供了另外一种通过调整比对规则的方式用以实现相同的结果。
//struct StudentNameView: View, Equatable {
//    let student: Student
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        lhs.student.name == rhs.student.name
//    }
//}
// ✅ 5 闭包 —— 容易被忽略的突破点
//List {
//    ForEach(0..<100) { i in
//        CellView(id: i){ store.sendID(i) } // ❌ 使用尾随闭包的方式为子视图设定按钮动作
//                  当点击某一个 CellView 视图的按钮后，所有的 CellView （ 当前 List 显示区域 ）都会重新计算。
//    }
//}
//    ✅ 解决的方法有两种：
//      1 让 CellView 符合 Equatable 协议，不比较 action 参数
//static func == (lhs: Self, rhs: Self) -> Bool { // 将 action 排除在比较之外
//    lhs.id == rhs.id
//}

//      2 修改构造参数中的函数定义，将 store 排除在 CellView 之外
//          CellView(id: i, action: store.sendID) // 直接传递 store 中的 sendID 方法，将 store 排除在外

// ✅ 6 事件源
//    6.1  控制生命周期
//          只在需要处理事件时才加载与其关联的视图，用关联视图的存续期来控制触发器的生命周期
//                    if enable { // 只在需要使用时，才加载触发器
//if enable { // 只在需要使用时，才加载触发器
//    Color.clear
//        .task {
//            while !Task.isCancelled {
//                try? await Task.sleep(nanoseconds: 1000000000)
//                NotificationCenter.default.post(name: .test, object: Date())
//            }
//        }
//        .onReceive(NotificationCenter.default.publisher(for: .test)) { notification in
//            if let date = notification.object as? Date {
//                timestamp = date
//            }
//        }
//}
//    6.2  减小影响范围
//          为触发器创建单独的视图，将其对视图更新的影响范围降至最低
//          TimeView(enable: enable) // 单独的视图，onReceive 只能导致 TimeView 被更新

import SwiftUI

struct AvoidRepeatedCalculations: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AvoidRepeatedCalculations_Previews: PreviewProvider {
    static var previews: some View {
        AvoidRepeatedCalculations()
    }
}
