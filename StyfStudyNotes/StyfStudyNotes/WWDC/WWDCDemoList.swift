//
//  WWDCDemoList.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/6/28.
//

import SwiftUI

struct WWDCDemoList: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("【WWDC22 110379】创建一个响应速度更快的媒体应用", destination: QuickmediaApp())
                NavigationLink("【WWDC22 10054】SwiftUI 新导航方案", destination: PoemBookStack())
            }
        }
    }
}

struct WWDCDemoList_Previews: PreviewProvider {
    static var previews: some View {
        WWDCDemoList()
    }
}
