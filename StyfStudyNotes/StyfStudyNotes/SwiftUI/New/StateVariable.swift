//
//  StateVariable.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/11/10.
// @State variable initialization in SwiftUI
// https://sarunw.com/posts/state-variable-initialization/
// @State变量初始化的问题

// How to initialize @StateObject with parameters in SwiftUI
// https://sarunw.com/posts/how-to-initialize-stateobject-with-parameters-in-swiftui/
// 如何在@StateObject初始化时传参

// Should we manually call @StateObject initializer
// https://sarunw.com/posts/manually-initialize-stateobject/
// 可以手动初始化@StateObject吗？
// 可以。问题和@State一样。只会初始化1次，后续变化不会影响@StateObject的值
// @StateObject private var viewModel: DashboardViewModel
//
// init(name: String) {
//     _viewModel = StateObject(wrappedValue: DashboardViewModel(name: name))
// }

import SwiftUI

struct StateVariable: View {
    @State private var externalCount = 2
    var body: some View {
        VStack {
            // 2
            CounterView(count: externalCount)// ✅ state变量只初始化一次，后续改变会影响内部，所以不建议使用这种方式

            
            Text("External Count: \(externalCount)")
            Button("External +1") {
                // 3
                externalCount += 1

            }
        }
        .font(.title)
        
    }
    
    struct CounterView: View {
        @State private var count: Int
        
        init(count: Int) {

            // ✅ Xcode14简化了 初始化state变量的写法
//            _count = State(initialValue: count)
            self.count = count

        }
        
        var body: some View {
            VStack {
                Text("Counter: \(count)")
                Button("+1") {
                    count += 1
                }
            }
        }
    }
}
// ✅ 如何在@StateObject初始化时传参
struct StateObjectExample {
    struct User {
        let name: String // 1
    }

    class DashboardViewModel: ObservableObject {
        @Published var greeting: String
            
        init(name: String? = nil) { // 1 第一步提供默认值
            if let name = name {
                greeting = "Hello, \(name)!"
            } else {
                greeting = "Hello there"
            }
        }
        
        func update(name: String) { // 2 第二步提供更新方法
            greeting = "Hello, \(name)!"
        }
    }

    struct DashboardView: View {
        var user: User
        @StateObject var viewModel = DashboardViewModel()
        
        var body: some View {
            Text(viewModel.greeting)
                .padding()
                .onAppear {
                   viewModel.update(name: user.name) // 3 第三步更新
               }
        }
    }
}

struct StateVariable_Previews: PreviewProvider {
    static var previews: some View {
        StateVariable()
    }
}
