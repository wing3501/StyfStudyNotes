//
//  UsingTaskModifier.swift
//
//
//  Created by styf on 2022/8/29.
//  掌握 SwiftUI 的 task 修饰器  https://www.fatbobman.com/posts/mastering_SwiftUI_task_modifier/

import SwiftUI

struct UsingTaskModifier: View {
    var body: some View {
//        TimerView()
//        TimerView1()
//        TimerView2()
//        TimerView3()
        NotificationHandlerDemo()
    }
}

//------------------------------------------------------------------------------------
//我们会用 onReceive 修饰器在视图中响应 Notification Center 的消息。作为一个事件源类型的 Source of Truth，每当接收到一个新的消息时，它都会导致 SwiftUI 对视图的 body 重新求值。
//你想有选择性的处理消息，可以考虑用 task 来代替 onReceive

// ✅ 使用 task 替换 onReceive 可以获得两个好处：
//减少视图不必要的刷新（ 避免重复计算 ）
//在后台线程响应消息，减少主线程的负荷
struct NotificationHandlerDemo: View {
    @State var message = ""
    var body: some View {
        Text(message)
            .task(notificationHandler)
        
        Button("click") {
            NotificationCenter.default.post(name: .messageSender, object: "123456789010")
        }
    }

    @Sendable
    func notificationHandler() async {
        for await notification in NotificationCenter.default.notifications(named: .messageSender) where !Task.isCancelled {
            // 判断是否满足特定条件
            print("===\(message)")
            if let message = notification.object as? String, condition(message) {
                self.message = message
            }
        }
    }

    func condition(_ message: String) -> Bool { message.count > 10 }
}

extension Notification.Name {
    static let messageSender = Notification.Name("messageSender")
}


//------------------------------------------------------------------------------------
// 我们可以通过将异步方法移到视图类型之外来解决这个问题。
//SwiftUI 对 @State 做了特别的处理，我们可以在任意线程中对其进行安全的修改。但对于其他符合 DynamicProperty 协议的 Source of Truth （ 将 wrappedValue 和 projectedValue 标注为 @MainActor ），在修改前必须切换到主线程上
struct TimerView3: View {
    @StateObject var object = TestObject1()

    var body: some View {
        VStack {
            Button(object.show ? "Hide Timer" : "Show Timer") {
                object.show.toggle()
            }
            if object.show {
                Text(object.date, format: .dateTime.hour().minute().second())
                    .task(object.timer)
            }
        }
    }
}

class TestObject1: ObservableObject {
    @Published var date: Date = .now
    @Published var show = true

    @Sendable
    func timer() async {
        let taskID = UUID()
        print(Thread.current)
        defer {
            print("Task \(taskID) has been cancelled.")
            // 做一些数据的善后工作
        }
        while !Task.isCancelled {
            try? await Task.sleep(nanoseconds: 1000000000)
            let now = Date.now
            await MainActor.run { // 需要切换回主线程
                date = now
            }
            print("Task ID \(taskID) :\(now.formatted(date: .numeric, time: .complete))")
        }
    }
}
//------------------------------------------------------------------------------------

struct TimerView2: View {
    class TestObject: ObservableObject { }
    
    @State var date = Date.now
    @State var show = true
    // 在 StateObject 的定义中，wrappedValue 和 projectedValue 被标注了 @MainActor
    @StateObject var testObject = TestObject() // ⚠️导致 SwiftUI 会将视图类型的实例默认推断为运行于主线程
    var body: some View {
        VStack {
            Button(show ? "Hide Timer" : "Show Timer") {
                show.toggle()
            }
            if show {
                Text(date, format: .dateTime.hour().minute().second())
                    .task(timer)
            }
        }
    }

    // 在 body 外面定义异步函数
    @Sendable
    func timer() async {
       print(Thread.current) // ⚠️ 仍然会运行于主线程
       
    }
}

//------------------------------------------------------------------------------------
struct TimerView1: View { //运行在子线程上
    @State var date = Date.now
    @State var show = true
    var body: some View {
        VStack {
            Button(show ? "Hide Timer" : "Show Timer") {
                show.toggle()
            }
            if show {
                Text(date, format: .dateTime.hour().minute().second())
//                    .task(timer) //✅ 子线程
                    .task{
//                        print(Thread.current)
                        await timer() } //❌ 仍会运行于主线程中   ❓测试下来，还是在子线程
            }
        }
    }

