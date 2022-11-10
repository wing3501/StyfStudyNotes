//
//  WindowManagement.swift
//  TestMac
//
//  Created by styf on 2022/11/9.
//  Window management in SwiftUI  https://swiftwithmajid.com/2022/11/02/window-management-in-swiftui/

import SwiftUI

struct WindowManagement: View {
    @Environment(\.supportsMultipleWindows)
    private var supportsMultipleWindows
    
    var body: some View {
        // ✅ 判断是否支持多窗口
        if supportsMultipleWindows {
            Text("Supports multiple windows")
        } else {
            Text("Doesn't support multiple windows")
        }
    }
    
    struct TestMacApp1: App {
        var body: some Scene {
            #if os(macOS)
            // ✅ 定义一个单窗口
            Window("Statistics", id: "stats") {
                UsingNavigationSplitView()
            }
            #endif

            WindowGroup {
    //            UsingNavigationSplitView()
                WindowManagement()
            }
        }
    }
    // ✅ 使用openWindow和id打开新窗口
    struct Example: View {
        @Environment(\.openWindow) private var openWindow
        
        var body: some View {
            Button("Open statistics") {
                openWindow(id: "stats")
            }
        }
    }
    // ✅ 注册根据id显示item的窗口组
    struct MyApp: App {
        var body: some Scene {
            #if os(macOS)
//            WindowGroup(for: Item.ID.self) { $itemId in
//                ItemView(itemId: itemId ?? UUID())
//            }
            #endif
            
            WindowGroup {
//                ContentView()
            }
        }
    }
//    ✅ 使用openWindow和id打开新窗口
//    struct Example1: View {
//        @Environment(\.openWindow) private var openWindow
//
//        let items: [Item]
//
//        var body: some View {
//            List(items) { item in
//                Button("open \(item.title)") {
//                    openWindow(id: "item", value: item.id)
//                }
//            }
//        }
//    }
//    ✅ 使用MenuBarExtra定义菜单app
    struct MyApp1: App {
        var body: some Scene {
            #if os(macOS)
            MenuBarExtra {
//                MenuBarView()
            } label: {
                Label("MyApp", systemImage: "star")
            }
            #endif
            
            WindowGroup {
//                ContentView()
            }
        }
    }
    // ✅ 控制菜单图标是否隐藏
    struct MyApp2: App {
        @State private var menuBarExtraShown = true
        
        var body: some Scene {
            #if os(macOS)
            MenuBarExtra(isInserted: $menuBarExtraShown) {
//                MenuBarView()
            } label: {
                Label("MyApp", systemImage: "star")
            }
            .menuBarExtraStyle(.window) // ✅ 切换内容展示样式
            #endif
            
            WindowGroup {
//                ContentView()
            }
        }
    }
    
    
}





struct WindowManagement_Previews: PreviewProvider {
    static var previews: some View {
        WindowManagement()
    }
}
