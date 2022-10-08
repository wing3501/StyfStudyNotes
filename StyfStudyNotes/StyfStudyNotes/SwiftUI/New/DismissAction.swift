//
//  DismissAction.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/10/8.
//  Using the dismiss action from the SwiftUI environment
//  https://nilcoalescing.com/blog/UsingTheDismissActionFromTheSwiftUIEnvironment/

import SwiftUI

struct DismissAction: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// ✅ dismiss sheet或popover
struct SheetContent: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button("Dismiss") {
            dismiss() // DismissAction 实现了 callAsFunction()
        }
        Button("Dismiss", action: dismiss.callAsFunction)
    }
}

// ✅ 也可以pop导航栈
struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button("Pop") {
            dismiss()
        }
    }
}
// ✅ 如果MyView被包装在UIHostingController中，dismiss可以
struct MyView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

// ✅ iOS15之前的处理
struct SheetContent1: View {
    @Environment(\.presentationMode) @Binding
    private var presentationMode

    var body: some View {
            Button("Dismiss") {
                presentationMode.dismiss()
            }
            // 另一种方式 
//            Button("Dismiss") {
//                presentationMode.wrappedValue.dismiss()
//            }
    }
}

struct DismissAction_Previews: PreviewProvider {
    static var previews: some View {
        DismissAction()
    }
}
