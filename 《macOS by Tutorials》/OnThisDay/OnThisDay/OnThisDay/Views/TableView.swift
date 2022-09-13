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
    
    var sortedTableData: [Event] {//Table排序的使用 4 使用排序描述
        return tableData.sorted(using: sortOrder)
    }
    
    var body: some View {
        // ✅ Table的使用
        Table(sortedTableData,sortOrder: $sortOrder) { //Table排序的使用 2 绑定
            TableColumn("Year",value: \.year) { //Table排序的使用 3 设置keypath
                Text($0.year)
            }
            .width(min: 50, ideal: 60, max: 100) // 防止拖动分隔线把一侧变得过大或者过小
//            TableColumn("Title") {
//                Text($0.text)
//            }
            TableColumn("Title", value: \.text)// 简写
            
        }
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(tableData: [Event.sampleEvent])
    }
}
