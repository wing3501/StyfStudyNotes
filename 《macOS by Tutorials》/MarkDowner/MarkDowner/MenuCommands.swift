//
//  MenuCommands.swift
//  MarkDowner
//
//  Created by styf on 2022/9/21.
//

import SwiftUI

struct MenuCommands: Commands {
    
    @AppStorage("styleSheet") var styleSheet: StyleSheet = .raywenderlich
    @AppStorage("editorFontSize") var editorFontSize: Double = 14
    
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
        
        // more menus
    }
}
