//
//  AsyncSwiftViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/20.
//

import UIKit
import Photos
import Combine

protocol WorkDelegate {
    func workDidDone(values: [String])
    func workDidFailed(error: Error)
}

extension DispatchQueue {
    static func mainAsyncOrExecute(_ work: @escaping () -> Void) {
        if Thread.current.isMainThread {
            work()
        } else {
            main.async {
                work()
            }
        }
    }
}


//将任意 Publisher 转换为异步序 列
extension Publisher {
    var asAsyncStream: AsyncThrowingStream<Output, Error> {
        AsyncThrowingStream(Output.self) { continuation in
            let cancellable = sink { completion in
                switch completion {
                case .finished:
                    continuation.finish()
                case .failure(let error):
                    continuation.finish(throwing: error)
                }
                
            } receiveValue: { output in
                continuation.yield(output)
            }
            
            continuation.onTermination = { @Sendable _ in
                cancellable.cancel()
            }
        }
    }
}

class Sample {
    func bar() async {
        let button = await UIButton()
        // 注意，`Sample` 不在 `@MainActor` 中
        // 缺少 await 的话，将报错
        await button.setTitle("Click", for: .normal)
//        await ViewController().view.addSubview(button)
    }
}


class AsyncSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        
//        Task {
//            await TaskGroupSample().start2()
//        }
//
//        let url = URL(string: "https://example.com")!
//        Task {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            self.updateUI(data)
//
////            所以，在 UIViewController 的环境中，如果我们希望开始某个异步操作，然后在主线 程中调用自身成员的话，
////            Task.init 一般会是更好的选择:它能保证 await 后，后续代 码能通过 actor 跳跃回到 MainActor 中执行。
//        }
//
//        Task.detached {
//            //如果我们将这里的 Task.init 换为 Task.detached 的话，闭包的运行将无视原有隔离域。
////            此时，想要调用 updateUI，我们需要添加 await 以确保 actor 跳跃能够发生
//            let (data, _) = try await URLSession.shared.data(from: url)
////            self.updateUI(data)
//            await self.updateUI(data)
//        }
        
//        Task {
//            var tasks: [Task<Int, Error>] = []
//            for i in 1...3 {
//                tasks.append(Task{
//                    await doMyWork(i)
//                })
//            }
//
//            for task in tasks {
//                do {
//                    let value = try await task.value
//                    print("结果：\(value)")
//                } catch {
//                    print(error)
//                }
//            }
//        }
        
//        Task {
//            async let v1 = doMyWork(1)
//            async let v2 = doMyWork(2)
//            async let v3 = doMyWork(3)
//
//            print("结果：\(await v1)")
//            print("结果：\(await v2)")
//            print("结果：\(await v3)")
//
//        }
        
//        Task.detached { [self] in
//            async let v1 = doMyWork(1)
//            async let v2 = doMyWork(2)
//            async let v3 = doMyWork(3)
//
//            print("结果：\(await v1)")
//            print("结果：\(await v2)")
//            print("结果：\(await v3)")
//        }
        
//        Task.detached { [self] in
//            var sum = 0
//            async let v1 = doMyWork1()
//            sum += await v1
//            async let v2 = doMyWork2()
//            sum += await v2
//            async let v3 = doMyWork3()
//            sum += await v3
//            print("结果：\(sum)")
////            print("结果：\(await v1)")
////            print("结果：\(await v2)")
////            print("结果：\(await v3)")
//        }
        
        Task.detached { [self] in
            
            async let v1 = doMyWork1()
            async let v2 = doMyWork2()
            async let v3 = doMyWork3()
            
            print("结果：\(await v1)")
            print("结果：\(await v2)")
            print("结果：\(await v3)")
        }
        
//        Task.detached {
//            await withTaskGroup(of: Int.self) { group in
//                for i in 0..<3 {
//                    group.addTask { [self] in
////                        addTaskAPI把新的任务添加到当前任务中。被添加的任务会在调度器获取到可用资源 后立即开始执行
//                        await doMyWork(i)
//                    }
//                }
//                print("Task added")
//
//                for await result in group {
//                    print("Get result: \(result)")
//                }
//                print("Task ended")
//            }
//        }
    }
    
    func doMyWork(_ i: Int) async -> Int {
        NSLog("work:\(i)-------begin----\(Thread.current)")
//        try? await Task.sleep(nanoseconds: 2_000_000_000)
        Thread.sleep(forTimeInterval: 2)
        NSLog("work:\(i)-------end----\(Thread.current)")
        return i
    }
    
    func doMyWork1() async -> Int {
        NSLog("-------begin----\(Thread.current)")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
//        Thread.sleep(forTimeInterval: 2)
        NSLog("-------end----\(Thread.current)")
        return 1
    }
    
    func doMyWork2() async -> Int {
        NSLog("-------begin----\(Thread.current)")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
//        Thread.sleep(forTimeInterval: 2)
        NSLog("-------end----\(Thread.current)")
        return 2
    }
    
    func doMyWork3() async -> Int {
        NSLog("-------begin----\(Thread.current)")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
//        Thread.sleep(forTimeInterval: 2)
        NSLog("-------end----\(Thread.current)")
        return 3
    }
    
    private func updateUI(_ data: Data?) {
        
    }
    //-----------------------------------
    //如何处理耗时操作
