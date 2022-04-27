//
//  OverlaySheet.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/27.
//

import SwiftUI

struct OverlaySheet<Content: View>: View {
    
    private let isPresented: Binding<Bool>
    private let makeContent: () -> Content
    
    init(isPresented: Binding<Bool>,
         @ViewBuilder content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.makeContent = content
    }
    
    var body: some View {
        VStack {
            Spacer()
            makeContent()
        }
        .offset(y: isPresented.wrappedValue ? 0 : UIScreen.main.bounds.height)
        // 添加动画
        .animation(.interpolatingSpring(stiffness: 70, damping: 12), value: isPresented.wrappedValue)
        .edgesIgnoringSafeArea(.bottom)
    }
}
