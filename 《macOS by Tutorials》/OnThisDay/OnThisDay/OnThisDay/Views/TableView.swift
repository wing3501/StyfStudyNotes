//
//  TableView.swift
//  OnThisDay
//
//  Created by styf on 2022/9/13.
//

import SwiftUI

struct TableView: View {
    var tableData: [Event]
    
    var body: some View {
        // ✅ Table
        Table(tableData) {
            TableColumn("Year") {
                Text($0.year)
            }
            .width(min: 50, ideal: 60, max: 100) // 防止拖动分隔线把一侧变得过大或者过小
            TableColumn("Title") {
                Text($0.text)
            }
        }
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(tableData: [Event.sampleEvent])
    }
}