//    现在，在遇到这种情况时，我们的常见做法是使用 withUnsafeContinuation 或 withCheckedContinuation 来把它们封装起来
//    。不过需要特别注意，这两个方法的闭包依然是运行在串行调度队列中的。所 以，为了避免阻塞，一般我们还是会选择使用 GCD 直接进行调度:
//    await withUnsafeContinuation { continuation in
//        DispatchQueue.global().async {
//            let result = someHeavyMethod()
//            continuation.resume(returning: result)
//        }
//    }
    //-----------------------------------
//    Sendable 协议也表达 了类型的一种能力，那就是该类型可以安全地在不同并发域之间传递。
//    Sendable 这样的标志协 议具有的是语义上的属性，它完全是一个编译期间的辅助标记，只会由编译器使用，不会在运 行期间产生任何影响。
    
//    Swift 标准库中的大部分基本类型，都是满足 Sendable 协议的:
//    它们构成了其他标准库中的 “容器” 类型的基石。只要容器内的元素满足 Sendable，那么容器 本身也满足 Sendable。这类容器包括可选值、数组、字典等:
    
//    要让 class 类型满足 Sendable，条件要严苛得多:
//    → 这个 class 必须是 final 的，不允许继承，否则任何它的子类都有可能添加破坏数据安 全的成员。
//    → 该 class 类型的成员必须都是 Sendable 的。
//    → 所有的成员都必须使用 let 声明为不变量。
    
//    因此所有的 actor 类型都可以随意地在并发域之间传递，它们都满足 Sendable
    
//    在跨越并发域时，在函数体内的这些被引用的值可能会发生变化。想要保 证数据安全的话，我们必须规定函数闭包所持有的值都满足 Sendable 且它们都为不变量。
//    函数类型本身并不能满足任何协议。为了表示某个函数参数必须满足 Sendable，我们使用 @Sendable 对这个函数进行标注。
//    func bar(value: Int, block: @Sendable () -> Void) { block() }
//在使用这些函数时，编译器会对传入的函数进行检查:
//→ 被函数体持有的变量，必须都是 Sendable 的;
//→ 所有被持有的值，都必须是使用 let 声明的不变量。

//    class MyClass: @unchecked Sendable {
//    
//    }
    //-----------------------------------
    //警惕actor的可重入性，在 actor 方法中看到 await 关键字时，我们就需要提高警惕了。
    //解决办法
    //1。针对值类型，可以复制一份
//    func generateReport() async -> Report? {
//        if !isPopular {
//            let count = self.visitorCount//复制
//            let reason = await analyze(room: self)
//            return Report(reason: reason, visitorCount: count)
//        }
//        return nil
//    }
    //2.再次判断
//    func generateReport() async -> Report? {
//        if !isPopular {
//            let reason = await analyze(room: self)
//            return isPopular ? nil : Report(reason: reason, visitorCount: visitorCount)//再次判断
//        }
//        return nil
//    }

    //-----------------------------------
//    自定义全局 actor
    @globalActor actor MyActor {
        static let shared = MyActor()
        //我们通常会选择不在 @globalActor 里持有变量和实例方法，并且为它声明一个 私有的初始化方法。这样，我们就能将这个 actor 类型作为纯粹的标记来使用，减少一些迷惑
//        var value: Int = 0
        private init() { }
    }
    
    @MyActor var foo = "some value"
    //bar 方法被 @MyActor 标记，因此它运行在 MyActor.shared 的隔离域中
    @MyActor func bar(actor: MyActor) async {
        //作 为参数的 actor，我们无法判断它是否和 MyActor.shared 属于同一隔离域，因此必须使用 await
//        print(await actor.value)
        //即便访问的就是 MyActor.shared 上的属性 value，编译器现在也还无法指出它和 @MyActor 其实是在相同的隔离域中，所以这里也需要明确的 await 才能访问
//        print(await MyActor.shared .value)
    }
    
    //-----------------------------------
//    @MainActor
    @MainActor class C1 {
        //整个类型都被标记为 @MainActor: 这意味着其中所有的方法和属性都会被限定在 MainActor 规定的隔离域中。
        func method() {}
    }
    class C2 {
        @MainActor var value: Int?//只有 部分方法被标记为 @MainActor。
        @MainActor func method() {}
        func nonisolatedMethod() {}
    }
    @MainActor var globalValue: String = ""//对于定义在全局范围的变量或者函数，也可以用 @MainActor 限定它的作用返回
    
    //使用
//    1 和其他一般的 actor 一样，可以通过 await 来完成这个 actor 跳跃;
//    2 也可以通过将 Task 闭包标记为 @MainActor 来将整个闭包 “切换” 到与 C1 同样的隔离 域，这样就可以使用同步的方式访问 C1 的成员了
//    class Sample {
//        func foo() {
//            Task { await C1().method() }
//            Task { @MainActor in C1().method() }
//            Task { @MainActor in globalValue = "Hello" }
//        }
//        func bar() async {
//            await C1().method()
//        }
    
