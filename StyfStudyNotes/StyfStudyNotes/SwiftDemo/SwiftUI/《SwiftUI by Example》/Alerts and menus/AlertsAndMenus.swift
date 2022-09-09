//
//  AlertsAndMenus.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/17.
//

import SwiftUI
import StoreKit

struct AlertsAndMenus: View {
    var body: some View {
        ScrollView {
            //Picker显示Menu
            PickerMenu()
            //显示Menu
            ShowMenu()
            //推荐另一个APP
            RecommendApp()
            //长按显示ContextMenu
            ShowContextMenu()
            //显示ActionSheet
            ShowActionSheet()
            //从一个View显示多个弹窗
            MultipleAlertsInASingleView()
            //给弹窗增加按钮
            AddAlertButtons()
            //显示一个弹窗
            ShowAnAlert()
        }
    }
}
//-----------------------------

struct PickerMenu: View {
    @State private var selection = "Red"
    let colors = ["Red", "Green", "Blue", "Black", "Tartan"]
    
    var body: some View {
        TestWrap("Picker显示Menu") {
            VStack {
                Picker("Select a paint color", selection: $selection) {
                    ForEach(colors, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)

                Text("Selected color: \(selection)")
            }
        }
    }
}
//-----------------------------

struct ShowMenu: View {
    var body: some View {
        TestWrap("显示Menu") { //在macOS 上是下拉框的形式
//            Menu("Options") {
//                Button("Order Now", action: placeOrder)
//                Button("Adjust Order", action: adjustOrder)
//                Button("Cancel", action: cancelOrder)
//            }
            //菜单嵌套
//            Menu("Options") {
//                Button("Order Now", action: placeOrder)
//                Button("Adjust Order", action: adjustOrder)
//                Menu("Advanced") {
//                    Button("Rename", action: rename)
//                    Button("Delay", action: delay)
//                }
//                Button("Cancel", action: cancelOrder)
//            }
            //自定义Label
//            Menu {
//                Button("Order Now", action: placeOrder)
//                Button("Adjust Order", action: adjustOrder)
//            } label: {
//                Label("Options", systemImage: "paperplane")
//            }
            //iOS15才有的主操作
            Menu("Options") {
                //长按显示菜单
                Button("Order Now", action: placeOrder)
                Button("Adjust Order", action: adjustOrder)
                Button("Cancel", action: cancelOrder)
            } primaryAction: {
                justDoIt()//点击触发主操作
            }
        }
    }
    func placeOrder() { }
    func adjustOrder() { }
    func cancelOrder() { }
    func rename() { }
    func delay() { }
    
