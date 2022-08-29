//
//  UsingOnChange.swift
//  
//
//  Created by styf on 2022/8/29.
//  了解 SwiftUI 的 onChange https://www.fatbobman.com/posts/onChange/

import SwiftUI
import Combine

struct UsingOnChange: View {
    var body: some View {
        NonStateDemo()
    }
}
// ✅ 任何符合 Equatable 协议的类型都可被 onChange 所观察。对于可选值，只要 Wrapped 符合 Equatable 即可。

//------------------------------------------------------------------------------------

//⚠️ 被观察值的变化并不会触发 onChange，只有在每次视图重绘时 onChange 才会触发。onChange 触发后会比较被观察值的变化，只有新旧值不一致时，才会调用 onChange 闭包中的操作。
struct NonStateDemo: View {
    let store = Store.share
    @State var id = UUID()
    var body: some View {
        VStack {
            Button("refresh") {
                id = UUID()
            }
            .id(id)
            //尽管 Store 中的 date 每三秒会发生一次改变，但并不会引起视图的重新绘制。通过点击按钮强制重绘视图，onChange 才会被触发。
            .onChange(of: store.date) { value in
                print(value)
            }
        }
    }
    
    class Store {
        var date = Date() {
            didSet {
                print("-----\(date)")
            }
        }
        var cancellables = Set<AnyCancellable>()
        init(){
            Timer.publish(every: 3,  on: .current, in: .common)
                .autoconnect()
                .assign(to: \.date, on: self)
                .store(in: &cancellables)
        }

        static let share = Store()
    }
}


//------------------------------------------------------------------------------------
//✅ 对于结构类型，捕获时需使用结构实例，而不能直接捕获结构中的属性
struct OldValue1:View{
    struct MyData{
        var t = 0
    }
    
    @State var data = MyData()
    var body: some View{
        Button("change"){
            data.t = Int.random(in: 1...5)
        }
        .onChange(of: data.t){ [data] newValue in
            let oldValue = data.t
            if newValue % oldValue == 2 {
                print("余值为 2")
            } else {
                print("不满足条件")
            }
        }
    }
}

//------------------------------------------------------------------------------------
//✅ 通过闭包捕获的方式获取被观察值的旧值（oldValue）
struct OldValue: View {
    @State var t = 1
    var body: some View {
        Button("change") {
            t = Int.random(in: 1...5)
        }
        .onChange(of: t) { [t] newValue in
            let oldValue = t
            if newValue % oldValue == 2 {
                print("余值为 2")
            } else {
                print("不满足条件")
            }
        }
    }
}
//------------------------------------------------------------------------------------
// 基本使用
struct OnChangeDemo:View{
    @State var t = 0
    var body: some View{
        Button("change"){
            t += 1
        }
        .onChange(of: t, perform: { value in
            print(value)
        })
    }
}