//    func foo() {
//        其实就是调用 DispatchQueue.main 的 async，在需 要的时候把操作派发到主队列中。
//        事实上，这样的派发所接受的闭包，在 Swift 并发中也是被 隐式标记为 @MainActor 的，
//        所以下面的代码，虽然看起来 foo 在 MainActor 的隔离域外，但 在闭包中对隔离域内的成员可以同步访问
//        DispatchQueue.main.async {
//          C1().method()
//          globalValue = "World"
//        }
//    }
//    }
    
    //-----------------------------------
//    对于 actor 外的声明，使用 isolated 关键字让它处于某个隔离域中
    
//    修饰函数的某个 actor 类型的参数，这会明确 表示函数体应该运行在该 actor 的隔离域中
    func reportRoom(room: isolated Room) {
        print("Room: \(room.visitorCount)")
    }
    //-----------------------------------
//    【WWDC22 110350】Swift 并发的可视化和优化   https://xiaozhuanlan.com/topic/0186237549
//    一个使用actor和nonisolated进行优化的例子
    // 一个用于表示文件压缩的类
    
    struct FileStatus {
        var url: URL
        var progress: Double
        var uncompressedSize: Int
        var compressedSize: Int
    }
    
    @MainActor
    class CompressionState: ObservableObject {
      // UI 监听的属性
      @Published var files: [FileStatus] = []
        var compressor: ParallelCompressor!

        init() {
          self.compressor = ParallelCompressor(status: self)
        }

      // 更新文件压缩进度，作用是更新 UI
      func update(url: URL, progress: Double) {
        if let loc = files.firstIndex(where: {$0.url == url}) {
          files[loc].progress = progress
        }
      }

      // 更新文件还未压缩完的尺寸，作用是更新 UI
      func update(url: URL, uncompressedSize: Int) {
        if let loc = files.firstIndex(where: {$0.url == url}) {
          files[loc].uncompressedSize = uncompressedSize
        }
      }

      // 更新文件已经压缩完的尺寸，作用是更新 UI
      func update(url: URL, compressedSize: Int) {
        if let loc = files.firstIndex(where: {$0.url == url}) {
          files[loc].compressedSize = compressedSize
        }
      }

      // 压缩所有文件
      func compressAllFiles() {
        for file in files {
          // 为每个文件开启了新任务，实行并行压缩
//          Task {
//            let compressedData = compressFile(url: file.url)
//            await save(compressedData, to: file.url)
//          }
//          ✅ 最后我们在创建异步任务的时候，把 Task {} 换成 Task.detached{}，这样做可以让创建出来的任务不继承创建它的那个 Actor 的上下文。
            // 改成 detached
//               Task.detached {
//                 let compressedData = await self.compressor.compressFile(url: file.url)
//                 await save(compressedData, to: file.url)
//               }
        }
      }
        // ❎ compressFile在MainActor中，所以会阻塞主线程，需要迁移出去
//      // 压缩文件并在回调更新 UI 相关属性和记录日志
//      func compressFile(url: URL) -> Data {
//        log(update: "Starting for \(url)")
//        // 可以认为是一个耗时操作
//        let compressedData = CompressionUtils.compressDataInFile(at: url) { uncompressedSize in
//          update(url: url, uncompressedSize: uncompressedSize)
//        } progressNotification: { progress in
//          update(url: url, progress: progress)
//          log(update: "Progress for \(url): \(progress)")
//        } finalNotificaton: { compressedSize in
//          update(url: url, compressedSize: compressedSize)
//        }
//        log(update: "Ending for \(url)")
//        return compressedData
//      }
        // ❎ 虽然logs需要串行访问，但不必在主线程，需要迁移出去
//      func log(update: String) {
//        logs.append(update)
//      }
    }
    
    // 重构后的第二个actor，用于平行压缩多个文件
    actor ParallelCompressor {
      // 在actor中 logs属性串行访问，线程安全
      var logs: [String] = []
      unowned let status: CompressionState

      init(status: CompressionState) {
        self.status = status
      }

//      // 压缩文件逻辑
//      func compressFile(url: URL) -> Data {
//        log(update: "Starting for \(url)")
//        let compressedData = CompressionUtils.compressDataInFile(at: url) { uncompressedSize in
//          Task { @MainActor in
//            status.update(url: url, uncompressedSize: uncompressedSize)
//          }
//        } progressNotification: { progress in
//          Task { @MainActor in
//            status.update(url: url, progress: progress)
//            await log(update: "Progress for \(url): \(progress)")
//          }
//        } finalNotificaton: { compressedSize in
//          Task { @MainActor in
//            status.update(url: url, compressedSize: compressedSize)
//          }
//        }
//        log(update: "Ending for \(url)")
//        return compressedData
//      }
        
        // ✅ compressFile 这个方法其余的部分其实是可以并发执行的，并不一定要在 Actor 中执行。
        // 通过 nonisolated 等方式让允许并发执行的代码块并发执行，让必须访问 Actor 的代码块串行执行，在保证线程安全的同时又能够提高 CPU 的利用率。
//        同时这个方法里，我们原先对 Actor 的 logs 属性的同步访问，需要修改成异步访问 （加上 await 关键字），因为这期间需要切换隔离域。
        
        // actor ParallelCompressor
        // 加上了 nonisolated 的关键字
//        nonisolated func compressFile(url: URL) async -> Data {
//          // 用 await 改成异步访问
//          await log(update: "Starting for \(url)")
//          let compressedData = CompressionUtils.compressDataInFile(at: url) { uncompressedSize in
//            Task { @MainActor in
//              status.update(url: url, uncompressedSize: uncompressedSize)
//            }
//          } progressNotification: { progress in
//            Task { @MainActor in
//              status.update(url: url, progress: progress)
//              await log(update: "Progress for \(url): \(progress)")
//            }
//          } finalNotificaton: { compressedSize in
//            Task { @MainActor in
//              status.update(url: url, compressedSize: compressedSize)
//            }
//          }
//          // 用 await 改成异步访问
//          await log(update: "Ending for \(url)")
//          return compressedData
//        }

      func log(update: String) {
        logs.append(update)
      }
    }
    
    //-----------------------------------
