//
//  MarkDownerApp.swift
//  MarkDowner
//
//  Created by styf on 2022/9/21.
//

import SwiftUI
import KeyWindow

@main
struct MarkDownerApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: MarkDownerDocument()) { file in
            ContentView(document: file.$document)
                .observeWindow() //监听活跃窗口
        }
        .commands {
            MenuCommands()
        }
    }
}
