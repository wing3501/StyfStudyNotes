//
//  CounterView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/29.
//

import SwiftUI

struct CounterView: View {
    //    SwiftUI 只会重新去执行那些使用了 @State 属性的 view 的 body (对于其他属性包装，例如 @ObservedObject 和 @Environment，也是一样的)
    @State var counter = 0
    var body: some View {
        print("ContentView")
        return VStack {
            Button("按钮") {
                counter += 1
            }
            LabelView(number: $counter)
        }
    }
    
    //    本质上来说，binding 是它所捕获变量的 setter 和 getter。SwiftUI 的属性包装 (比如 @State， @ObservedObject 等) 都有对应的 binding，你可以在属性名前加上 $ 前缀来访问它。(在属性 包装的术语中，binding 被叫做一个投射值 (projected value)。) 如上例所示，SwiftUI 会追踪 哪些 view 使用了哪些 state 变量:它知道 ContentView 在渲染 body 时并没有用到 counter， 但 LabelView (通过 binding 间接地) 用到了它。因此，对 counter 属性的更改只会触发对 LabelView body 的重新求值。

        struct LabelView: View {
    //        我们可以在 label view 里定义一个 binding (绑定)，然后在 content view 里声明 @State 属性 来达到类型的效果。当 counter 改变时，LabelView 的 body 会被重新执行，而 ContentView 的 body 并不会
            @Binding var number: Int
            var body: some View {
                print("LabelView")
                return Group {
                    if number > 0 {
                        Text("点击了\(number)次")
                    }
                }
            }
        }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
