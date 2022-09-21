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
                    Text(style.rawValue)
                }
                // keyboard shortcu
            }
            // more menu ietms
        }
        
        // more menus
    }
}
