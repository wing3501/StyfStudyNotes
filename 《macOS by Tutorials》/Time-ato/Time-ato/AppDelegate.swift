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
//        添加一项 Application is agent = YES

// ✅ 坐标系起点是左下角

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    // ✅ 创建状态栏项
    var statusItem: NSStatusItem?
    @IBOutlet weak var statusMenu: NSMenu! // 连接到storyboard中Main Menu -> Time-ato -> Menu
    
    var menuManager: MenuManager?
    
    @IBOutlet weak var startStopMenuItem: NSMenuItem!
    @IBOutlet weak var launchOnLoginMenuItem: NSMenuItem!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // 1 初始化一个可变长度的状态项
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // 2 设置菜单
        statusItem?.menu = statusMenu
        
        // 3
        statusItem?.button?.title = "Time-ato"
        statusItem?.button?.imagePosition = .imageLeading
        statusItem?.button?.image = NSImage(systemSymbolName: "timer", accessibilityDescription: "Time-ato")
        
        // 4 设置等宽的字体
        statusItem?.button?.font = NSFont.monospacedDigitSystemFont(ofSize: NSFont.systemFontSize, weight: .regular)
        // ⚠️ 默认菜单项全是灰色，因为默认启用了Auto Enables Items,没有附加action就会置灰
        menuManager = MenuManager(statusMenu: statusMenu)
        statusMenu.delegate = menuManager
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    /// 完成当前任务或者开始下一个任务
    @IBAction func startStopTask(_ sender: Any) {
        menuManager?.taskManager.toggleTask()
    }
    
    @IBAction func showEditTasksWindow(_ sender: Any) {
        
    }
    
    @IBAction func toggleLaunchOnLogin(_ sender: Any) {
        
    }
    
    func update(title: String,icon: String,taskIsRunning: Bool) {
        
    }
    
    func updateMenu(title: String,icon: String,taskIsRunning: Bool) {
        // 更新状态栏项的标题、图片
        statusItem?.button?.title = title
        statusItem?.button?.image = NSImage(systemSymbolName: icon, accessibilityDescription: title)
        updateMenuItemTitles(taskIsRunning: taskIsRunning)
    }
    
    func updateMenuItemTitles(taskIsRunning: Bool) {
        if taskIsRunning {
            startStopMenuItem.title = "标记任务为完成"
        }else {
            startStopMenuItem.title = "开始下一个任务"
        }
    }
}

