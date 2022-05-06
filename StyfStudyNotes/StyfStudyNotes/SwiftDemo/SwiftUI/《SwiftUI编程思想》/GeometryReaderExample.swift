//
//  GeometryReaderExample.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/5.
//

import SwiftUI

struct GeometryReaderExample: View {
    var body: some View {
        //有问题的写法
//        Text("Hello, World!")
//            .foregroundColor(.white)
//            .padding(10)
//            .background(
//                GeometryReader { proxy in
//                    Circle()
//                        .fill(Color.blue)
//                        .frame(width: proxy.size.width,
//                               height: proxy.size.width)
//            })
//    我们的策略是:使用 GeometryReader 来测量我们按钮中的 Text 尺寸。然后我们使用 preference 将这个值沿树向上传递，并在整个 view 外面加上一个高度和 宽度都等于文本宽度的 frame
        TextWithCircle()
    }
    
    struct TextWithCircle: View {
        @State private var width: CGFloat? = nil
        var body: some View {
            Text("Hello, World!")
                .background(GeometryReader(content: { proxy in
                    Color.clear.preference(key: WidthKey.self, value: proxy.size.width)
                }))
                .onPreferenceChange(WidthKey.self) { value in
//                    在 .onPreferenceChange 的过程中改变状态是 被允许的，但是我们需要注意不要写出无限循环
                    self.width = value
                }
                .frame(width: width, height: width)
                .background(Circle().fill(.yellow))
        }
    }
}

struct WidthKey: PreferenceKey {
    static var defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue() //不关心合并值，只取第一个
    }
}

struct GeometryReaderExample_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderExample()
    }
}
