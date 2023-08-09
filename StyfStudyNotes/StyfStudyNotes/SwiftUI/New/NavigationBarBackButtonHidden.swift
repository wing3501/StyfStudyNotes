//
//  NavigationBarBackButtonHidden.swift
//  StyfStudyNotes
//
//  Created by 申屠云飞 on 2023/8/8.
//  https://sarunw.com/posts/hide-navigation-back-button-in-swiftui/

import SwiftUI

struct NavigationBarBackButtonHidden: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Detail") {
                DetailView()
                    .navigationBarBackButtonHidden(true) // 1
                // 1 后退按钮将隐藏在该视图上。
                // 2 边缘轻扫以返回将被禁用
                // 总结，禁用了所有返回的方法，所以无法从DetailView返回
            }
        }
    }
}

#Preview {
    NavigationBarBackButtonHidden()
}
