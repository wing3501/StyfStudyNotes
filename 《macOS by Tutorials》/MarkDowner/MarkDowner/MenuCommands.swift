//
//  MenuCommands.swift
//  MarkDowner
//
//  Created by styf on 2022/9/21.
//

import SwiftUI
import KeyWindow

struct MenuCommands: Commands {
    
    @AppStorage("styleSheet") var styleSheet: StyleSheet = .raywenderlich
    @AppStorage("editorFontSize") var editorFontSize: Double = 14
    @KeyWindowValueBinding(MarkDownerDocument.self) var document: MarkDownerDocument?
    
    var body: some Commands {
        CommandMenu("Display") {
            // 改变css的菜单项
            ForEach(StyleSheet.allCases,id: \.self) { style in
                Button {
                    styleSheet = style
                } label: {
                    Text(style.rawValue) //⚠️ 菜单项中的文字会忽略许多修饰符，但是可以使用颜色
                        .foregroundColor(style == styleSheet ? .accentColor : .primary)
                }
                .keyboardShortcut(KeyEquivalent(style.rawValue.first!))
            }
            
            Divider()
            
            // ✅ 子菜单  改变字体
            Menu("Font Size") {
                Button("Smaller") {
                    if editorFontSize > 8 {
                        editorFontSize -= 1
                    }
                }
                .keyboardShortcut("-")
                
                Button("Reset") {
                    editorFontSize = 14
                }
                .keyboardShortcut("0")
                
                Button("Larger") {
                    editorFontSize += 1
                }
                .keyboardShortcut("+")
            }
            
        }
        
        
        // ✅ 只针对活跃窗口的设置
        CommandMenu("Markdown") {
            Button("Bold") {
                document?.text += "**Bold**"
            }
            .keyboardShortcut("b")
            
            Button("Italic") {
                document?.text += "_Italic_"
            }
            .keyboardShortcut("i",modifiers: .command)
            
            Button("Link") {
                document?.text += "[Title](https://link_to_page)"
            }
            
            Button("Image") {
                document?.text += "![alt text](https://link_to_image)"
            }
        }
        
        // 替换help菜单项
        CommandGroup(replacing: .help) {// ✅ CommandGroup插入菜单项到标准菜单中
            // ✅ NavigationLink在菜单栏项中的使用
            NavigationLink(
              destination:
                WebView(
                  html: nil,
                  address: "https://baidu.com")
                .frame(minWidth: 600, minHeight: 600)
            ) {
              Text("Markdown Help")
            }
        }
    }
}
