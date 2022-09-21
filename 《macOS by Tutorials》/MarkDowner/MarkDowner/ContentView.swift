//
//  ContentView.swift
//  MarkDowner
//
//  Created by styf on 2022/9/21.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: MarkDownerDocument

    var body: some View {
        HSplitView {
            TextEditor(text: $document.text)
                .frame(minWidth: 200)
            WebView(html: document.html)// ✅ WKWebview加载本地HTML，依赖需要打开沙盒权限
                .frame(minWidth: 200)
        }
        .frame(minWidth: 400,
               idealWidth: 600,
               maxWidth: .infinity,
               minHeight: 300,
               idealHeight: 400,
               maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(MarkDownerDocument()))
    }
}