//    → 在 actor 中的声明，默认处于 actor 的隔离域中。
//    → 在 actor 中的声明，如果加上 nonisolated，那么它将被置于隔离域外。
//    → 在 actor 外的声明，默认处于 actor 隔离域外。
    //-----------------------------------
    //actor实现已有协议   使用nonisolated标记为隔离域外
//    extension Room: CustomStringConvertible {
//        //想要在 Room 中满足这样一个协议，唯一 的方法是明确将 Room.description 声明放到隔离域外，使用 nonisolated 标记
//        nonisolated var description: String {
//            "A room"
            //隔离域外的成员 description 是不能同步访问隔离域内的内容的,❌
//            "Room Visited: \(visitorCount)"
            //不过，Room 中用 let 声明的存储变量，是一个例外.在同一个模块内，从域外访问这样的值是透明的
//            "Room Number: \(roomNumber)"
//        }
        
//        由于 unsafeChangePersonName 在隔离域外，它可能在多个线程中以并行的方式被调用
//        此 时对 name 的修改将造成内存的数据竞争。因此这段代码是不安全的。
//        想要增加安全性，我们可以选择把 Person 也声明为 actor
//        nonisolated func unsafeChangePersonName() {
//            person.name = "Bruce"
//            print("Person: \(person)")
//        }
//    }
    
    //-----------------------------------
    //actor实现自定义协议
    //1.第一种方式是让 Popular 也能在某个隔离域中。这里可以让 PopularActor 作为 Actor 协议的细分存在
//    protocol PopularActor: Actor {
//        var popularActor: Bool { get }
//    }
//    extension Room: PopularActor {
//        var popularActor: Bool {
//        visitorCount > 10
//      }
//    }
    //2.让 Popular 协议对 actor 适用的第二种方法，是将涉及到的成员设计为异步方法或属性
//    protocol PopularAsync {
//        var popularAsync: Bool { get async }
//    }
//    extension Room: PopularAsync {
//        var popularAsync: Bool {
//            get async {
//                visitorCount > 10
//            }
//        }
//    }
    //虽然 popularAsync 的声明是处于 Room 的 actor 隔离域内的，但是它本身是一个异步 getter， 域内的其他方法要访问它时，依然需要 await。这有时候很不方便，而且具有传染性
//    extension Room: PopularAsync {
//        private var internalPopular: Bool {
//            visitorCount > 10
//        }
//
//        var popularAsync: Bool {
//            get async {
//                internalPopular
//            }
//        }
//    }
//    actor Room {
//    // ...
//        func reportPopular() {
//            if internalPopular {
//                print("Popular")
//            }
//        }
//    }
    
    //-----------------------------------
    //actor使用
    actor Room {
        let roomNumber = "101"
        var visitorCount: Int = 0
        init() {}
        func visit() -> Int {
            visitorCount += 1
            return visitorCount
        }
        //不同的 Room 实例拥有不同的 隔离域。如果要进行消息的 “转发”，我们必须明确使用 await
        func forwardVisit(_ anotherRoom: Room) async -> Int {
            await anotherRoom.visit()
        }
    }
    
    func bar() async {
        let room = Room()
        let visitCount = await room.visit()
        print(visitCount)
        print(await room.visitorCount)
    }
    //-----------------------------------
//    任务本地值 (task local value)，可以让我们也可以用类似的 static var 的方式，把元数据 “注入到” 当前任务绑定 的某个自定义值中。
//    对于任意一个类型中的静态的存储属性，我们都可以用 @TaskLocal 属性包装对它 进行声明，将它暴露为任务本地值。和 static 的 isCancelled 类似，这个值只在当前任务中有 效:
    enum Log {
        @TaskLocal static var id: String? //首先，它会把这个属性转变为只读，
    }
//    想要设置这个值，必须通过使用 Log.$id 的 withValue 方法。
//    Log.$id.withValue("Hello") {
//      print("Log.id: \(Log.id !" "")")
//    }
    
