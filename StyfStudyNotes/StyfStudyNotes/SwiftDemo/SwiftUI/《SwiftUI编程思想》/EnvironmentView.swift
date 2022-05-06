//
//  EnvironmentView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/29.
//

import SwiftUI

struct EnvironmentView: View {
    var body: some View {
//        虽然为一个 VStack 设置字体没有直接的意义，但是这个字体设定并不会丢失;它会通过环境 被保留下来，树上的所有对此感兴趣的子 view 都可以使用它。
//        我们可以在 EnvironmentValues 类型上查找所有公开可用的环境属性。
//        SwiftUI 还在环境中存储了更多的属性。要查看这里所有东西，我们可以使用 transformEnvironment 修饰器并将 \.self 作为键路径传递进去。
        VStack {
            Text("这是绿色")
//                .transformEnvironment(\.font) { dump($0) }
        }
//        .font(.largeTitle)  //font 方法，其 实只是 .environment 函数的一个简单包装而已。
        .environment(\.font, .largeTitle)
    }
}

struct EnvironmentView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentView()
    }
}
