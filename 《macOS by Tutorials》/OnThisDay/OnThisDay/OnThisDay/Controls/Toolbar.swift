//
//  Toolbar.swift
//  OnThisDay
//
//  Created by styf on 2022/9/9.
//

import SwiftUI

//struct Toolbar: ToolbarContent { ✅ 解决View菜单下Customize Toolbar不可用的问题
struct Toolbar: CustomizableToolbarContent {
//    var body: some ToolbarContent {
    var body: some CustomizableToolbarContent {
        // navigation 导航栏左侧
        // principal 导航栏中间
        // primaryAction 导航栏右侧
        // automatic
//        ToolbarItem(placement: .navigation) {
//            Button {
//                toggleSidebar()
//            } label: {
//                Image(systemName: "sidebar.left")
//            }
//            .help("Toggle Sidebar") //提示信息
//        }
        //📢 想要toolbar支持customize ，每个Item都必须有id
        ToolbarItem(id: "toggleSidebar", placement: .navigation) {
            Button {
                toggleSidebar()
            } label: {
                Label("Toggle Sidebar", systemImage: "sidebar.left")
            }
            .help("Toggle Sidebar") //提示信息
        }
    }
    
    func toggleSidebar() {
        // ✅ 提供第二种切换侧边栏的办法  NSApp.keyWindow获取最前面的window
        // SwiftUI的NavigationView 基于 AppKit的 NSSplitViewController
        NSApp.keyWindow?.contentViewController?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
