//
//  Menus.swift
//  OnThisDay
//
//  Created by styf on 2022/9/9.
//

import SwiftUI

struct Menus: Commands {
    
    @AppStorage("showTotals") var showTotals = true
    @AppStorage("displayMode") var displayMode = DisplayMode.auto
    
    var body: some Commands {
        //✅ 侧边栏的控制由内置菜单完成
        SidebarCommands()
        ToolbarCommands()
        
        //✅ 在已有的菜单中加入一项，最多10项
        CommandGroup(before: .help) {
            Button("ZenQuotes.io web site") {
                showAPIWebSite()
            }
            .keyboardShortcut("/", modifiers: .command)
        }
        
        //✅ 添加一个新菜单
        CommandMenu("Display") {
            Toggle(isOn: $showTotals) {
                Text("Show Totals")
            }
            .keyboardShortcut("t", modifiers: .command)//⚠️ 不能重写和响应标准的快捷键，多个同名只会响应一个
//            .keyboardShortcut("t", modifiers: [.command,.shift,.option]) //多个修饰键 .all
            
            Divider()
            
            Picker("Appearance", selection: $displayMode) { //⚠️ 不支持快捷键
                ForEach(DisplayMode.allCases,id: \.self) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
            // 解决Picker不支持快捷键的问题
            Menu("Appearance") {
                Button("Light") {
                    displayMode = .light
                }
                .keyboardShortcut("L", modifiers: .command)
            }
        }
        
        // 内置菜单
//        EmptyCommands()
//        SidebarCommands()
//        ToolbarCommands()
//        TextEditingCommands()
//        TextFormattingCommands()
//        ImportFromDevicesCommands()
    }
    //✅ 打开网页
    func showAPIWebSite() {
        let address = "https://today.zenquotes.io"
        guard let url = URL(string: address) else {
            fatalError("Invalid address")
        }
        NSWorkspace.shared.open(url)
    }
}
