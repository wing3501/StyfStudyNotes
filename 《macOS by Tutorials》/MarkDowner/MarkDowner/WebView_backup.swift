//
//  WebView.swift
//  MarkDowner
//
//  Created by styf on 2022/9/21.
//

import SwiftUI
import WebKit
// ✅ SwiftUI调用AppKit组件
struct WebView1: NSViewRepresentable {
    
    @AppStorage("styleSheet") var styleSheet: StyleSheet = .raywenderlich
    
    // ⚠️ MarkdownKit生成的HTML代码，不包含<head>，所以要修改样式，必须手动插入
    // ⚠️ 设置baseURL: Bundle.main.resourceURL，则只需要文件名即可定位css文件
    var formattedHtml: String {
        return """
        <html>
        <head>
            <link href="\(styleSheet).css" rel="stylesheet">
        </head>
        <body>
            \(html)
        </body>
        </html>
        """
    }
    
    typealias NSViewType = WKWebView
   
    var html: String
    
    init(html: String) {
        self.html = html
    }
    
    func makeNSView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(formattedHtml, baseURL: Bundle.main.resourceURL)
    }
}