    func justDoIt() {
        print("Button was tapped")
    }
}
//-----------------------------

struct RecommendApp: View {
    @State private var showRecommended = false
    var body: some View {
        TestWrap("推荐另一个APP") {
            //需要StoreKit
            Button("Show Recommended App") {
                showRecommended.toggle()
            }
            .appStoreOverlay(isPresented: $showRecommended) {
                SKOverlay.AppConfiguration(appIdentifier: "1440611372", position: .bottom)
            }
        }
    }
}

//-----------------------------

struct ShowContextMenu: View {
    @State private var showingOptions = false
    @State private var selection = "None"
    var body: some View {
        TestWrap("显示ContextMenu") {
            //长按触发，或在macOS右键触发
            Text("Options")//您可以将这些菜单附加到任何SwiftUI视图，而不仅仅是文本视图。
                .contextMenu {
                    Button {
                        print("Change country setting")
                    } label: {
                        Label("Choose Country", systemImage: "globe")
                    }

                    Button {
                        print("Enable geolocation")
                    } label: {
                        Label("Detect Location", systemImage: "location.circle")
                    }
                }
        }
    }
}
//-----------------------------

struct ShowActionSheet: View {
    @State private var showingOptions = false
    @State private var selection = "None"
    var body: some View {
        TestWrap("显示ActionSheet") {
            VStack {
                Text(selection)

                Button("Confirm paint color") {
                    showingOptions = true
                }
//                .confirmationDialog("Select a color", isPresented: $showingOptions, titleVisibility: .visible) {
////                    Button("Red") {
////                        selection = "Red"
////                    }
////
////                    Button("Green") {
////                        selection = "Green"
////                    }
////
////                    Button("Blue") {
////                        selection = "Blue"
////                    }
//                    //直接用个ForEach
//                    ForEach(["Red", "Green", "Blue"], id: \.self) { color in
//                        Button(color) {
//                            selection = color
//                        }
//                    }
//                }
                
                //支持iOS14
                .actionSheet(isPresented: $showingOptions) {
                    ActionSheet(
                        title: Text("Select a color"),
                        buttons: [
                            .default(Text("Red")) {
                                selection = "Red"
                            },

                            .default(Text("Green")) {
                                selection = "Green"
                            },

                            .default(Text("Blue")) {
                                selection = "Blue"
                            },
                        ]
                    )
                }
            }
        }
    }
}

//-----------------------------

struct MultipleAlertsInASingleView: View {
    @State private var showingAlert1 = false
    @State private var showingAlert2 = false
    var body: some View {
        TestWrap("从一个View显示多个弹窗") {
            //要解决此问题，需要确保每个视图最多附加一个alert（）修饰符
            //事实上，你可能会发现直接将它们连接到显示它们的东西（例如按钮）最适合你。
            //如果您尝试将两个alert（）修饰符都移动到VStack，您会发现只有一个有效
            VStack {
                Button("Show 1") {
                    showingAlert1 = true
                }
                .alert(isPresented: $showingAlert1) {
                    Alert(title: Text("One"), message: nil, dismissButton: .cancel())
                }

                Button("Show 2") {
                    showingAlert2 = true
                }
                .alert(isPresented: $showingAlert2) {
                    Alert(title: Text("Two"), message: nil, dismissButton: .cancel())
                }
            }
        }
    }
}
//-----------------------------

struct AddAlertButtons: View {
    @State private var showingAlert = false
    var body: some View {
        TestWrap("给弹窗增加按钮") {
            Button("Show Alert") {
                showingAlert = true
            }
            .alert(isPresented:$showingAlert) {
                Alert(//Alert不能超过两个按钮，超过就用sheet替代
                    title: Text("Are you sure you want to delete this?"),
                    message: Text("There is no undo"),
                    primaryButton: .destructive(Text("Delete")) {
                        print("Deleting...")
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

//-----------------------------

struct ShowAnAlert: View {
    
    var body: some View {
        TestWrap("显示一个弹窗") {
            AlertDemo1()
//            AlertDemo2()
        }
    }
}

struct AlertDemo2: View {
    //-----------弹窗的第二种方式
    //绑定到一个Identifiable的值上，值发生变化就弹。
    //优点：
    //1.可以绑定到任何对象，比如错误信息
    //2.SwiftUI会在可选项有值时自动将其展开，因此您可以确保它在您想要显示警报时存在，无需自己检查和展开该值。
    @State private var selectedShow: TVShow?
    var body: some View {
        VStack(spacing: 20) {
            Text("What is your favorite TV show?")
                .font(.headline)

            Button("Select Ted Lasso") {
                selectedShow = TVShow(name: "Ted Lasso")
            }

            Button("Select Bridgerton") {
                selectedShow = TVShow(name: "Bridgerton")
            }
        }
        .alert(item: $selectedShow) { show in
            Alert(title: Text(show.name), message: Text("Great choice!"), dismissButton: .cancel())
            
//            Alert(
//                title: Text("Important message"),
//                message: Text("Wear sunscreen"),
//                dismissButton: .default(Text("Got it!"))
//            )
        }
    }
}

struct TVShow: Identifiable {
    var id: String { name }
    let name: String
}

struct AlertDemo1: View {
    @State private var showingAlert = false
    var body: some View {
        //-----------弹窗的第一种方式
        Button("Show Alert") {
            showingAlert = true
        }
            .alert("Important message", isPresented: $showingAlert) {
//                Button("OK", role: .cancel) { }
//
//            多个按钮
                Button("First") { }
                Button("Second") { }
                Button("Third",role: .destructive) { }//指定角色
            }
        
//        .alert(isPresented: $showingAlert) {
//            //支持iOS13
//            Alert(
//                title: Text("Important message"),
//                message: Text("Wear sunscreen"),
//                dismissButton: .default(Text("Got it!"))
//            )
//        }
    }
}

//-----------------------------

struct AlertsAndMenus_Previews: PreviewProvider {
    static var previews: some View {
        AlertsAndMenus()
    }
}
