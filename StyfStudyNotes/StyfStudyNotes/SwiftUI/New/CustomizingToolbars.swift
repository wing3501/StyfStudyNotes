//
//  CustomizingToolbars.swift
//
//
//  Created by styf on 2022/9/13.
//  Customizing toolbars in SwiftUI  https://swiftwithmajid.com/2022/09/07/customizing-toolbars-in-swiftui/

import SwiftUI

struct CustomizingToolbars: View {
    var body: some View {
        // 使用toolbar隐藏导航栏
//        Example1()
        // 使用toolbar隐藏tabbar
//        Example2()
        // 使用toolbarBackground隐藏导航栏背景色
//        Example3()
        // 使用toolbarColorScheme设置不依赖层级的Color Scheme
//        Example4()
        // 使用toolbarTitleMenu为导航栏增加一个点击菜单
//        Example5()
        // toolbarRole设置toolbar角色，可以添加删除secondary项目
//        CollapsingToolbarItems()
        
        
        SecondaryToolbarItemsExample()
    }
    
    // 使用toolbar隐藏导航栏
    struct Example1: View {
        var body: some View {
            NavigationView {
                ScrollView {
                    Image("xiang")
                        .resizable()
                        .scaledToFit()
                }
                .ignoresSafeArea(.container, edges: .top)
                .navigationTitle("Hello")
                .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
    // 使用toolbar隐藏tabbar
    struct Example2: View {
        enum MainTabIndex: Hashable {
            case home,account
        }
        @State var selection: MainTabIndex = .home
        var body: some View {
            TabView(selection: $selection) {
                VStack(content: {
                    Text("首页")
                })
                .tabItem {
                    Label("首页", systemImage: "house")
                }
                .tag(MainTabIndex.home)
                .toolbar(.hidden, for: .tabBar)
                
                VStack(content: {
                    Text("我的")
                })
                .tabItem {
                    Label("我的", systemImage: "person")
                }
                .tag(MainTabIndex.account)
            }
        }
    }
    // 使用toolbarBackground隐藏导航栏背景色
    struct Example3: View {
        var body: some View {
            NavigationView {
                ScrollView {
                    Image("xiang")
                        .resizable()
                        .scaledToFit()
                }
                .ignoresSafeArea(.container, edges: .top)
                .navigationTitle("Hello")
                .toolbarBackground(.hidden, for: .navigationBar)
            }
        }
    }
    // 使用toolbarColorScheme设置不依赖层级的Color Scheme
    struct Example4: View {
        var body: some View {
            NavigationView {
                ScrollView {
                    Image("xiang")
                        .resizable()
                        .scaledToFit()
                }
                .navigationTitle("Hello")
                .toolbarColorScheme(.dark, for: .navigationBar)
            }
        }
    }
    // 使用toolbarTitleMenu为导航栏增加一个点击菜单
    struct Example5: View {
        @State private var date = Date.now
        @State private var datePickerShown = false
        
        var body: some View {
            NavigationStack {
                Text(date, style: .date)
                    .navigationTitle(Text(date, style: .date))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarTitleMenu {
                        Button("Pick another date") {
                            datePickerShown = true
                        }
                    }
                    .sheet(isPresented: $datePickerShown) {
                        DatePicker(
                            "Choose date",
                            selection: $date,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                    }
            }
        }
    }
    
    // toolbarRole设置toolbar角色，可以添加删除secondary项目
    struct CollapsingToolbarItems: View {
        var body: some View {
            NavigationStack {
                Text("Hello")
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button("Primary action") {}
                        }
                        
                        ToolbarItem(
                            id: "copy",
                            placement: .secondaryAction,
                            showsByDefault: true
                        ) {
                            Button("copy") {}
                        }
                        
                        ToolbarItem(
                            id: "delete",
                            placement: .secondaryAction,
                            showsByDefault: false
                        ) {
                            Button("delete") {}
                        }
                    }
                    .toolbarRole(.editor)
            }
        }
    }
    // 自动将secondaryAction折叠进菜单
    struct SecondaryToolbarItemsExample: View {
        var body: some View {
            NavigationStack {
                Text("Hello")
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button("Primary action") {}
                        }
                        
                        ToolbarItem(placement: .secondaryAction) {
                            Button("Secondary action 1") {}
                        }
                        
                        ToolbarItem(placement: .secondaryAction) {
                            Button("Secondary action 2") {}
                        }
                    }
                    
            }
        }
    }
}
