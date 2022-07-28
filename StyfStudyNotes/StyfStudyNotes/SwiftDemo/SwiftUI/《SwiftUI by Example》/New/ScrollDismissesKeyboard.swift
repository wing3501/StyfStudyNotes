//
//  NewForSwiftUI.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/27.
//

import SwiftUI

struct ScrollDismissesKeyboard: View {
    var body: some View {
        
//        scrollDismissesKeyboard使用 滚动消失键盘
        Form {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .scrollDismissesKeyboard(.never)
        
//    Never: 滚动不会引起键盘收起
//    Immediately: 一滚动就收起
//    Interactively: 跟着滚动慢慢收起
        
    }
}

struct NewForSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        ScrollDismissesKeyboard()
    }
}
