//
//  RespondingToEvents.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/13.
//

import SwiftUI

struct RespondingToEvents: View {
    
    var body: some View {
        ScrollView {
            //.task的使用
            RunAsynchronousTask()
            //给键盘添加toolBar
            AddToolbarToKeyboard()
            //观察横竖屏切换
            DetectDeviceRotation()
            //在SwiftUI中使用AppDelegate
            
            //启动时初始化业务的位置
            
            //控制APP在启动时显示哪个页面
            
            //View的生命周期方法
            ViewLifecycle()
            //观察APP前后台状态
            DetectScenePhase()
        }
    }
}
//--------------------------------------
//task（）修饰符是onAppear（）的一个更强大的版本，允许我们在显示视图时立即开始异步工作。更妙的是，如果视图尚未完成，任务将在视图被销毁时自动取消。
//由于任务是异步执行的，因此这是获取一些初始网络数据以供查看的好地方
struct RunAsynchronousTask: View {
    @State private var messages = [Message]()
    var body: some View {
        TestWrap(".task的使用") {
            List(messages) { message in
                VStack(alignment: .leading) {
                    Text(message.from)
                        .font(.headline)
                    Text(message.text)
                }
            }
            .task {
                
//                提示：默认情况下，使用task（）修饰符创建的Swift任务将以最高的可用优先级运行，但如果您知道工作不那么重要，可以将自定义优先级传递给修饰符。
                do {
                    let url = URL(string: "https://www.hackingwithswift.com/samples/messages.json")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    messages = try JSONDecoder().decode([Message].self, from: data)
                } catch {
                    messages = []
                }
            }
        }
    }
}

struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let text: String
}

//--------------------------------------
struct AddToolbarToKeyboard: View {
    @State private var name = "Taylor"
    @FocusState var isInputActive: Bool
    
    var body: some View {
        TestWrap("给键盘添加toolBar") {
            TextField("Enter your name", text: $name)
                .textFieldStyle(.roundedBorder)
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()

                        Button("Done") {
                            isInputActive = false
                        }
                    }
                }

        }
    }
}

//--------------------------------------

struct DetectDeviceRotation: View {
//    提示：当你的应用程序连接到Xcode的调试器时，这可能不起作用——试着把你的应用程序推到一个真正的设备上，然后手动运行，而不是通过Xcode。
    @State private var orientation = UIDeviceOrientation.unknown
    var body: some View {
        TestWrap("观察横竖屏切换") {
            Group {
                if orientation.isPortrait {
                    Text("Portrait")
                } else if orientation.isLandscape {
                    Text("Landscape")
                } else if orientation.isFlat {
                    Text("Flat")
                } else {
                    Text("Unknown")
                }
            }
            .onRotate { newOrientation in
                orientation = newOrientation
            }
        }
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
//        modifiers不能与onReceive（）一起使用，除非首先添加onAppear（）
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

//--------------------------------------
//在SwiftUI中使用AppDelegate
// 1
//class AppDelegate: NSObject, UIApplicationDelegate {
//    //SwiftUI负责创建该委托并管理其生命周期，因此您可以继续向该类添加任何其他应用程序委托功能，以便调用它。

//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        print("Your code here")
//        return true
//    }
//}

//@main
//struct NewIn14App: App {
//    //2
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}


//--------------------------------------
//启动时初始化业务的位置
//@main
//struct ExampleApp: App {
//    // register initial UserDefaults values every launch
//    init() {
//        UserDefaults.standard.register(defaults: [
//            "name": "Taylor Swift",
//            "highScore": 10
//        ])
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
// AppStorage是对UserDefaults的属性包装
//struct ContentView: View {
//    @AppStorage("name") var name = "Anonymous"
//
//    var body: some View {
//        Text("Your name is \(name).")
//    }
//}

//--------------------------------------
//控制APP在启动时显示哪个页面
//struct SwiftUITestApp: App {
//    var body: some Scene {
//        WindowGroup {
//            TabView {
//                HomeView()
//                ContactsView()
//                LocationView()
//                AccountView()
//            }
//        }
//    }
//}

struct ViewLifecycle: View {
    var body: some View {
        TestWrap("View的生命周期方法") {
            VStack {
                Text("Hello World")
            }
            .onAppear {//viewDidAppear()
                print("ContentView appeared!")
            }
            .onDisappear {//viewDidDisappear()
                print("ContentView disappeared!")
            }
        }
    }
}

struct DetectScenePhase: View {
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        TestWrap("观察APP前后台状态") {
            Text("Example Text")
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .inactive {
                        print("Inactive")//例如，如果你在运行应用程序时进入多任务模式
                    } else if newPhase == .active {
                        print("Active")
                    } else if newPhase == .background {
                        print("Background")
                    }
                }
        }
    }
}

struct RespondingToEvents_Previews: PreviewProvider {
    static var previews: some View {
        RespondingToEvents()
    }
}