//    这个值可以在闭包中再一次被 Log.$id 上的 withValue 调用覆盖，并在任务之间进行传递
//    Log.id 将会寻找和返回最后一次 Log.$id.withValue 中所设定的值;
//    Log.$id.withValue("Outer") {
//      Task {
//        print("Log.id: \(Log.id ?? "")")//Log.id: Outer
//        await Log.$id.withValue("Inner") {
//          await Task {
//            print("Log.id: \(Log.id ?? "")")//Log.id: Inner
//          }.value
//        }
//        print("Log.id: \(Log.id ?? "")")//Log.id: Outer
//      }
//    }
    
    //适用于API追踪
    // app 首⻚
//    Log.$id.withValue("app home page") {
//        _ = await loadData()
//    }
    // app 设定⻚面
//    Log.$id.withValue("app setting page") {
//        _ = await loadData()
//    }

//    print("loadData started from \(Log.id !" "not set").")
    
    //-----------------------------------
    //任务让步
//    while loop {
//        loop = shouldLoopAgain()
//        if loop {
//            await Task.yield() //这个方法将会通知当前任务挂起，并把剩余工作重新进行包装后再次放入执行器 中进行派发。这样，当前线程就将被让出，它可以有机会执行其他任务
//        }
//    }
//    func shouldLoopAgain() -> Bool {
//        // 只是一个例子
//        return true
//    }
    
    //-----------------------------------
    //Task优先级
//    for _ in 0 ..< 4 { Task(priority: .background) {
//        print("in background task: \(Task.currentPriority)")
//      }
//    }
//    Task(priority: .userInitiated) {
//      print("in userInitiated task: \(Task.currentPriority)")
//    }
    
//    await withTaskGroup(of: Void.self, body: { group in
//        group.addTask(priority: .medium) {
//            try? await Task.sleep(nanoseconds: 100)
//            print("medium")
//        }
//        group.addTask(priority: .low) {
//            try? await Task.sleep(nanoseconds: 100)
//            print("low")
//        }
//        group.addTask(priority: .high) {
//            try? await Task.sleep(nanoseconds: 100)
//            print("high")
//        }
//        }
//    )
    
    //-----------------------------------
    //不论我们最终需不需要子任务的返回值，都应该保持明确写出对 group 等待操作的好 习惯。
    func doGroupAwait() async {
        let t = Task {
            do {
                try await withThrowingTaskGroup(of: Int.self, body: { group in
                    group.addTask { try await self.doGroupAwaitWork() }
                    group.addTask { try await self.doGroupAwaitWork() }
                    //如 果我们不希望在任务已经结束时还创建新的子任务，可以使用 addTaskUnlessCancelled 来在 相应的情况下跳过子任务的追加:
                    group.addTaskUnlessCancelled { try await self.doGroupAwaitWork() }
                    try await group.waitForAll()//明确写出等待
                })
            }catch {
                print("Error: \(error)")
            }
        }
        await Task.sleep(NSEC_PER_SEC)
        t.cancel()
    }
    
    func doGroupAwaitWork() async throws -> Int {
        try await Task.sleep(nanoseconds: 3 * NSEC_PER_SEC)
        print("Done")
        return 1
    }
    
    //-----------------------------------
    //在取消时，立即做出一些响应
//    func asyncObserve() async throws -> String {
//        let observer = Observer()
//        return try await withTaskCancellationHandler(operation: {
//            observer.start()
//            return try await withUnsafeThrowingContinuation({ continuation in
//                observer.waitForNextValue { value, error in
//                    if let value = value {
//                        continuation.resume(returning: value)
//                    } else {
//                        continuation.resume(throwing: error!)
//                    }
//                }
//            })
//        }, onCancel: {
//            // 取消时清理资源
//            observer.stop()
//        })
//    }
    
    //-----------------------------------
    //URLSession Task的取消
    func cancelNetTask() async {
        let t = Task {
            do {
                let (data, _) = try await URLSession.shared.data( from: URL(string: "https://example.com")!, delegate: nil)
                print(data.count)
            } catch {
                print(error)
          }
        }
        await Task.sleep(100)
        t.cancel()
    }
    
    
    //-----------------------------------
    //协作式任务取消---抛出错误
    func work2() async throws -> String {
        var s = ""
        for c in "Hello" {
            // 检查取消状态
//            guard !Task.isCancelled else {
//                throw CancellationError()
//            }
            //等于
            try Task.checkCancellation()
            
            
            await Task.sleep(NSEC_PER_SEC)
            print("Append: \(c)")
            s.append(c)
        }
        return s
        
        //使用
//        do {
//            let value = try await work()
//            print(value)
//        } catch is CancellationError {
//            print("任务被取消")
//        } catch {
//            print("其他错误:\(error)")
//        }
    }
    
    
    
    //-----------------------------------
    //协作式任务取消---返回空值或部分值
    func work1() async -> String {
        var s = ""
        for c in "Hello" {
            // 检查取消状态
            guard !Task.isCancelled else { return s }
            
            await Task.sleep(NSEC_PER_SEC)
            print("Append: \(c)")
            s.append(c)
        }
        return s
    }
    
    //-----------------------------------
    //取消任务
