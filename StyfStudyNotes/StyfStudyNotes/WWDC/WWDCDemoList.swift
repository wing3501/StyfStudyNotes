//
//  WWDCDemoList.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/6/28.
//

import SwiftUI

struct WWDCDemoList: View {
    
    @State var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                NavigationLink("【WWDC22 110379】创建一个响应速度更快的媒体应用", value: 0)
                NavigationLink("【WWDC22 10054】SwiftUI 新导航方案", value: 1)
            }
            .navigationDestination(for: Int.self) { index in
                switch index {
                case 0:
                    QuickmediaApp()
                case 1:
                    PoemBookStack()
                default:
                    EmptyView()
                }
            }
        }
    }
}

struct WWDCDemoList_Previews: PreviewProvider {
    static var previews: some View {
        WWDCDemoList()
    }
}
