//
//  ContentView.swift
//  OnThisDay
//
//  Created by styf on 2022/9/7.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State private var eventType: EventType? = .events
    @State private var searchText = ""
    
    var windowTitle: String {
        if let eventType {
            return "On This Day - \(eventType.rawValue)"
        }
        return "On This Day"
    }
    
    var events: [Event] {
//        appState.dataFor(eventType: eventType)
        appState.dataFor(eventType: eventType,searchText: searchText)
    }
    
    var body: some View {
        NavigationView {
            SidebarView(selection: $eventType) //✅ 默认把这部分当作侧边栏
            GridView(gridData: events)
        }
        .frame(minWidth: 700, idealWidth: 1000, maxWidth: .infinity, minHeight: 400, idealHeight: 800, maxHeight: .infinity)
        .navigationTitle(windowTitle) //✅ 标题 加在了右边容器上
        .toolbar(id: "mainToolbar") {//✅ 解决View菜单下Customize Toolbar不可用的问题
            Toolbar() //✅ 工具条
        }
        .searchable(text: $searchText, prompt: "")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
