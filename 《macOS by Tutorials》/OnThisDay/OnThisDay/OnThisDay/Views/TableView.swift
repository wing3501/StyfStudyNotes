//
//  TableView.swift
//  OnThisDay
//
//  Created by styf on 2022/9/13.
//

import SwiftUI

struct TableView: View {
    var tableData: [Event]
    // ✅ Table排序的使用 1
    @State private var sortOrder = [KeyPathComparator(\Event.year)]
    // ✅ Table选中的使用 1
    @State private var selectedEventID: UUID?
//    @State private var selectedEventID: Set<UUID> = [] //✅ 对多行选中的支持
    
    var sortedTableData: [Event] {//Table排序的使用 4 使用排序描述
        return tableData.sorted(using: sortOrder)
    }
    
    var selectedEvent: Event? {
        guard let selectedEventID else { return nil }
        
        let event = tableData.first {
            $0.id == selectedEventID
        }
        
        return event
    }
    
    var body: some View {
        // ✅ Table的使用
        HStack {
            Table(sortedTableData,selection: $selectedEventID,sortOrder: $sortOrder) { //Table排序的使用 2 绑定 Table选中的使用 2
                
                TableColumn("Year",value: \.year) { //Table排序的使用 3 设置keypath
                    Text($0.year)
                }
                .width(min: 50, ideal: 60, max: 100) // 防止拖动分隔线把一侧变得过大或者过小
    //            TableColumn("Title") {
    //                Text($0.text)
    //            }
                TableColumn("Title", value: \.text)// 简写
            }
            //  .tableStyle(.automatic)
            //  .tableStyle(.inset)
//              .tableStyle(.inset(alternatesRowBackgrounds: false))
            //  .tableStyle(.bordered)
            //  .tableStyle(.inset(alternatesRowBackgrounds: false))
            
            if let selectedEvent {
                EventView(event: selectedEvent)
                    .frame(width: 250)
            } else {
                Text("选择一项事件查看详情")
                    .font(.title3)
                    .padding()
                    .frame(width: 250)
            }
        }
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(tableData: [Event.sampleEvent])
    }
}
