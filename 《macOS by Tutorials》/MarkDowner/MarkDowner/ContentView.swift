//
//  ContentView.swift
//  MarkDowner
//
//  Created by styf on 2022/9/21.
//

import SwiftUI
import KeyWindow

enum PreviewState {
    case web
    case code
    case off
}

struct ContentView: View {
    @Binding var document: MarkDownerDocument
    
    @State private var previewState = PreviewState.web
    
    @AppStorage("editorFontSize") var editorFontSize: Double = 14

    var body: some View {
        HSplitView {
            TextEditor(text: $document.text)
                .frame(minWidth: 200)
            if previewState == .web {
                WebView(html: document.html)// ✅ WKWebview加载本地HTML，依赖需要打开沙盒权限
                    .frame(minWidth: 200)
            }else if previewState == .code {
                ScrollView {
                    Text(document.html)
                        .frame(minWidth: 200)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                        .padding()
                        .textSelection(.enabled)
                }
            }
        }
        .frame(minWidth: 400,
               idealWidth: 600,
               maxWidth: .infinity,
               minHeight: 300,
               idealHeight: 400,
               maxHeight: .infinity)
        .font(.system(size: editorFontSize))
        .keyWindow(MarkDownerDocument.self, $document)
        .toolbar {
            // 工具栏项目-切换源码和预览
            ToolbarItem {
                Picker("", selection: $previewState) {
                    Image(systemName: "network")
                        .tag(PreviewState.web)
                    Image(systemName: "chevron.left.forwardslash.chevron.right")
                        .tag(PreviewState.code)
                    Image(systemName: "nosign")
                        .tag(PreviewState.off)
                }
                .pickerStyle(.segmented)
                .help("Hide preview,show Html or web view") //可达性提示条
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(MarkDownerDocument()))
    }
}
