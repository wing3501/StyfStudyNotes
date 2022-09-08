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
    
    var windowTitle: String {
        if let eventType {
            return "On This Day - \(eventType.rawValue)"
        }
        return "On This Day"
    }
    
    var events: [Event] {
        appState.dataFor(eventType: eventType)
    }
    
    var body: some View {
        NavigationView {
            SidebarView(selection: $eventType)
            GridView(gridData: events)
        }
        .frame(minWidth: 700, idealWidth: 1000, maxWidth: .infinity, minHeight: 400, idealHeight: 800, maxHeight: .infinity)
        .navigationTitle(windowTitle) //✅ 标题
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
