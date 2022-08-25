//
//  UsingGrid.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/25.
//  【WWDC22 10056】在 SwiftUI 中组合各种自定义布局: https://xiaozhuanlan.com/topic/1507368249
//   Mastering grid layout in SwiftUI https://swiftwithmajid.com/2022/08/10/mastering-grid-layout-in-swiftui/

import SwiftUI

struct UsingGrid: View {
    var body: some View {
        //需求一：第一和第三列的宽度取决于它们所在行内容最大的宽度
        NewGridDemo1()
        //需求二：第一列名称文本左对齐；第三列的数量文本右对齐。
        //需求三：每行加分隔线
        NewGridDemo2()
    }
}

struct UsingGrid_Previews: PreviewProvider {
    static var previews: some View {
        UsingGrid()
    }
}
