//
//  Preference.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/29.
//

import SwiftUI

//环境允许我们将值从一个父 view 隐式地传递给它的子 view，而 preference 系统则允许我们将 值隐式地从子 view 传递给它们的父 view。
struct Preference: View {
    var body: some View {
        MyNavigationView(content: Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .myNavigationTitle("标题")
            .background(.gray))
        
//        NavigationView {
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                .navigationTitle("标题")
//                .background(.gray)
//        }
        
    }
}

struct MyNavigationTitleKey: PreferenceKey {
    static var defaultValue: String? = nil
    //我们还需要一个 reduce 方法，来对应多个子树都定义了 navigation title 的情况
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = value ?? nextValue() //简单地选择第一个遇到的非 nil 值
    }
}

extension View {
    func myNavigationTitle(_ title: String) -> some View {
        preference(key: MyNavigationTitleKey.self, value: title)
    }
}

struct MyNavigationView<Content>: View where Content: View {
    let content: Content
    @State private var title: String? = nil
    var body: some View {
        VStack {
            Text(title ?? "")
            .font(Font.largeTitle)
            content.onPreferenceChange(MyNavigationTitleKey.self) { title in
                self.title = title
            }
        }
    }
}

struct Preference_Previews: PreviewProvider {
    static var previews: some View {
        Preference()
    }
}