//    Swift 并发中对某个任务调用 cancel，做的事情只有两件:
//    → 将自身任务的 isCancelled 标识置为 true。  cancel() 调用只负责维护一个布尔变量，仅此而已。
//    → 在结构化并发中，如果该任务有子任务，那么取消子任务。
    //-----------------------------------
    //三者的区别
//    → TaskGroup.addTask和asynclet-创建结构化的子任务，继承优先级和本地值。
//    → Task.init-创建非结构化的任务根节点，从当前任务中继承运行环境:比如actor隔离
//    域，优先级和本地值等。
//    → Task.detached-创建非结构化的任务根节点，不从当前任务中继承优先级和本地值等 运行环境，完全新的游离任务环境。
    

    //-----------------------------------
    //非结构化任务
//    使用 Task.init 和 Task.detached 来创建新任务，这类任务具有最高的灵活性，它们可以在任何地方被创建。它们生成一棵新的任务树，并位于
//    顶层，不属于任何其他任务的子任务，生命周期不和其他作用域绑定，当然也没有结构化并发
//    的特性。
//    一旦创建任务，其中的异步任务就会被马上提交并执行。
    //    用 Task.init 或 Task.detached 明确创建的 Task，是没有结构化并发特性的。Task 值超过作用 域并不会导致自动取消或是 await 行为。想要取消一个这样的 Task，必须持有返回的 Task 值 并明确调用 cancel
//    这种非结构化并发中，外层的 Task 的取消，并不会传递到内层 Task。或者，更准确来说，这 样的两个 Task 并没有任何从属关系，它们都是顶层任务:
    //-----------------------------------
    //通过 withTaskGroup 为 当前的任务添加一组结构化的并发子任务:
    struct TaskGroupSample {
        func start() async {
            print("Start")
            
            await withTaskGroup(of: Int.self) { group in
                for i in 0..<3 {
                    group.addTask {
//                        addTaskAPI把新的任务添加到当前任务中。被添加的任务会在调度器获取到可用资源 后立即开始执行
                        await work(i)
                    }
                }
                print("Task added")
                
                for await result in group {
                    print("Get result: \(result)")
                }
                print("Task ended")
            }
            print("End")
        }
        //任务组的值捕获
        func start1() async {
            let v: Int = await withTaskGroup(of: Int.self) { group in
                var value = 0
                for i in 0..<3 {
                    group.addTask {
                        return await work(i)
                    }
                }
                
                for await result in group {
                    value += result
                }
                return value
            }
            print("End. Result: \(v)")
        }
        //使用async let简化结构化并发的使 用
        func start2() async {
            print("Start ----\(Thread.current)")
            async let v0 = work(0)
            async let v1 = work(1)
            async let v2 = work(2)
            print("Task added")
//            let result0 = await v0
//            let result1 = await v1
//            let result2 = await v2
            let result = await v0 + v1 + v2
            print("Task ended ----\(Thread.current)")
            print("End. Result: \(result)")
        }
        //结构化并发组合
        func start3() async {
            async let v02: Int = { //async let 赋值等号右边,也可 以是一个匿名函数
                async let v0 = work(0)
                async let v2 = work(2)
                return await v0 + v2
                //将会顺次执行 work(0) 和 work(2)，并把它们的结果相加。这时两个操 作不是并发执行的，也不涉及新的子任务。
//                return await work(0) + work(2)
            }()
            async let v1 = work(1)
            _ = await v02 + v1
            print("End")
        }
        //访问任务的值
        func start4() async {
            let t1 = Task { await work(1) }
            let t2 = Task.detached { await work(2) }
            let v1 = await t1.value
            let v2 = await t2.value
        }
        //这种非结构化并发中，外层的 Task 的取消，并不会传递到内层 Task。或者，更准确来说，这 样的两个 Task 并没有任何从属关系，它们都是顶层任务
        func start5() async {
            let outer = Task {
                let innner = Task {
                await work(1)
              }
              await work(2)
            }
            outer.cancel()
//            outer.isCancelled // true
//            inner.isCancelled // false
        }
        //将结构化并发和非结构化的任务组合起来使用
        func start6() async {
            async let t1 = Task {
                await work(1)
                print("Cancelled: \(Task.isCancelled)")
              }.value
            
            async let t2 = Task.detached {
                await work(2)
                print("Cancelled: \(Task.isCancelled)")
            }.value
//            t1 和 t2 确实是结构化的，但是它们开启的新任务，却并非如此:虽然 t1 和 t2 在超出 start 作 用域时，由于没有 await，这两个绑定都将被取消，但这个取消并不能传递到非结构化的 Task 中，所以两个 isCancelled 都将输出 false。
        }
        
        private func work(_ value: Int) async -> Int {
            print("Start work \(value)----\(Thread.current)")
            await Task.sleep(UInt64(value) * NSEC_PER_SEC)
            print("Work \(value) done")
            return value
        }
    }
    //-----------------------------------
    //基于 Task 的结构化并发模型
    //使用 withUnsafeCurrentTask 来获取和检查当前任务
    func testWithUnsafeCurrentTask() {
        withUnsafeCurrentTask { task in
//            对于获取到的 task，可以访问它的 isCancelled 和 priority 属性检查它是否已经被取消
//            以及当前的优先级。我们甚至可以调用 cancel() 来取消这个任务
            print(task as Any) // => nil
        }
        //虽然被定义为 static var，但是它们并不表示针对所有 Task 类型通用的某个全局属性，而是表 示当前任务的情况
//        Task.isCancelled//
//        Task.currentPriority//
    }
    
    //-----------------------------------
    //通知转异步序列
    func testNotifications()  {
        Task {
            let backgroundNotifications = NotificationCenter.default.notifications(named: UIApplication.didEnterBackgroundNotification, object: nil)
            for await notification in backgroundNotifications {
                print(notification)
                break
            }
//            或者使用 first 来把异步序列收敛到一个异步值:
//            if let notification = await backgroundNotifications .first(where: { _ in true })
//            {
//              print(notification)
//            }
        }
        //利用 Task 的 cancel 来让序列提前终结，来避免泄漏:
//        task.cancel()
    }
    
    //-----------------------------------
