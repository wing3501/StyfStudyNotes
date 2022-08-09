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
                NavigationLink("【WWDC22 10062】初见 Transferable", value: 2)
                NavigationLink("【WWDC22 10052】What's New In SwiftUI", value: 3)
                NavigationLink("【WWDC22 10026】沟通影像世界的新桥梁——实况文本 API 介绍", value: 4)
                NavigationLink("【WWDC22 10136/10137/110340/110342】Swift Charts 高效图表的实现与优质图表设计要素", value: 5)
            }
            .navigationDestination(for: Int.self) { index in
                switch index {
                case 0:
                    QuickmediaApp()
                case 1:
                    PoemBookStack()
                case 2:
                    TransferableDemo()
                case 3:
                    WhatsNewInSwiftUI()
                case 4:
                    LiveTextView()
                case 5:
                    UsingChart()
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
