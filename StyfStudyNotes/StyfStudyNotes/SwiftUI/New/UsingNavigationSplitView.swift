//
//  UsingNavigationSplitView.swift
//  TestMac
//
//  Created by styf on 2022/11/9.
//  Mastering NavigationSplitView in SwiftUI
//  https://swiftwithmajid.com/2022/10/18/mastering-navigationsplitview-in-swiftui/

import SwiftUI

struct UsingNavigationSplitView: View {
    var body: some View {
        NavigationSplitView {
            Text("sidebar")
        } detail: {
            Text("item details")
        }
        .frame(minWidth: 700, idealWidth: 1000, maxWidth: .infinity, minHeight: 400, idealHeight: 800, maxHeight: .infinity)
    }
    // 两列
    struct TwoColumn: View {
        var body: some View {
            NavigationSplitView {
                // sidebar
            } detail: {
                // item details
            }
        }
    }
    // 三列
    struct ThreeColumn: View {
        var body: some View {
            NavigationSplitView {
                // sidebar
            } content: {
                // content list
            } detail: {
                // item details
            }
        }
    }
    // 三列的基本使用
    struct Example: View {
        @State private var selectedFolder: String?
        @State private var selectedItem: String?
        
        @State private var folders = [
            "All": [
                "Item1",
                "Item2"
            ],
            "Favorites": [
                "Item2"
            ]
        ]
        
        var body: some View {
            NavigationSplitView {
                List(selection: $selectedFolder) {
                    ForEach(Array(folders.keys.sorted()), id: \.self) { folder in
                        NavigationLink(value: folder) {
                            Text(verbatim: folder)
                        }
                    }
                }
                .navigationTitle("Sidebar")
            } content: {
                if let selectedFolder {
                    List(selection: $selectedItem) {
                        ForEach(folders[selectedFolder, default: []], id: \.self) { item in
                            NavigationLink(value: item) {
                                Text(verbatim: item)
                            }
                        }
                    }
                    .navigationTitle(selectedFolder)
                } else {
                    Text("Choose a folder from the sidebar")
                }
            } detail: {
                if let selectedItem {
                    NavigationLink(value: selectedItem) {
                        Text(verbatim: selectedItem)
                            .navigationTitle(selectedItem)
                    }
                } else {
                    Text("Choose an item from the content")
                }
            }
        }
    }
    
    
    // 第三列点击跳转到更深层
    struct Example1: View {
        @State private var selectedFolder: String?
        @State private var selectedItem: String?
        
        @State private var folders = [
            "All": [
                "Item1",
                "Item2"
            ],
            "Favorites": [
                "Item2"
            ]
        ]
        
        var body: some View {
            NavigationSplitView {
                List(selection: $selectedFolder) {
                    ForEach(Array(folders.keys.sorted()), id: \.self) { folder in
                        NavigationLink(value: folder) {
                            Text(verbatim: folder)
                        }
                    }
                }
                .navigationTitle("Sidebar")
            } content: {
                if let selectedFolder {
                    List(selection: $selectedItem) {
                        ForEach(folders[selectedFolder, default: []], id: \.self) { item in
                            NavigationLink(value: item) {
                                Text(verbatim: item)
                            }
                        }
                    }
                    .navigationTitle(selectedFolder)
                } else {
                    Text("Choose a folder from the sidebar")
                }
            } detail: {
                NavigationStack {
                    ZStack {
                        if let selectedItem {
                            NavigationLink(value: selectedItem) {
                                Text(verbatim: selectedItem)
                                    .navigationTitle(selectedItem)
                            }
                        } else {
                            Text("Choose an item from the content")
                        }
                    }
                    .navigationDestination(for: String.self) { text in
                        Text(verbatim: text)
                    }
                }
            }
        }
    }
    
    // 使用NavigationSplitViewVisibility来隐藏列
    // 使用navigationSplitViewStyle来设置样式
        // automatic
        // balanced 尝试通过减小详图列大小来显示前两列。
        // prominentDetail 重点介绍详细信息列。
    // 使用navigationSplitViewColumnWidth来设置列宽
    struct Example2: View {
        // automatic all doubleColumn detailOnly
        @State private var visibility: NavigationSplitViewVisibility = .all
        @State private var selectedFolder: String?
        @State private var selectedItem: String?
        
        @State private var folders = [
            "All": [
                "Item1",
                "Item2"
            ],
            "Favorites": [
                "Item2"
            ]
        ]
        
        var body: some View {
            NavigationSplitView(columnVisibility: $visibility) {
                List(selection: $selectedFolder) {
                    ForEach(Array(folders.keys.sorted()), id: \.self) { folder in
                        NavigationLink(value: folder) {
                            Text(verbatim: folder)
                        }
                    }
                }
                .navigationTitle("Sidebar")
            } content: {
                if let selectedFolder {
                    List(selection: $selectedItem) {
                        ForEach(folders[selectedFolder, default: []], id: \.self) { item in
                            NavigationLink(value: item) {
                                Text(verbatim: item)
                            }
                        }
                    }
                    .navigationTitle(selectedFolder)
                } else {
                    Text("Choose a folder from the sidebar")
                }
            } detail: {
                NavigationStack {
                    ZStack {
                        if let selectedItem {
                            NavigationLink(value: selectedItem) {
                                Text(verbatim: selectedItem)
                                    .navigationTitle(selectedItem)
                                    .toolbar {
                                        Button("Focus") {
                                            visibility = .detailOnly
                                        }
                                    }
                            }
                        } else {
                            Text("Choose an item from the content")
                        }
                    }
                    // 使用navigationSplitViewColumnWidth来设置列宽
//                    .navigationSplitViewColumnWidth(300)
                    .navigationDestination(for: String.self) { text in
                        Text(verbatim: text)
                    }
                }
            }
            // 使用navigationSplitViewStyle来设置样式
//            .navigationSplitViewStyle(.balanced)
        }
    }
    
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        UsingNavigationSplitView()
//    }
//}
