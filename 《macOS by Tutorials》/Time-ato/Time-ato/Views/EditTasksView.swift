//
//  EditTasksView.swift
//  Time-ato
//
//  Created by styf on 2022/9/20.
//

import SwiftUI

struct EditTasksView: View {
    
    @State private var dataStore = DataStore()
    @State private var tasks: [Task] = []
    
    var body: some View {
        VStack {
            ForEach($tasks) { $task in // ✅ 使用binding属性作为数据源，可以让数据的修改流转回 @State属性
                HStack(spacing: 20) {
                    TextField("", text: $task.title, prompt: Text("Task title"))
                        .textFieldStyle(.squareBorder)
                    
                    Image(systemName: task.status == .complete ? "checkmark.square" : "square")
                        .font(.title2)
                    
                    Button {
                        deleteTask(id: task.id)
                    } label: {
                        Image(systemName: "trash")
                    }

                }
            }
            .padding(.top, 12)
            .padding(.horizontal)
            
            Spacer()
            EditButtonsView(tasks: $tasks, dataStore: dataStore)
        }
        .frame(minWidth: 400, minHeight: 430)
        .onAppear {
            getTaskList()
        }
    }
    
    func getTaskList() {
        tasks = dataStore.readTasks()
        
        addEmptyTasks()
    }
    ///  补齐10个任务
    func addEmptyTasks() {
        while tasks.count < 10 {
            tasks.append(Task(id: UUID(), title: ""))
        }
    }
    
    /// 删除任务
    func deleteTask(id: UUID) {
        let taskIndex = tasks.firstIndex {
            $0.id == id
        }
        if let taskIndex {
            tasks.remove(at: taskIndex)
            addEmptyTasks()
        }
    }
    
}

struct EditButtonsView: View {
    @Binding var tasks: [Task]
    let dataStore: DataStore
    
    var body: some View {
        HStack {
            Button("取消",role: .cancel) {
                closeWindow()
            }
            .keyboardShortcut(.cancelAction) // 快捷键
            
            Spacer()
            
            Button("标记所有为未完成") {
                markAllTasksIncomplate()
            }
            
            Spacer()
            
            Button("保存") {
                saveTasks()
            }
        }
        .padding(12)
    }
    
    func closeWindow() {
        NSApp.keyWindow?.close()
    }
    
    func saveTasks() {
        tasks = tasks.filter({
            !$0.title.isEmpty
        })
        dataStore.save(tasks: tasks)
        closeWindow()
        NotificationCenter.default.post(name: .dataRefreshNeeded, object: nil)
    }
    
    func markAllTasksIncomplate() {
        for index in 0 ..< tasks.count {
            tasks[index].reset()
        }
    }
}

struct EditTasksView_Previews: PreviewProvider {
    static var previews: some View {
        EditTasksView()
    }
}
