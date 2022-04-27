//
//  ViewExtension.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/27.
//

import Foundation
import SwiftUI

extension View {
    func overlaySheet<Content: View>(isPresented: Binding<Bool>,@ViewBuilder content: @escaping () -> Content) -> some View {
        overlay {
            OverlaySheet(isPresented: isPresented, content: content)
        }
    }
}
