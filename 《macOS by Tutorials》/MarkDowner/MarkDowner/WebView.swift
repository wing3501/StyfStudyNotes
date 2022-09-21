//
//  WebView.swift
//  MarkDowner
//
//  Created by styf on 2022/9/21.
//

import SwiftUI
import WebKit
// ✅ SwiftUI调用AppKit组件
struct WebView: NSViewRepresentable {
    typealias NSViewType = WKWebView
   
    var html: String
    
    init(html: String) {
        self.html = html
    }
    
    func makeNSView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(html, baseURL: Bundle.main.resourceURL)
    }
}
