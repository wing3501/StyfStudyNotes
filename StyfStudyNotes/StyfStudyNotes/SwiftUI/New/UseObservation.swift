//
//  UseObservation.swift
//  TestSwiftUI
//
//  Created by 申屠云飞 on 2023/8/8.
//  深度解读 Observation —— SwiftUI 性能提升的新途径 https://www.fatbobman.com/posts/mastering-Observation/
//  https://swiftwithmajid.com/2023/07/11/unidirectional-flow-in-swift/

// Observation 框架 它具有以下优点：
//1 适用于所有 Swift 引用类型，不限于 NSObject 子类，提供跨平台支持。
//2 提供属性级别的精确观察，且无需对可观察属性进行特别注解。
//3 减少 SwiftUI 中对视图的无效更新，提高应用性能。

import SwiftUI

//✅ 在类的声明前添加 @Observalbe 标注，不需要指定 Store 类型要遵守某个协议。
@available(iOS 17.0, *)
@Observable
class MyStore {
    // 不需要通过 @Published 来标注能引发通知的属性，没有特别标注的存储属性都可以被观察
    var firstName: String = "Yang"
    var lastName: String = "Xu"
    // 可以观察计算属性（ 在例中，fullName 也可被观察 ）
    var fullName: String {
        firstName + " " + lastName
    }
    var a = 10
    var b = 20
    var c = 20
//   ✅ 对于不想被观察的属性，需要在其前方标注 @ObservationIgnored
    // count 不可被观察
    @ObservationIgnored
    var count: Int = 0

    // ⚠️ 所有的属性必须有字面默认值，即使提供了自定义的 init 方法
    init(firstName: String, lastName: String, count: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.count = count
    }
}

@available(iOS 17.0, *)
struct UseObservation: View {
    //✅ 与遵守 ObservableObject 协议的 Source of Truth 不同，我们会在视图中使用 @State 来确保可观察对象的声明周期。
    @State var store = MyStore(firstName: "yf", lastName: "st", count: 1)
    
    var body: some View {
        VStack(content: {
            Text(store.lastName + store.firstName)
                .onTapGesture {
                    store.count += 1
                    store.firstName += "\(store.count)"
                }
            UseObservationDetailView()
                .environment(store)
            UseObservationDetailView1()
                .environment(\.store, store)
            UseObservationDetailView2()
                .environment(store)
            UseObservationBinding(store: store)
            UseObservationBinding1(store: store)
            UseObservationBinding2(store: store)
        })
        .onAppear(perform: {
            // ✅ Observation 框架提供了一个全局函数 withObservationTracking。使用此函数，开发者可以跟踪可观察对象的属性是否发生变化。
            // withObservationTracking 创建的观察操作是一次性的行为，任意一个被观察属性发生变化，在调用了 onChange 函数后，本次观察都将结束
            // onChange 闭包是在属性值变化之前（willSet 方法中）被调用的
            // 在一次观察操作中，可以观察多个可观察属性。任一属性值变化都会结束本次观察。
            // 观察行为是线程安全的，withObservationTracking 可以运行在另一个线程中，onChange 闭包将运行于 withObservationTracking 发起的线程中
            // 只有可观察属性可以被观察。apply 闭包中仅出现的可观察对象并不会创建观察操作
            let sum = withObservationTracking {
                // apply：一个包含要跟踪的属性的闭包
                store.a + store.b
            } onChange: {
                //onChange：当属性值更改时调用的闭包
                print("Store Changed a:\(store.a) b:\(store.b) c:\(store.c)")
            }
            
        })
    }
}

@available(iOS 17.0, *)
struct UseObservationDetailView: View {
    //✅ 通过环境在视图树中注入可观察对象
    @Environment(MyStore.self) var store // 在视图中通过环境注入
    
    var body: some View {
        Text("UseObservationDetailView___" + store.lastName)
    }
}

//✅ 通过自定义 EnvironmentKey
@available(iOS 17.0, *)
struct MyStoreKey: EnvironmentKey {
    static var defaultValue = MyStore(firstName: "1", lastName: "2", count: 3)
}
@available(iOS 17.0, *)
extension EnvironmentValues {
    var store: MyStore {
        get { self[MyStoreKey.self] }
        set { self[MyStoreKey.self] = newValue }
    }
}
@available(iOS 17.0, *)
struct UseObservationDetailView1: View {
    @Environment(\.store) var store
    var body: some View {
        Text("UseObservationDetailView___" + store.firstName)
    }
}
//✅ 注入可选值
@available(iOS 17.0, *)
struct UseObservationDetailView2: View {
    @Environment(MyStore.self) var store: MyStore? // 在视图中注入可选值
    var body: some View {
        if let fullName = store?.fullName {
            Text("UseObservationDetailView___" + fullName)
        }else {
            Text("UseObservationDetailView2")
        }
    }
}

//✅ 创建 Binding 类型
// 方法一：
@available(iOS 17.0, *)
struct UseObservationBinding: View {
    @Bindable var store:MyStore
    var body: some View {
        TextField("",text:$store.firstName)
            .border(.red)
    }
}
// 方法二：
@available(iOS 17.0, *)
struct UseObservationBinding1: View {
    var store: MyStore
    var body: some View {
        @Bindable var store = store
        TextField("",text:$store.firstName)
            .border(.green)
    }
}
// 方法三：
@available(iOS 17.0, *)
struct UseObservationBinding2: View {
    var store: MyStore
    var name: Binding<String> {
        .init(get: {store.firstName}, set: { store.firstName = $0 })
    }
    var body: some View {
        TextField("",text:name)
            .border(.yellow)
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        UseObservation()
    } else {
        EmptyView()
    }
}
