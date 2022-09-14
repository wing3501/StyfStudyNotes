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

// ✅修改target名称，可以便捷地使用带空格的应用名   也可以修改Build Setting中的Product Name
// ✅macOS app的不会自动对应用图标做圆角处理
// ✅使用Bakery生成图标

@main
struct OnThisDayApp: App {
    
    @StateObject var appState = AppState() //多个窗口共享
    @AppStorage("displayMode") var displayMode = DisplayMode.auto //应用内部管理显示模式
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onAppear {
                    DisplayMode.changeDisplayMode(to: displayMode)
                }
                .onChange(of: displayMode) { newValue in
                    DisplayMode.changeDisplayMode(to: newValue)
                }
        }
        .commands {
            // ✅ 添加系统菜单
            Menus()
        }
        // ✅ `添加偏好设置`
        Settings {
            PreferencesView()
        }
    }
}
