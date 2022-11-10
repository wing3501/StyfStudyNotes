//
//  StateVariable.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/11/10.
// @State variable initialization in SwiftUI
// https://sarunw.com/posts/state-variable-initialization/
// @State变量初始化的问题

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

struct StateVariable_Previews: PreviewProvider {
    static var previews: some View {
        StateVariable()
    }
}
