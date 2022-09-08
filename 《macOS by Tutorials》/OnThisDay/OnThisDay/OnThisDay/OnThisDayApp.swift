//
//  OnThisDayApp.swift
//  OnThisDay
//
//  Created by styf on 2022/9/7.
//

import SwiftUI

// ✅要点
// 多面板的使用：NavigationView
// 设置window的尺寸很重要
// SwiftUI在macOS app上的预览有些不同
// Mac 默认情况下会禁用网络连接

@main
struct OnThisDayApp: App {
    
    @StateObject var appState = AppState() //多个窗口共享
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