    // 在 body 外面定义异步函数
    @Sendable
    func timer() async {
        let taskID = UUID()
        print(Thread.current)
        defer {
            print("Task \(taskID) has been cancelled.")
            // 做一些数据的善后工作
        }
        while !Task.isCancelled {
            try? await Task.sleep(nanoseconds: 1000000000)
            let now = Date.now
            date = now
            print("Task ID \(taskID) :\(now.formatted(date: .numeric, time: .complete))")
        }
    }
}
//------------------------------------------------------------------------------------
struct TimerView:View{ //运行在主线程上
    @State var date = Date.now
    @State var show = true
    var body: some View{
        VStack {
            Button(show ? "Hide Timer" : "Show Timer"){
                show.toggle()
            }
            if show {
                Text(date,format: .dateTime.hour().minute().second())
                    .task {
                        let taskID = UUID()  // 任务 ID
                        while !Task.isCancelled { // 持续运行
                            try? await Task.sleep(nanoseconds: 1_000_000_000) // 间隔一秒
                            let now = Date.now // 每隔一秒更新一次时间
                            date = now
//                           ⚠️ 由于 View 协议限定了 body 属性必须运行于主线程中（ 使用了 @MainActor 进行标注 ），因此，如果我们直接在 body 中为 task 修饰器添加闭包代码，那么该闭包只能运行于主线程中（ 闭包继承了 body 的 actor 上下文 ）。
//                            print(Thread.current)
                            print("Task ID \(taskID) :\(now.formatted(date: .numeric, time: .complete))")
                        }
                    }
            }
        }
    }
}
//------------------------------------------------------------------------------------
// 提供了类似 onChange + onAppear 的联合能力
struct TaskDemo2: View {
    @State var status: Status = .loading
    @State var reloadTrigger = false
    let url = URL(string: "https://source.unsplash.com/400x300")! // 获取随机图片的地址
    var body: some View {
        VStack {
            Group {
                switch status {
                case .loading:
                    Rectangle()
                        .fill(.secondary)
                        .overlay(Text("Loading"))
                case .image(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .error:
                    Rectangle()
                        .fill(.secondary)
                        .overlay(Text("Failed to load image"))
                }
            }
            .padding()
            .frame(width: 400, height: 300)

            Button(status.loading ? "Loading" : "Reload") {
                reloadTrigger.toggle()  // 读取新图
            }
            .disabled(status.loading)
            .buttonStyle(.bordered)
        }
        .animation(.easeInOut, value: status)
        .task(id: reloadTrigger) { // ✅ 在 VStack “出现之前” 以及当 reloadTrigger 发生变化时，执行如下内容。
            do {
                status = .loading
                var bytes = [UInt8]()
                for try await byte in url.resourceBytes {
                    bytes.append(byte)
                }
                if let uiImage = UIImage(data: Data(bytes)) {
                    let image = Image(uiImage: uiImage)
                    status = .image(image)
                } else {
                    status = .error
                }
            } catch {
                status = .error
            }
        }
    }

    enum Status: Equatable {
        case loading
        case image(Image)
        case error

        var loading: Bool {
            switch self {
            case .loading:
                return true
            default:
                return false
            }
        }
    }
}
//------------------------------------------------------------------------------------
// 版本一的作用和调用时机与 onAppear 十分类似
struct TaskDemo1:View{
    @State var message:String?
    let url = URL(string:"https://news.baidu.com/")!
    var body: some View{
        VStack {
            if let message = message {
                Text(message)
            } else {
                ProgressView()
            }
        }
        .task(priority: .background) { // ✅ 我们可以通过 priority 参数来设定创建异步任务时要使用的任务优先级
            // do something
        }
        .task {  // ✅ VStack “出现之前” 执行闭包中的代码
            do {
                var lines = 0
                for try await _ in url.lines { // 读取指定 url 的内容
                    lines += 1
                }
                try? await Task.sleep(nanoseconds: 1_000_000_000) // 模拟更复杂的任务
                message = "Received \(lines) lines"
            } catch {
                message = "Failed to load data"
            }
        }
    }
}
