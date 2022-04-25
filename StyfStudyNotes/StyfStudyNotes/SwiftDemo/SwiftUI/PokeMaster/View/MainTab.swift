//
//  MainTab.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import SwiftUI

struct MainTab: View {
    var body: some View {
        TabView {
            PokemonRootView().tabItem {
                //在 tabItem 里，只有 Image 和 Text 是被接受的，其他类型的 View 将被忽视
                Image(systemName: "list.bullet.below.rectangle")
                Text("列表")
            }
            SettingRootView().tabItem {
                Image(systemName: "gear")
                Text("设置")
            }
        }
        //TabView 默认会尊重 safe area 的顶部，这会导致 TabView 里的宝可梦列表 在滚动时无法达到 “刘海屏” 上部的状态栏，这不是我们需要的。使用 .edgesIgnoringSafeArea(.top) 忽略掉 safe area，让界面占满屏幕。
        .edgesIgnoringSafeArea(.top)
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
    }
}
