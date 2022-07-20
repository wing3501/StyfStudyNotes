//
//  WhatsNewInSwiftUI.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/19.
// 【WWDC22 10052】What's New In SwiftUI  https://xiaozhuanlan.com/topic/3615907284

import SwiftUI

struct WhatsNewInSwiftUI: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CalendarIcon: View {
    var body: some View {
        VStack {
            Image(systemName: "calendar")
            Text("June 6")
        }
//        今年对 SF Symbol 新增了阴影效果与渐变效果
        .background(in: Circle().inset(by: -20))
        .backgroundStyle(.blue.gradient)
        .foregroundStyle(
            .white.shadow(.drop(radius:1, y: 1.5))
        )
        .padding(20)
    }
}
struct WhatsNewInSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewInSwiftUI()
    }
}
