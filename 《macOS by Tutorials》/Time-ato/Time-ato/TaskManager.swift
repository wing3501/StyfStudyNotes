//
//  TaskManager.swift
//  Time-ato
//
//  Created by styf on 2022/9/20.
//

import Foundation
import Combine
import AppKit

// ✅ 两种使用定时器的选择
// 1. scheduledTimer
// 2. Combine

class TaskManager {
    var tasks: [Task] = Task.sampleTasks
    
    var timerCancellable: AnyCancellable? //析构的时候会自动调用cancel()，去取消订阅，释放资源
    var timerState = TimerState.waiting //管理定时器的状态
    
    init() {
        startTimer()
    }
    
    func startTimer() {
        timerCancellable = Timer
                    //时间间隔 秒    容差
            .publish(every: 1, tolerance: 0.5, on: .current, in: .common) //⚠️ 如果设置为default Mode，则当菜单打开时不会更新
                                                                        // common = default + modalPanel + eventTracking
                                                                        // modalPanel: 当有保存、加载面板对话框出现时
                                                                        // eventTracking: 当有事件被跟踪，比如菜单打开
            .autoconnect() //作用是：当有第一个订阅者时就自动连接
            .sink(receiveValue: { time in
                self.checkTimings()
            })
    }
    /// 完成当前任务或者开始下一个任务
    func toggleTask() {
        if let activeTaskIndex = timerState.activeTaskIndex {
            stopRunningTask(at: activeTaskIndex)
        }else {
            startNextTask()
        }
    }
    /// 找到未开始的任务，开始任务
    func startNextTask() {
        let nextTaskIndex = tasks.firstIndex {
            $0.status == .notStarted
        }
        if let nextTaskIndex {
            tasks[nextTaskIndex].start()
            timerState = .runningTask(taskIndex: nextTaskIndex)
        }
    }
    /// 标记任务为完成
    func stopRunningTask(at taskIndex: Int) {
        tasks[taskIndex].complete()
        timerState = .waiting
    }
    
    func checkTimings() {
        let taskIsRunning = timerState.activeTaskIndex != nil
        // more checks here
        
        if let appDelegate = NSApp.delegate as? AppDelegate {
            let (title, icon) = menuTitleAndIcon
            // 更新状态栏项的文字图片 和 开始停止任务菜单项的文字
            appDelegate.updateMenu(title: title, icon: icon, taskIsRunning: taskIsRunning)
        }
    }
}
