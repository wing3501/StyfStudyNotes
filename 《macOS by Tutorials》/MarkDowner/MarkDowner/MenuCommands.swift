//
//  MenuCommands.swift
//  MarkDowner
//
//  Created by styf on 2022/9/21.
//

import SwiftUI

struct MenuCommands: Commands {
    
    @AppStorage("styleSheet") var styleSheet: StyleSheet = .raywenderlich
    
    var body: some Commands {
        CommandMenu("Display") {
            ForEach(StyleSheet.allCases,id: \.self) { style in
                Button {
                    styleSheet = style
                } label: {
                    Text(style.rawValue) //⚠️ 菜单项中的文字会忽略许多修饰符，但是可以使用颜色
                        .foregroundColor(style == styleSheet ? .accentColor : .primary)
                }
                .keyboardShortcut(KeyEquivalent(style.rawValue.first!))
            }
            // more menu ietms
        }
        
        // more menus
    }
}