//    基于 bytes 的异步序列
//    bytes(from:) 返回的不是完 整的 Data，而是一个代表响应中 body 字节数据的 AsyncBytes 类型。AsyncBytes 是一个异步 的数据序列，它的值代表了数据的每个字节。
    func testSessionBytes() async throws {
        let url = URL(string: "https://example.com")!
        let session = URLSession.shared
        let (bytes, response) = try await session.bytes(from: url)
        for try await byte in bytes {
          print(byte, terminator: ",")
            // 输出，每个接收到的字节
            // 60,33,100,111,99
        }
        
        //通过前几个字节来判断响应 body 的一些属性
        var pngHeader: [UInt8] = [137, 80, 78, 71, 13, 10, 26, 10]
        for try await byte in bytes.prefix(8) {
            if byte != pngHeader.removeFirst() {
                print("Not PNG")
                return
            }
        }
        print("PNG")
        //AsyncSequence其他方法
        for try await line in bytes.lines {
            print(line)
        }
        //URL 现在也接受类似的方法:url.resourceBytes 返回一个异步的字节序列， url.lines 按行返回字符串序列。
//        let url = URL(string: "https:\\example.com")!
        for try await line in url.lines {
            print(line)
        }
    }
    
    
    //-----------------------------------
    //URLSession的异步api
    func testURLSession() async throws {
//        1. 网络请求任务将立即开始，不再依赖于调用 resume。
//        2. 和之前针对整个 session 的 delegate 不同，这里的 delegate 是针对单个任务的。
        let url = URL(string: "")!
        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse {
          print("Status Code: \(httpResponse.statusCode)")
        }
        print("Data: \(data.count) bytes.")
    }
    
    //-----------------------------------
    //将任意 Publisher 转换为异步序 列
    func publisherToStream() {
        Task.detached {
            let stream = Timer.publish(every: 1, on: .main, in: .default)
                .autoconnect()
                .asAsyncStream
            for try await v in stream {
                print("\(Thread.current)-----\(v)")
            }
        }
    }
    
    //-----------------------------------
    //AsyncStream使用
    var timerStream: AsyncStream<Date> {
        AsyncStream<Date> { continuation in
            let initial = Date()
            
            Task {
                let t = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    let now = Date()
                    print("Call yield")
                    continuation.yield(Date())
                    
                    let diff = now.timeIntervalSince(initial)
                    if diff > 10 {
                        print("Call finish")
                        continuation.finish()
                    }
                }
                
                continuation.onTermination = { @Sendable state in
                    print("onTermination: \(state)")
                    t.invalidate()
                }
            }
        }
    }
    typealias WorkItem = @Sendable () async throws -> Void
    func testAsyncStream() {
        let (stream, continuation) = AsyncStream<WorkItem>.makeStream()

        // begin enumerating the sequence with a single Task
        // hazard 1: this Task will run at a fixed priority
        Task {
            // the sequence guarantees order
            for await workItem in stream {
                try? await workItem()
            }
        }

        // the continuation provides access to an async context
        // Hazard 2: per-work item cancellation is unsupported
        continuation.yield({
            // Hazard 3: thrown errors are invisible
            try await self.work()
        })
    }
    
    func work() async throws {
    }
    
    //在 10 秒后，timerStream 进入到 diff > 10 的分支，continuation.finish() 被调用，进而触发 onTermination 闭包，且得到的结果为 finished
    //使用
//    let t = Task {
//        let timer = timerStream
//        for await v in timer {
//            print(v)
//        }
//    }
    //取消
//    await Task.sleep(2 * NSEC_PER_SEC)
//    t.cancel()
    //数据消耗来驱动
    func testAsyncStream() async {
        let timer = AsyncStream<Date> {
            await Task.sleep(NSEC_PER_SEC)
            return Date()
        } onCancel: { @Sendable in
            print("Cancelled")
        }
        
        for await v in timer {
            print(v)
        }

    }
    
    //--------------------------
    //异步只读属性
    class File {
        var size: Int {
            get async throws {
//                if corrupted {
//                    throw FileError.corrupted
//                }
                try await heavyOperation()
            }
        }
        func heavyOperation() async throws -> Int {
            return 1
        }
    }
    
    //下标读取
