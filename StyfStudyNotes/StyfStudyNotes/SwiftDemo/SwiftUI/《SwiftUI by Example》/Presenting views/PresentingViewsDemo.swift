//
//  PresentingViewsDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/18.
//

import SwiftUI

struct PresentingViewsDemo: View {
    var body: some View {
        //禁止手势下拉关闭sheet
//        InteractiveDismissDisabled()
        //用Popover弹出一个新页面
        UsingPopover()
        //用sheet弹出一个新页面
//        PresentANewViewUsingSheets()
        //代码控制push到一个新的View
//        CodePushANewView()
        //从列表push到一个新的View
//        ListRowPushANewView()
        //push到一个新的View
//        PushANewView()
    }
}

//-----------------------------
struct InteractiveDismissDisabled: View {
    @State private var showingSheet = false
    var body: some View {
//        TestWrap("禁止手势下拉关闭sheet") {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet, content: ExampleSheet.init)
//        }
    }
}

struct ExampleSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var termsAccepted = false
    var body: some View {
        VStack {
            Text("Sheet view")

            Button("Dismiss", action: close)
        }
//        .interactiveDismissDisabled()
        .interactiveDismissDisabled(!termsAccepted) //也可以绑定一个值进行控制
        
    }

    func close() {
        presentationMode.wrappedValue.dismiss()
    }
}
//-----------------------------
struct UsingPopover: View {
    @State private var showingPopover = false
    var body: some View {
//        TestWrap("用Popover弹出一个新页面") {
        Button("Show Menu") {
            showingPopover = true
        }
        .popover(isPresented: $showingPopover) {
            Text("Your content here")
                .font(.headline)
                .padding()
        }
//        }
    }
}


//-----------------------------
struct PresentANewViewUsingSheets: View {
    @State private var showingSheet = false
    var body: some View {
//        TestWrap("用sheet弹出一个新页面") {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
//        .sheet(isPresented: $showingSheet) {
//            SheetView()
//        }
        //全屏
        .fullScreenCover(isPresented: $showingSheet) {
            SheetView()
        }
//        }
    }
}

struct SheetView: View {
    
    //dismiss页面的第一种方法
    @Environment(\.dismiss) var dismiss
    //支持iOS14
//    @Environment(\.presentationMode) var presentationMode
//    presentationMode.wrappedValue.dismiss()
    
    //dismiss页面的第二种方法  把绑定值传进来处理
    // @Binding private var showingSheet = false
    
    var body: some View {
        Button("Press to dismiss") {
            dismiss()
        }
        .font(.title)
        .padding()
        .background(.black)
    }
}

//-----------------------------
struct CodePushANewView: View {
    @State private var isShowingDetailView = false
    @State private var selection: String? = nil
    var body: some View {
//        TestWrap("代码控制push到一个新的View") {
//        NavigationView {
//            VStack {
//                NavigationLink(destination: Text("Second View"), isActive: $isShowingDetailView) { EmptyView() }
//
//                Button("Tap to show detail") {
//                    isShowingDetailView = true
//                }
//            }
//            .navigationTitle("Navigation")
//        }
        
        //多个跳转，使用非Bool的绑定值
        NavigationView {
            VStack {
                NavigationLink(destination: Text("View A"), tag: "A", selection: $selection) { EmptyView() }
                NavigationLink(destination: Text("View B"), tag: "B", selection: $selection) { EmptyView() }

                Button("Tap to show A") {
                    selection = "A"
                }

                Button("Tap to show B") {
                    selection = "B"
                }
            }
            .navigationTitle("Navigation")
        }
//        }
    }
}
//-----------------------------
struct ListRowPushANewView: View {
    let players = [
        "Roy Kent",
        "Richard Montlaur",
        "Dani Rojas",
        "Jamie Tartt",
    ]

    var body: some View {
//        TestWrap("从列表push到一个新的View") {
        NavigationView {
            List(players, id: \.self) { player in
                //自动给每一行加上了右侧的箭头
                NavigationLink(destination: PlayerView(name: player)) {
                    Text(player)
                }
            }
            .navigationTitle("Select a player")
        }
//        }
    }
}

struct PlayerView: View {
    let name: String

    var body: some View {
        Text("Selected player: \(name)")
            .font(.largeTitle)
    }
}
//-----------------------------

struct PushANewView: View {
    var body: some View {
//        TestWrap("push到一个新的View") {
            NavigationView {
                VStack {
                    NavigationLink(destination: SecondView()) {
                        Text("Show Detail View")
                    }
                    .navigationTitle("Navigation")
                }
            }
//        }
    }
}

struct SecondView: View {
    var body: some View {
        Text("This is the detail view")
    }
}
//-----------------------------
struct PresentingViewsDemo_Previews: PreviewProvider {
    static var previews: some View {
        PresentingViewsDemo()
    }
}
