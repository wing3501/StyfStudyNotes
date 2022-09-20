//
//  MenuManager.swift
//  Time-ato
//
//  Created by styf on 2022/9/19.
//

import AppKit
// 管理动态菜单项
class MenuManager: NSObject {
    let statusMenu: NSMenu
    var menuIsOpen = false
    
//    var tasks = Task.sampleTasksWithStatus
    let taskManager = TaskManager()
    
    let itemsBeforeTasks = 2
    let itemsAfterTasks = 6
    
    init(statusMenu: NSMenu) {
        self.statusMenu = statusMenu
        super.init()
    }
    
    /// 清理任务项
    func clearTasksFromMenu() {
        let stopAtIndex = statusMenu.items.count - itemsAfterTasks
        
        for _ in itemsBeforeTasks ..< stopAtIndex {
            statusMenu.removeItem(at: itemsBeforeTasks)
        }
    }
    /// 添加任务项
    func showTasksInMenu() {
        var index = itemsBeforeTasks
        var taskCounter = 0
        
        let itemFrame = NSRect(x: 0, y: 0, width: 270, height: 40)
        for task in taskManager.tasks {
            let item = NSMenuItem()
//            item.title = task.title
            // ✅ 使用 自定义视图
            let view = TaskView(frame: itemFrame)
            view.task = task
            item.view = view
            
            statusMenu.insertItem(item, at: index)
            index += 1
            taskCounter += 1
            
            if taskCounter.isMultiple(of: 4) {
                statusMenu.insertItem(NSMenuItem.separator(), at: index)// ✅ 插入分隔线
                index += 1
            }
        }
    }
}

extension MenuManager: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        menuIsOpen = true
        showTasksInMenu()
    }
    
    func menuDidClose(_ menu: NSMenu) {
        menuIsOpen = false
        clearTasksFromMenu()
    }
}