//    class File {
//        subscript(_ attribute: AttributeKey) -> Attribute {
//            //比如 await file[.readonly] == true
//            get async {
//                let attributes = await loadAttributes()
//                return attributes[attribute]
//            }
//        }
//    }
    
    //--------------------------
//异步函数也遵守同样的规则:当一个 Swift 中的 async 函数被标记为 @objc 时，它在 Objective-C 中会由一个带有 completionHandler 的回调闭包版本表示
    func requestAuthorization() {
        Task {
            let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        }
    }
    
    
    //--------------------------
    //封装代理为异步函数
//    class Worker: WorkDelegate {
//        var continuation: CheckedContinuation<[String], Error>?
//
//        func doWork() async throws -> [String] {
//            try await withCheckedThrowingContinuation({ continuation in
//                self.continuation = continuation
//                performWork(delegate: self)
//            })
//        }
//        func workDidDone(values: [String]) {
//            continuation?.resume(returning: values)
//            continuation = nil //但是作为 continuation 来说，不论成败，它只 支持一次 resume 调用。在上面的代码中，我们通过 resume 调用后将 self.continuation 置为 nil 来避免重复调用。
//        }
//        func workDidFailed(error: Error) {
//            continuation?.resume(throwing: error)
//            continuation = nil
//        }
//    }
    
    //--------------------------
//    withUnsafeContinuation
//    withCheckedContinuation
//    withCheckedThrowingContinuation
//    withUnsafeThrowingContinuation 包装
//    Unsafe 和 Checked 版本的区别在于是否对 continuation 的调用状况进行运行时的检查。
    func load(completion: @escaping ([String]?, Error?) -> Void) {
        completion([], nil)
    }
    //包装后
    func load() async throws -> [String] {
        try await withUnsafeThrowingContinuation { continuation in
            //调用原来的函数
            load { values, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let values = values {
                    continuation.resume(returning: values)
                }else {
                    assertionFailure("Both parameters are nil")
                }
            }
        }
    }


    //--------------------------
//    @completionHandlerAsync  使用
//    我们可以为原本的回调版本添加 @completionHandlerAsync 注解，告诉编 译器存当前函数存在一个异步版本。这样，当使用者在其他异步函数中调用了这个回调版本时， 编译器将提醒使用者可以迁移到更合适的异步版本
    
//    @completionHandlerAsync(
//      "calculate(input:)",
//      completionHandlerIndex: 1
//    )
//    func calculate(input: Int, completion: @escaping (Int) -> Void) {
//      completion(input + 100)
//    }
//
//    @completionHandlerAsync("calculate(input:)")
//    func calculate(input: Int, completion: @escaping (Int) -> Void) {
//      completion(input + 100)
//    }
//
//    func calculate(input: Int) async -> Int {
//        return input + 100
//    }
}

// 让协议方法在主线程执行
protocol MyProtocol {
    func doThing(argument: Int) -> Void
}

@MainActor
class MyClass {
}

extension MyClass: MyProtocol {
    func doThing(argument: Int) -> Void {
        
    }
}
// 让协议方法保持非隔离 1
//extension MyClass: MyProtocol {
//    nonisolated func doThing1(argument: Int) -> Void {
//        // at this point, you likely need to interact with self, so you must satisfy the compiler
//        // hazard 1: Availability
//        MainActor.assumeIsolated {
//            // here you can safely access `self`
//        }
//    }
//}

// 让协议方法异步
//protocol MyProtocol {
//    // hazard 1: Async Virality (for other conformances)
//    func doThing(argument: String) async -> Int
//}
//
//@MainActor
//class MyClass: MyProtocol {
//    // hazard 2: Async Virality (for callers)
//    func doThing(argument: String) async -> Int {
//        return 42
//    }
//}

// 自定义actor实现协议

//protocol NotAsyncFriendly {
//    func informational()
//
//    func takesSendableArguments(_ value: Int)
//
//    func takesNonSendableArguments(_ value: NonSendableType)
//
//    func expectsReturnValues() -> Int
//}
//
//actor MyActor {
//    func doIsolatedThings(with value: Int) {
//        ...
//    }
//}
//
//extension MyActor: NotAsyncFriendly {
//    // purely informational calls are the easiest
//    nonisolated func informational() {
//        // hazard: ordering
//        // the order in which these informational messages are delivered may be important, but is now lost
//        Task {
//            await self.doIsolatedThings(with: 0)
//        }
//    }
//
//    nonisolated func takesSendableArguments(_ value: Int) {
//        // hazard: ordering
//        Task {
//            // we can safely capture and/or make use of value here because it is Sendable
//            await self.doIsolatedThings(with: value)
//        }
//    }
//    
//    nonisolated func takesNonSendableArguments(_ value: NonSendableType) {
//        // hazard: sendability
//
//        // any action taken would have to either not need the actor's isolated state or `value`.
//        // That's possible, but starting to get tricky.
//    }
//
//    nonisolated func expectsReturnValues() -> Int {
//        // hazard: sendability
//
//        // Because this function expects a synchronous return value, the actor's isolated state
//        // must not be needed to generate the return. This is also possible, but is another indication
//        // that an actor might be the wrong option.
//        
//        return 42
//    }
//}
