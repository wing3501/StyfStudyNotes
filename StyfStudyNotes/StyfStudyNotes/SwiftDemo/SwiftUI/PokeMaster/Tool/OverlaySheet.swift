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
        .edgesIgnoringSafeArea(.bottom)
    }
}
