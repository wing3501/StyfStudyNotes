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
    @SceneStorage("selectedDate") var selectedDate: String?
    
    var body: some View {
        VStack {
            List(selection: $selection) {
                Section("TODAY") {
                    ForEach(EventType.allCases,id: \.self) { type in
                        Text(type.rawValue)
                            .badge(showTotals ? appState.countFor(eventType: type) : 0) //✅ 数字角标
                    }
                }
                //已下载的数据
                Section("AVAILABLE DATES") {
                    ForEach(appState.sortedDates, id: \.self) { date in
                        Button {
                            selectedDate = date
                        } label: {
                            HStack {
                                Text(date)
                                Spacer()
                            }
                        }
                        .controlSize(.large)
                        .modifier(DateButtonViewModifier(selected: date == selectedDate))
                    }
                }
            }
            .listStyle(.sidebar) //轻微的半透明
            
            Spacer()
            DayPicker()
        }
        .frame(minWidth: 220)
    }
}

struct DateButtonViewModifier: ViewModifier {
    var selected: Bool
    
    func body(content: Content) -> some View {
        if selected {
            content.buttonStyle(.borderedProminent)
        }else {
            content
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(selection: .constant(nil))
            .frame(width: 200)
    }
}
