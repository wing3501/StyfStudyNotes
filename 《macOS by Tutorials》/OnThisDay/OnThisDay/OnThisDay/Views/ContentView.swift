//
//  ContentView.swift
//  OnThisDay
//
//  Created by styf on 2022/9/7.
//

import SwiftUI

enum ViewMode: Int {
    case grid
    case table
}

struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    
    // ✅ 使用 @SceneStorage 来保存不同window各自的数据。 @SceneStorage也是对UserDefaults的封装，但是每个window保存独一份
    @SceneStorage("eventType") private var eventType: EventType?
    @SceneStorage("searchText") private var searchText = ""
    @SceneStorage("viewMode") private var viewMode: ViewMode = .grid
    
    @SceneStorage("selectedDate") var selectedDate: String?
    
    var windowTitle: String {
        if let eventType {
            return "On This Day - \(eventType.rawValue)"
        }
        return "On This Day"
    }
    
    var events: [Event] {
//        appState.dataFor(eventType: eventType)
//        appState.dataFor(eventType: eventType,searchText: searchText)
        appState.dataFor(eventType: eventType, date: selectedDate, searchText: searchText)
    }
    
    var body: some View {
        NavigationView {
            SidebarView(selection: $eventType) //✅ 默认把这部分当作侧边栏
            if viewMode == .table {
                TableView(tableData: events)
            }else {
                GridView(gridData: events)
            }
        }
        .frame(minWidth: 700, idealWidth: 1000, maxWidth: .infinity, minHeight: 400, idealHeight: 800, maxHeight: .infinity)
        .navigationTitle(windowTitle) //✅ 标题 加在了右边容器上
        .toolbar(id: "mainToolbar") {//✅ 使用id 解决View菜单下Customize Toolbar不可用的问题
            Toolbar(viewMode: $viewMode) //✅ 工具条
        }
        .searchable(text: $searchText, prompt: "")//✅ 搜索框
        .onAppear {
            if eventType == nil {
                eventType = .events
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
