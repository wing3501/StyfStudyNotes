//
//  ContainersDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/16.
//

import SwiftUI

struct ContainersDemo: View {
    var body: some View {
        //GroupBox的使用
//        UsingGroupBox()
        //TabView和List的角标
//        AddBadge()
        //在NavigationView中创建底部工具条
//        CreateAToolbar()
        //使用DisclosureGroup收起和展开内容
        UsingDisclosureGroup()
        //隐藏、显示状态栏
//        HideStatusBar()
        //创建滚动型TabView
//        CreateScrollingPages()
        //使用TabView
//        UsingTabView()
        //在导航条上添加项目
//        AddBarItems()
        //使用导航NavigationView
//        UsingNavigationView()
    }
}
//-----------------------------

struct UsingGroupBox: View {
    //SwiftUI的GroupBox视图将视图组合在一起，并在它们后面放置一个浅色背景，使它们显得格外突出
    var body: some View {
//        TestWrap("GroupBox的使用") {

//        GroupBox {
//            Text("Your account")
//                .font(.headline)
//            Text("Username: tswift89")
//            Text("City: Nashville")
//        }
        //控制布局
//        GroupBox {
//            VStack(alignment: .leading) {
//                Text("Your account")
//                    .font(.headline)
//                Text("Username: tswift89")
//                Text("City: Nashville")
//            }
//        }
        //嵌套使用
//        GroupBox {
//            Text("Outer Content")
//
//            GroupBox {
//                Text("Middle Content")
//
//                GroupBox {
//                    Text("Inner Content")
//                }
//            }
//        }
        //添加标题
        GroupBox("Your account") {
            VStack(alignment: .leading) {
                Text("Username: tswift89")
                Text("City: Nashville")
            }
        }
//        }
    }
}
//-----------------------------

struct AddBadge: View {
    @State private var revealDetails = false
    var body: some View {
//        TestWrap("TabView和List的角标") {
//        TabView {
//            Text("Your home screen here")
//                .tabItem {
//                    Label("Home", systemImage: "house")
//                }
//                .badge(5)
//        }
        
        
        List {
            Text("Wi-Fi")
                .badge("LAN Solo")

            Text("Bluetooth")
                .badge("On")
        }
//        }
    }
}

//-----------------------------

struct CreateAToolbar: View {
    @State private var revealDetails = false
    var body: some View {
//        TestWrap("在NavigationView中创建底部工具条") {
        NavigationView {
            Text("Hello, World!").padding()
                .navigationTitle("SwiftUI")
                .toolbar {
//                    ToolbarItem(placement: .bottomBar) {
//                        Button("Press Me") {
//                            print("Pressed")
//                        }
//                    }
                    //多个按钮使用ToolbarItemGroup
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button("First") {
                            print("Pressed")
                        }
                        
                        Button("Second") {
                            print("Pressed")
                        }
                    }
                }
        }
//        }
    }
}
//-----------------------------

struct UsingDisclosureGroup: View {
    @State private var revealDetails = false
    var body: some View {
//        TestWrap("使用DisclosureGroup收起和展开内容") {
//        DisclosureGroup("Show Terms") {
//            Text("Long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here.")
//        }
//        .frame(width: 300)
        
        DisclosureGroup("Show Terms", isExpanded: $revealDetails) {
            Text("Long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here.")
        }
        .frame(width: 300)
//        }
    }
}
//-----------------------------

struct HideStatusBar: View {
    @State private var hideStatusBar = false
    var body: some View {
//        TestWrap("隐藏、显示状态栏") {
//        Text("No status bar, please")
//            .statusBar(hidden: true)
        
        Button("Toggle Status Bar") {
            withAnimation {
                hideStatusBar.toggle()
            }
        }
        .statusBar(hidden: hideStatusBar)
//        }
    }
}

//-----------------------------

struct CreateScrollingPages: View {
    
    var body: some View {
//        TestWrap("创建滚动型TabView") {
        TabView {
            Text("First")
            Text("Second")
            Text("Third")
            Text("Fourth")
        }
//        .tabViewStyle(.page)
        .background(.yellow)
//        .indexViewStyle(.page(backgroundDisplayMode: .always))//让小点也有背景
        .tabViewStyle(.page(indexDisplayMode: .never))//隐藏点
//        }
    }
}

//-----------------------------

struct UsingTabView: View {
    @State var selectedView = 1
    var body: some View {
//        TestWrap("使用TabView") {
//        TabView {
//            Text("First View")
//                .padding()
//                .tabItem {
////                    Image(systemName: "1.circle")
////                    Text("First")
//                    Label("First", systemImage: "1.circle")
//                }
//                .tag(1)
//            Text("Second View")
//                .padding()
//                .tabItem {
//                    Image(systemName: "2.circle")
//                    Text("Second")
//                }
//                .tag(2)
//        }
        
        //选项卡的选中
        TabView(selection: $selectedView) {
            Button("Show Second View") {
                selectedView = 2
            }
            .padding()
            .tabItem {
                Label("First", systemImage: "1.circle")
            }
            .tag(1)

            Button("Show First View") {
                selectedView = 1
            }
            .padding()
            .tabItem {
                Label("Second", systemImage: "2.circle")
            }
            .tag(2)
        }
//        }
    }
}

//-----------------------------

struct AddBarItems: View {
    
    var body: some View {
//        TestWrap("在导航条上添加项目") {
        NavigationView {
            Text("SwiftUI")
                .navigationTitle("Welcome")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
//                    Button("Help") {//没有指定位置，默认在后缘
//                        print("Help tapped!")
//                    }
                    //指定按钮在前缘
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button("Help") {
//                            print("Help tapped!")
//                        }
//                    }
                    //多个按钮在一起
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button("About") {
                            print("About tapped!")
                        }

                        Button("Help") {
                            print("Help tapped!")
                        }
                    }
                }
        }
        
//        }
    }
}
//-----------------------------

struct UsingNavigationView: View {
    @State private var showingAdvancedOptions = false
    @State private var enableLogging = false
    var body: some View {
//        TestWrap("使用导航NavigationView") {
        NavigationView {
            Text("This is a great app")
                .navigationTitle("Welcome")
                .navigationBarTitleDisplayMode(.inline)
        }
        
//        }
    }
}
//-----------------------------

struct ContainersDemo_Previews: PreviewProvider {
    static var previews: some View {
        ContainersDemo()
    }
}
