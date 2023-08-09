//
//  UseContentUnavailableView.swift
//  StyfStudyNotes
//
//  Created by 申屠云飞 on 2023/8/8.
//  https://sarunw.com/posts/content-unavailable-view-in-swiftui/
//Built-in unavailable views
//内置不可用视图
//Custom unavailable views
//自定义不可用视图
//Unavailable views with actions
//包含操作的不可用视图


import SwiftUI

@available(iOS 17.0, *)
struct UseContentUnavailableView: View {
    var body: some View {
        // 内置不可用视图 在 iOS 17 中，ContentUnavailableView 只有一个内置静态变量 search .
//        ContentUnavailableView.search
//        ContentUnavailableView.search(text: "styf")
        // 自定义不可用视图
//        ContentUnavailableView("标题", image: "Pokemon-25", description: Text("这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述"))
//        ContentUnavailableView("标题", systemImage: "wifi.exclamationmark", description: Text("这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述"))
        
        // 包含操作的不可用视图
        ContentUnavailableView {
            // 1
            Label("Empty Bookmarks", systemImage: "bookmark")

        } description: {
            Text("Explore a great movie and bookmark the one you love to enjoy later.")
        } actions: {
            // 2
            Button("Browse Movies") {
                // Go to the movie list.

            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        UseContentUnavailableView()
    } else {
        EmptyView()
    }
}
