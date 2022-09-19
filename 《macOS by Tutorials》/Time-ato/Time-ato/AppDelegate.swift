//
//  AppDelegate.swift
//  Time-ato
//
//  Created by styf on 2022/9/19.
//

import Cocoa

// ✅ 把一个基于window的APP转换为基于菜单的APP
//1 删除window和大部分菜单
//        选择storyboard中的View Controller Scene,Window Controller Scene，点击删除
//        Application Scene -> Application -> Main Menu，删除Time-ato以外的所有菜单项
//        删除Time-ato -> Menu 中，两个分隔线之间的项
//        删除ViewController.swift文件
//2 设置链接到菜单的状态栏项
//3 在info.plist配置


@main
class AppDelegate: NSObject, NSApplicationDelegate {

    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

