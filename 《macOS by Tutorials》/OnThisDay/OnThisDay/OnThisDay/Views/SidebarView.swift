//
//  SidebarView.swift
//  OnThisDay
//
//  Created by styf on 2022/9/8.
//

import SwiftUI

struct SidebarView: View {
    
    @EnvironmentObject var appState: AppState
    @AppStorage("showTotals") var showTotals = true
    
    @Binding var selection: EventType?
    
    var body: some View {
        List(selection: $selection) {
            Section("TODAY") {
                ForEach(EventType.allCases,id: \.self) { type in
                    Text(type.rawValue)
                        .badge(showTotals ? appState.countFor(eventType: type) : 0) //✅ 数字角标
                }
            }
        }
        .listStyle(.sidebar) //轻微的半透明
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(selection: .constant(nil))
            .frame(width: 200)
    }
}
