//
//  UsingSafeArea.swift
//  
//
//  Created by styf on 2022/8/30.
//  掌握 SwiftUI 的 Safe Area  https://www.fatbobman.com/posts/safeArea/

import SwiftUI
import Combine

struct UsingSafeArea: View {
    var body: some View {
//        GetSafeArea()
//        FullScreenView()
//        IgnoresSafeAreaTest()
//        AddSafeAreaDemo()
//        AddSafeAreaDemo1()
//        AddSafeAreaDemo2()
//        AddSafeAreaDemo3()
        ChatBarDemo()
    }
}
// 实战：用 safeAreaInset 实现类似微信的对话页面
struct ChatBarDemo: View {
    struct Message: Identifiable, Hashable {
        let id = UUID()
        let text: String
    }
    
    @State var messages: [Message] = (0...60).map { Message(text: "message:\($0)") }
    @State var text = ""
    @FocusState var focused: Bool
    @State var bottomTrigger = false
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List {
                    ForEach(messages) { message in
                        Text(message.text)
                            .id(message.id)
                    }
                }
                .listStyle(.inset)
                .safeAreaInset(edge: .bottom) {
                    ZStack(alignment: .top) {
                        Color.clear
                        Rectangle().fill(.secondary).opacity(0.3).frame(height: 0.6) // 上部线条
                        HStack(alignment: .firstTextBaseline) {
                            // 输入框
                            TextField("输入", text: $text)
                                .focused($focused)
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                                .onSubmit {
                                    addMessage()
                                    scrollToBottom()
                                }
                                .onChange(of: focused) { value in
                                    if value {
                                        scrollToBottom()
                                    }
                                }
                            // 回复按钮
                            Button("回复") {
                                addMessage()
                                scrollToBottom()
                                focused = false
                            }
                            .buttonStyle(.bordered)
                            .controlSize(.small)
                            .tint(.green)
                        }
                        .padding(.horizontal, 30)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 53)
                    .background(.regularMaterial)
                }
                .onChange(of: bottomTrigger) { _ in
                    withAnimation(.spring()) {
                        if let last = messages.last {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
                .onAppear {
                    if let last = messages.last {
                        proxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }
            .navigationBarTitle("SafeArea Chat Demo")
        }
    }

    func scrollToBottom() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            bottomTrigger.toggle()
        }
    }

    func addMessage() {
        if !text.isEmpty {
            withAnimation {
                messages.append(Message(text: text))
            }
            text = ""
        }
    }
}



/// 出现键盘，“底部状态条”会被顶上去
struct AddSafeAreaDemo4: View {
    var body: some View {
        ScrollView {
            ForEach(0..<100) { i in
                TextField("input text for id:\(i)",text:.constant(""))
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Text("底部状态条")
                .font(.title3)
                .foregroundColor(.indigo)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                .padding()
                .background(.green.opacity(0.6))
                .ignoresSafeArea(.all)
        }
    }
}

// 如果想让底部状态条固定，同时又保持 TextField 的自动避让能力，需要通过监控键盘的状态，做一点额外的操作。
final class KeyboardMonitor: ObservableObject {
    @Published var willShow: Bool = false
    private var cancellables = Set<AnyCancellable>()
    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification, object: nil)
            .sink { _ in
                self.willShow = true
            }
            .store(in: &cancellables)
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification, object: nil)
            .sink { _ in
                self.willShow = false
            }
            .store(in: &cancellables)
    }
}

struct AddSafeAreaDemo3: View {
    @StateObject var monitor = KeyboardMonitor()
    var body: some View {
        ScrollView {
            ForEach(0..<100) { i in
                TextField("input text for id:\(i)", text: .constant(""))
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if !monitor.willShow { // 在键盘即将弹出时隐藏
                Text("底部状态条")
                    .font(.title3)
                    .foregroundColor(.indigo)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                    .padding()
                    .background(.green.opacity(0.6))
                    .ignoresSafeArea(.all)
            }
        }
    }
}

// safeAreaInset 可以叠加，这样我们可以在多个边对安全区域进行调整
struct AddSafeAreaDemo2: View {
    var body: some View {
        ZStack {
            Color.yellow.border(.red, width: 10)
        }
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
            Rectangle().fill(.blue)
                .frame(height: 100)
        }
        .safeAreaInset(edge: .trailing, alignment: .center, spacing: 0) {
            Rectangle().fill(.blue)
                .frame(width: 50)
        }
    }
}
// 利用 safeAreaInset，可以让 List 在自定义的 TabBar 中表现同系统 TabBar 一致的行为
struct AddSafeAreaDemo1: View {
    var body: some View {
        NavigationView {
            List(0..<100) { i in
                Text("id:\(i)")
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                Text("底部状态条")
                    .font(.title3)
                    .foregroundColor(.indigo)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                    .padding()
                    .background(.green.opacity(0.6))

            }
        }
    }
}

/// 使用 safeAreaInset 扩展安全区域
struct AddSafeAreaDemo: View {
    var body: some View {
        ZStack {
            Color.yellow.border(.red, width: 10)
        }
        .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) { //通过 safeAreaInset，我们可以缩小视图的安全区域，以确保所有内容都可以按预期显示。
            Rectangle().fill(.blue)
                .frame(height: 100) //将 ZStack 内部的安全区从底边缩小了 100
        }
        .ignoresSafeArea()
    }
}

/// SafeAreaRegions
struct IgnoresSafeAreaTest: View {
//    SafeAreaRegions 定义了三种安全区域划分：
//
//    container
//    由设备和用户界面内的容器所定义的安全区域，包括诸如顶部和底部栏等元素。
//
//    keyboard
//    与显示在视图内容上的任何软键盘的当前范围相匹配的安全区域。
//
//    all（默认）
    var body: some View {
        ZStack {
            // 渐变背景
            Rectangle()
                .fill(.linearGradient(.init(colors: [.red, .blue, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea(.all) //✅ 只让背景忽略安全区域
            VStack {
                // Logo
                Circle().fill(.regularMaterial).frame(width: 100, height: 100).padding(.vertical, 100)
                // 文本输入
                TextField("name", text: .constant(""))
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
        }
        //.ignoresSafeArea() //❌ 失去了键盘避让功能
        //.ignoresSafeArea(.container) //❌ 北京还是变化了
    }
}

/// 使用 ignoresSafeArea 忽略安全区域
struct FullScreenView: View {
    var body: some View {
        ZStack {
            Color.blue
            Text("Hello world").foregroundColor(.white)
        }
        .ignoresSafeArea() // 全方向忽略安全区域
        
        // 只扩展到底部
        //.ignoresSafeArea(edges: .bottom)

        // 扩展到顶部和底部
        //.ignoresSafeArea(edges: [.bottom, .trailing])

        // 横向扩展
        //.ignoresSafeArea(edges:.horizontal)
    }
}

/// 获取 safeAreaInsets
struct GetSafeArea: View {
    @State var safeAreaInsets: EdgeInsets = .init()
    var body: some View {
        NavigationView {
            VStack {
                Color.blue
            }
        }
        .getSafeAreaInsets($safeAreaInsets)
        .printSafeAreaInsets(id: "打印")
    }
}

struct UsingSafeArea_Previews: PreviewProvider {
    static var previews: some View {
        UsingSafeArea()
    }
}
