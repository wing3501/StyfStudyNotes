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
            EditButtonsView()
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
    
    func addEmptyTasks() {
        while tasks.count < 10 {
            tasks.append(Task(id: UUID(), title: ""))
        }
    }
    
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
    var body: some View {
        HStack {
            Button("取消",role: .cancel) {
                
            }
            .keyboardShortcut(.cancelAction) // 快捷键
            
            Spacer()
            
            Button("标记所有为未完成") {
                
            }
            
            Spacer()
            
            Button("保存") {
                
            }
        }
        .padding(12)
    }
}

struct EditTasksView_Previews: PreviewProvider {
    static var previews: some View {
        EditTasksView()
    }
}
