//
//  ConcurrencyViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/3/28.
//  https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html
//  https://www.hackingwithswift.com/quick-start/concurrency
//  https://www.bennyhuo.com/book/swift-coroutines/

import UIKit
import WebKit
import CoreLocation
import CoreLocationUI
import CryptoKit

extension URLSession {
    static let noCacheSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: config)
    }()
}

class ConcurrencyViewController: UIViewController {
    
    
    @available(iOS 15.0, *)
    func fetchNews() async -> Data? {
        do {
            let url = URL(string: "https://hws.dev/news-1.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            print("  \(Thread.current)")
            return data
        } catch {
            print("Failed to fetch data")
            return nil
        }
    }

    
        
    //调用异步函数的三种方式
    //1、在命令行工具中使用@main,把main方法标记为async
//    @main
//    struct MainApp {
//        static func main() async {
//            await processWeather()
//        }
//    }
    //2、在SwiftUI中使用refreshable() and task()
//    var body: some View {
//        ScrollView {
//            Text(sourceCode)
//        }
//        .task {
//            await fetchSource()
//        }
//    }
    //3、使用Task API
    //-----------------------------------
    //异步计算属性
    struct RemoteFile<T: Decodable> {
        let url: URL
        let type: T.Type
        
//        var contents: T {
//            get async throws {
//                if #available(iOS 15.0, *) {
//                    let (data, _) = try await URLSession.noCacheSession.data(from: url)
//                    return try JSONDecoder().decode(T.self, from: data)
//                } else {
//
//                }
//            }
//        }
    }
    //-----------------------------------
    //async let 的使用
    //有时，您希望同时运行几个异步操作，然后等待它们的结果返回，最简单的方法是使用async let。
    //这使您可以启动几个异步函数，所有这些函数都会立即开始运行——这比按顺序运行要高效得多。
    //一个常见的例子是，当您必须发出两个或多个网络请求时，这些请求彼此都不相关。
    struct User: Decodable {
        let id: UUID
        let name: String
        let age: Int
    }
    struct Message: Decodable,Identifiable {
        let id: Int
        let from: String
        let message: String
    }
    @available(iOS 15.0, *)
    func loadData() async {
//        Even though the data(from:) method is async, we don’t need to use await before it because that’s implied by async let.
//        The data(from:) method is also throwing, but we don’t need to use try to execute it because that gets pushed back to when we actually want to read its return value.
        async let (userData, _) = URLSession.shared.data(from: URL(string: "http://xxx")!)
        async let (messageData, _) = URLSession.shared.data(from: URL(string: "http://xxx")!)
//    我们的两个数据（from:）调用都可能抛出，所以当我们读取这些值时，我们需要使用try。
//    当主loadData（）函数继续执行时，我们的两个数据（from:）调用同时运行，因此我们需要使用await读取它们的值，以防它们还没有准备好。
        do {
            let decoder = JSONDecoder()
            let user = try await decoder.decode(User.self, from: userData)
            let message = try await decoder.decode([Message].self, from: messageData)
        } catch {
            print("error")
        }
    }
    //async let捕获问题
    @available(iOS 15.0, *)
    func fetchFavorites(for user: User) async -> [Int] {
        print("fetch for \(user.name)")
        do {
            async let (favorites, _) = URLSession.shared.data(from: URL(string: "http://xxx")!)
            return try await JSONDecoder().decode([Int].self, from: favorites)
        }catch {
            return []
        }
    }
    //-----------------------------------
    //await 和 async let 的区别
    //await立即等待工作完成，以便我们可以读取其结果，而async-let则没有。
    
    //第二个请求对第一个有依赖关系，用await
//    let first = requestFirstData()
//    let second = requestSecondData(using:first)
    
//    因此，如果在继续之前有一个值很重要，请使用await，如果您的工作暂时可以继续而没有该值，请使用async let——您可以在以后实际需要时使用await。
//    func getAppData() -> ([News], [Weather], Bool) {
//        async let news = getNews()
//        async let weather = getWeather()
//        async let hasUpdate = getAppUpdateAvailable()
//        return await(news, weather, hasUpdate)
//    }
    @available(iOS 15.0, *)
    func fetchForUser() async {
        //var user  ❌Reference to captured var 'user' in concurrently-executing code
        let user = User(id: UUID(), name: "Jack", age: 18)
        async let favorites = fetchFavorites(for: user)
        await print("\(favorites.count)")
    }
    //-----------------------------------
    //使用continuations将以前的闭包回调式异步代码转换为async/await的异步调用
    // 老代码
    func fetchMessages(completion: @escaping ([Message]) -> Void) {
        let url = URL(string: "http://")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                    completion(messages)
                    return
                }
            }
            completion([])
        }.resume()
    }
    //添加新方法
    func fetchMessages() async -> [Message] {
        await withCheckedContinuation({ continuation in
            fetchMessages { messages in
//                continuation.resume(throwing: <#T##Never#>)
//                continuation.resume(with: <#T##Result<[Message], Never>#>)
                continuation.resume(returning: messages)
            }
        })
        //或者 withUnsafeContinuation
    }
    //-----------------------------------
//    创建可以抛出异常的continuations
//    withCheckedThrowingContinuation（）和withUnsafeThrowingContinuation（）
    enum FetchError: Error {
        case noMessages
    }
    func fetchMessages1() async -> [Message] {
        do {
            return try await withCheckedThrowingContinuation({ continuation in
                fetchMessages { messages in
                    if messages.isEmpty {
                        continuation.resume(throwing: FetchError.noMessages)
                    }else {
                        continuation.resume(returning: messages)
                    }
                }
            })
        } catch {
            return [Message(id: 1, from: "Tom", message: "welcome")]
        }
        
    }
    
    //-----------------------------------
    //  解决多个代码方法决定结果的转换问题 例如WKWebView的
//    optional func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
//    optional func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    
    class LocationManager: NSObject, ObservableObject,CLLocationManagerDelegate {
        var locationContinuation: CheckedContinuation<CLLocationCoordinate2D?,Error>?
        let manager = CLLocationManager()
        override init() {
            super.init()
            manager.delegate = self
        }
        func requestLocation() async throws -> CLLocationCoordinate2D? {
            try await withCheckedThrowingContinuation({ continuation in
                locationContinuation = continuation
                manager.requestLocation()
            })
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            locationContinuation?.resume(returning: locations.first?.coordinate)
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            locationContinuation?.resume(throwing: error)
        }
    }
    //使用
//    var locationManager = LocationManager()
//    let location = try await locationManager.requestLocation()
    //-----------------------------------
//    Sequence, AsyncSequence, and AsyncStream 的区别
//    AsyncSequence协议几乎与Sequence相同，但重要的例外是序列中的每个元素都是异步返回的。
//    1、首先，从异步序列中读取一个值必须使用wait，这样序列在读取下一个值时可以挂起自己。
//    2、第二，更高级的异步序列（称为异步流）生成值的速度可能快于读取值的速度，在这种情况下，您可以丢弃额外的值，或者将其缓冲以供以后读取。
    
//    可以使用for、while和repeat遍历AsyncSequence，但是读取值必须使用await或try await
//    例如，URL有一个内置的lines属性，可以直接从URL生成所有行的异步序列。
    @available(iOS 15.0, *)
    func fetchUsers() async throws {
        let url = URL(string: "http://xxx")!
        for try await line in url.lines {
            print("Received user: \(line)")
        }
        
        var iterator = url.lines.makeAsyncIterator()
        while let line = try await iterator.next() {
            print("user is \(line)")
        }
    }
    
    //map
    @available(iOS 15.0, *)
    func shoutQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let uppercaseLines = url.lines.map(\.localizedUppercase)
        for try await line in uppercaseLines {
            print(line)
        }
    }
    
    struct Quote {
        let text: String
    }

    @available(iOS 15.0, *)
    func printQuotes() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!

        let quotes = url.lines.map(Quote.init)

        for try await quote in quotes {
            print(quote.text)
        }
    }
    @available(iOS 15.0, *)
    func printQuotes1() async throws {
        let url = URL(string: "https://hws.dev/quotes.txt")!

        let anonymousQuotes = url.lines.filter { $0.contains("Anonymous") }
        let topAnonymousQuotes = anonymousQuotes.prefix(5)
        let shoutingTopAnonymousQuotes = topAnonymousQuotes.map(\.localizedUppercase)

        for try await line in shoutingTopAnonymousQuotes {
            print(line)
        }
    }
    @available(iOS 15.0, *)
    func getQuotes() async -> some AsyncSequence {
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let anonymousQuotes = url.lines.filter { $0.contains("Anonymous") }
        let topAnonymousQuotes = anonymousQuotes.prefix(5)
        let shoutingTopAnonymousQuotes = topAnonymousQuotes.map(\.localizedUppercase)
        return shoutingTopAnonymousQuotes
    }
//    let result = await getQuotes()
//    do {
//        for try await quote in result {
//            print(quote)
//        }
//    } catch {
//        print("Error fetching quotes")
//    }
    //allSatisfy() min（）、max（）和reduce（）不能用在无尽序列，因为他们需要先访问序列里每个值
    @available(iOS 15.0, *)
    func printHighestNumber() async throws {
        let url = URL(string: "https://hws.dev/random-numbers.txt")!
        if let highest = try await url.lines.compactMap(Int.init).max() {
            print("Highest number: \(highest)")
        } else {
            print("No number was the highest.")
        }
    }
    //-----------------------------------
//    如何自定义一个AsyncSequence
//    1.实现协议AsyncSequence和AsyncIteratorProtocol
//    2.next()方法标记为async
//    3.创建makeAsyncIterator()方法
    
    //一个数字加倍的例子
    struct DoubleGenerator: AsyncSequence, AsyncIteratorProtocol {
        typealias Element = Int
        var current = 1

        mutating func next() async -> Element? {
            defer { current &*= 2 }

            if current < 0 {
                return nil
            } else {
                return current
            }
        }
        func makeAsyncIterator() -> DoubleGenerator {
            self
        }
    }
//    let sequence = DoubleGenerator()
//    for await number in sequence {
//        print(number)
//    }
    @available(iOS 15.0, *)
    struct URLWatcher: AsyncSequence, AsyncIteratorProtocol {
        typealias Element = Data

        let url: URL
        let delay: Int
        private var comparisonData: Data?
        private var isActive = true

        init(url: URL, delay: Int = 10) {
            self.url = url
            self.delay = delay
        }

        mutating func next() async throws -> Element? {
            // Once we're inactive always return nil immediately
            guard isActive else { return nil }

            if comparisonData == nil {
                // If this is our first iteration, return the initial value
                comparisonData = try await fetchData()
            } else {
                // Otherwise, sleep for a while and see if our data changed
                while true {//一直抓取新数据，直到数据变动
                    try await Task.sleep(nanoseconds: UInt64(delay) * 1_000_000_000)
                    let latestData = try await fetchData()

                    if latestData != comparisonData {
                        // New data is different from previous data,
                        // so update previous data and send it back
                        comparisonData = latestData
                        break
                    }
                }
            }

            if comparisonData == nil {
                isActive = false
                return nil
            } else {
                return comparisonData
            }
        }

        @available(iOS 15.0, *)
        private func fetchData() async throws -> Element {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        }

        func makeAsyncIterator() -> URLWatcher {
            self
        }
    }

    // As an example of URLWatcher in action, try something like this:
    @available(iOS 15.0, *)
    func fetchUsers1() async {
        let url = URL(fileURLWithPath: "FILENAMEHERE.json")
        let urlWatcher = URLWatcher(url: url, delay: 3)
        do {
            for try await data in urlWatcher {
//                try withAnimation {
//                    users = try JSONDecoder().decode([User].self, from: data)
//                }
            }
        } catch {
            // just bail out
        }
    }
    //-----------------------------------
    //AsyncSequence 转换为 Sequence
    //1.使用reduce(into:)
//    extension AsyncSequence {
//        func collect() async rethrows -> [Element] {
//            try await reduce(into: [Element]()) { $0.append($1) }
//        }
//    }
//    func getNumberArray() async throws -> [Int] {
//        let url = URL(string: "https://hws.dev/random-numbers.txt")!
//        let numbers = url.lines.compactMap(Int.init)
//        return try await numbers.collect()
//    }
    
    //-----------------------------------
//    Task  TaskGroup
//    你选择任务还是任务组取决于你的工作目标：如果你想开始一两项独立的工作，那么任务就是正确的选择。如果您想将一个作业拆分为多个并发操作，那么TaskGroup更适合。
//    一旦创建任务，它就会开始运行——没有start（）方法或类似方法。
//    尽量不用Task.detached
    struct NewsItem: Decodable {
        let id: Int
        let title: String
        let url: URL
    }

    struct HighScore: Decodable {
        let name: String
        let score: Int
    }

    @available(iOS 15.0, *)
    func fetchUpdates() async {
        let newsTask = Task { () -> [NewsItem] in
            let url = URL(string: "https://hws.dev/headlines.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([NewsItem].self, from: data)
        }

        let highScoreTask = Task { () -> [HighScore] in
            let url = URL(string: "https://hws.dev/scores.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([HighScore].self, from: data)
        }

        do {
            let news = try await newsTask.value
            let highScores = try await highScoreTask.value
            print("Latest news loaded with \(news.count) items.")

            if let topScore = highScores.first {
                print("\(topScore.name) has the highest score with \(topScore.score), out of \(highScores.count) total results. ")
            }
        } catch {
            print("There was an error loading user data.")
        }
    }
    
    //-----------------------------------
//    Task的返回值
//    1.可以直接使用 try await task.value
//    2.也可以使用downloadTask.result
    enum LoadError: Error {
        case fetchFailed, decodeFailed
    }

    @available(iOS 15.0, *)
    func fetchQuotes() async {
        let downloadTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/quotes.txt")!
            let data: Data

            do {
                (data, _) = try await URLSession.shared.data(from: url)
            } catch {
                throw LoadError.fetchFailed
            }

            if let string = String(data: data, encoding: .utf8) {
                return string
            } else {
                throw LoadError.decodeFailed
            }
        }
        let result = await downloadTask.result
        do {
            let string = try result.get()
            print(string)
        } catch LoadError.fetchFailed {
            print("Unable to fetch the quotes.")
        } catch LoadError.decodeFailed {
            print("Unable to convert quotes to text.")
        } catch {
            print("Unknown error.")
        }
        
    }

//    await fetchQuotes()
    //-----------------------------------
    // 任务的优先级
    // 系统可以使用该优先级来确定下一步应该执行哪个任务，但这并不能保证——可以将其视为建议，而不是规则。
    // 虽然创建任务时可以直接为其分配优先级，但如果不这样做，Swift将遵循三条规则自动确定优先级：
    // 1.如果任务是从其他任务创建的，则子任务将继承父任务的优先级。
    // 2.如果新任务是直接从主线程创建的，而不是从任务创建的，则会自动为其分配最高优先级userInitiated。
    // 3.如果新任务不是由另一个任务或主线程执行的，Swift将尝试查询该线程的优先级或给它一个nil优先级。
    // 这意味着不指定确切的优先级通常是个好主意，因为Swift会做正确的事情。
    // 查询当前任务优先级，用Task.currentPriority
    @available(iOS 15.0, *)
    func fetchQuotes2() async {
        let downloadTask = Task(priority: .high) { () -> String in
            let url = URL(string: "https://hws.dev/chapter.txt")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return String(decoding: data, as: UTF8.self)
        }

        do {
            let text = try await downloadTask.value
            print(text)
        } catch {
            print(error.localizedDescription)
        }
    }
    //-----------------------------------
    // 任务的取消
    // 1.使用cancel()取消任务
    // 2.使用Task.isCancelled检查任务是否取消
    // 3.使用Task.checkCancellation()检查时，如果任务已取消则抛出错误CancellationError
    // 4.Foundation的某些部分会自动检查任务取消并抛出取消异常
    // 5.如果使用了 Task.sleep()，即使任务被取消，任务仍将处于睡眠状态。
    // 6.如果任务是组的一部分，并且组的任何部分抛出错误，则其他任务将被取消并等待。
    // 7.如果使用了SwiftUI的task()，则任务会在view disappears时，自动取消
    @available(iOS 15.0, *)
    func getAverageTemperature() async {
        let fetchTask = Task { () -> Double in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            try Task.checkCancellation()
            let readings = try JSONDecoder().decode([Double].self, from: data)
            let sum = readings.reduce(0, +)
            return sum / Double(readings.count)
        }

        do {
            let result = try await fetchTask.value
            print("Average temperature: \(result)")
        } catch {
            print("Failed to get data.")
        }
    }
    
    @available(iOS 15.0, *)
    func getAverageTemperature1() async {
        let fetchTask = Task { () -> Double in
            let url = URL(string: "https://hws.dev/readings.json")!

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if Task.isCancelled { return 0 }//显式取消

                let readings = try JSONDecoder().decode([Double].self, from: data)
                let sum = readings.reduce(0, +)
                return sum / Double(readings.count)
            } catch {
                return 0 //URLSession.shared.data(from: url)隐式取消处理点
            }
        }

        fetchTask.cancel()//立即取消

        let result = await fetchTask.value
        print("Average temperature: \(result)")
    }
    //-----------------------------------
    // 如何让任务休眠
    // 休眠至少3秒
    // 取消一个休眠任务，任务会被唤醒，并抛出一个CancellationError
    // try await Task.sleep(nanoseconds: 3_000_000_000) //纳秒
    
//    extension Task where Success == Never, Failure == Never {
//        static func sleep(seconds: Double) async throws {
//            let duration = UInt64(seconds * 1_000_000_000)
//            try await Task.sleep(nanoseconds: duration)
//        }
//    }
    
    //-----------------------------------
//    如何自动暂停任务
//    使用Task.yield() 自动暂停当前任务，以便Swift可以在需要时给其他任务一点继续的机会。
//    调用yield（）并不总是意味着任务将停止运行：如果它的优先级高于其他正在等待的任务，那么您的任务完全有可能立即恢复工作。将此视为指导——我们给Swift临时执行其他任务的机会，而不是强迫它这样做。
//    Task.yield() as the equivalent of calling a fictional Task.doNothing()
    func factors(for number: Int) async -> [Int] {
        var result = [Int]()
        for check in 1...number {
            if number.isMultiple(of: check) {
                result.append(check)
                print("find---\(check)")
                await Task.yield()//每找到一个因子，就让步暂停一下
            }
        }
        
        return result
    }
    //-----------------------------------
    // 如何创建任务组
//    任务组是一系列任务的集合，它们共同工作以产生单一的结果。组中的每个任务都必须返回相同类型的数据，但如果使用与枚举关联的值，则可以让它们发回不同类型的数据
//    使用withTaskGroup(of:)创建任务组
    func printMessage() async {
       let string = await withTaskGroup(of: String.self) { group -> String in
           group.addTask { "Hello" }
           group.addTask { "From" }
           group.addTask { "A" }
           group.addTask { "Task" }
           group.addTask { "Group" }

           var collected = [String]()

           for await value in group {//任务结果是按照完成顺序而不是创建顺序发送回来的
               collected.append(value)
           }
           return collected.joined(separator: " ")
       }
       print(string)
   }
    // 如果要抛出错误就使用 withThrowingTaskGroup
//    func loadStories() async {
//        do {
//            stories = try await withThrowingTaskGroup(of: [NewsStory].self) { group -> [NewsStory] in
//                for i in 1...5 {
//                    group.addTask {
//                        let url = URL(string: "https://hws.dev/news-\(i).json")!
//                        let (data, _) = try await URLSession.shared.data(from: url)
//                        return try JSONDecoder().decode([NewsStory].self, from: data)
//                    }
//                }
//                //因为任务组符合AsyncSequence，所以我们可以调用它的reduce（）方法，将其所有任务结果浓缩为一个值，在本例中是一个新闻故事数组。
//                let allStories = try await group.reduce(into: [NewsStory]()) { $0 += $1 }
//                return allStories.sorted { $0.id > $1.id }  //一个团队中的任务可以以任何顺序完成，因此我们对产生的一系列新闻故事进行了排序，以使它们以合理的顺序完成。
//            }
//        } catch {
//            print("Failed to load stories")
//        }
//    }
    //-----------------------------------
    // 如何取消TaskGroup
    // 取消的三种方式
    // 1.TaskGroup的父Task取消了
    // 2.显式调用cancelAll()
    // 3.如果您的一个子任务抛出了一个未捕获的错误，那么所有剩余的任务都将被隐式取消
    // 一个简单示例
    func printMessage1() async {
        let result = await withThrowingTaskGroup(of: String.self) { group -> String in
            group.addTask { return "Testing" }
            group.addTask { return "Group" }
            group.addTask { return "Cancellation" }

            group.cancelAll()
            var collected = [String]()
            do {
                for try await value in group {
                    collected.append(value)
                }
            } catch {
                print(error.localizedDescription)
            }
            return collected.joined(separator: " ")
        }
//        但当代码运行时，您仍然会看到所有三个字符串都打印出来。
//        取消任务组是合作的，因此除非您添加的任务隐式或显式地检查取消，否则单独调用cancelAll（）不会有多大作用。
        print(result)
    }
    //优化后
//    记住，调用cancelAll（）只会取消剩余的任务，这意味着它不会撤消已经完成的工作。即使这样，取消也是合作的，因此您需要确保添加到组中的任务检查取消情况。
//    group.addTask {
//        try Task.checkCancellation()
//        return "Testing"
//    }
    struct NewsStory: Identifiable, Decodable {
        let id: Int
        let title: String
        let strap: String
        let url: URL
    }
    private var stories = [NewsStory]()
    func loadStories() async {
        do {
            try await withThrowingTaskGroup(of: [NewsStory].self) { group -> Void in
                for i in 1...5 {
                    group.addTask {
                        let url = URL(string: "https://hws.dev/news-\(i).json")!
                        let (data, _) = try await URLSession.shared.data(from: url)
                        try Task.checkCancellation()
                        return try JSONDecoder().decode([NewsStory].self, from: data)
                    }
                }

                for try await result in group {
                    if result.isEmpty {
                        group.cancelAll()
                    } else {
                        stories.append(contentsOf: result)
                    }
                }

                stories.sort { $0.id < $1.id }
            }
        } catch {
            print("Failed to load stories: \(error.localizedDescription)")
        }
    }
//    任务组被取消的另一种方式是其中一个任务抛出未捕获的错误。
    enum ExampleError: Error {
        case badURL
    }

    func testCancellation() async {
        do {
            try await withThrowingTaskGroup(of: Void.self) { group -> Void in
                group.addTask {
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    throw ExampleError.badURL
                }
                group.addTask {
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                    print("Task is cancelled: \(Task.isCancelled)")
                }
//                注意：仅在addTask（）中抛出一个错误不足以导致组中的其他任务被取消——只有在使用next（）访问抛出任务的值或循环子任务时，才会发生这种情况。
                try await group.next()
            }
        } catch {
            print("Error thrown: \(error.localizedDescription)")
        }
    }
//    如果要避免将任务添加到已取消的组中，请改用addTaskUnlessCancelled（）方法
    //-----------------------------------
//    如何在TaskGroup中返回不同类型的返回值
//    通常情况应该首先考虑试用 async let
//    但是，如果需要使用任务组（例如，如果需要在循环中创建任务），那么有一个解决方案：创建一个包含相关值的枚举，该值封装要返回的基础数据。
    struct Message1: Decodable {
        let id: Int
        let from: String
        let message: String
    }

    // A user, containing their name, favorites list, and messages array.
    struct User1 {
        let username: String
        let favorites: Set<Int>
        let messages: [Message1]
    }

    // A single enum we'll be using for our tasks, each containing a different associated value.
    enum FetchResult {
        case username(String)
        case favorites(Set<Int>)
        case messages([Message1])
    }

    func loadUser() async {
        // Each of our tasks will return one FetchResult, and the whole group will send back a User.
        let user = await withThrowingTaskGroup(of: FetchResult.self) { group -> User1 in
            // Fetch our username string
            group.addTask {
                let url = URL(string: "https://hws.dev/username.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let result = String(decoding: data, as: UTF8.self)

                // Send back FetchResult.username, placing the string inside.
                return .username(result)
            }

            // Fetch our favorites set
            group.addTask {
                let url = URL(string: "https://hws.dev/user-favorites.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let result = try JSONDecoder().decode(Set<Int>.self, from: data)

                // Send back FetchResult.favorites, placing the set inside.
                return .favorites(result)
            }

            // Fetch our messages array
            group.addTask {
                let url = URL(string: "https://hws.dev/user-messages.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let result = try JSONDecoder().decode([Message1].self, from: data)

                // Send back FetchResult.messages, placing the message array inside
                return .messages(result)
            }

            // At this point we've started all our tasks,
            // so now we need to stitch them together into
            // a single User instance. First, we set
            // up some default values:
            var username = "Anonymous"
            var favorites = Set<Int>()
            var messages = [Message1]()

            // Now we read out each value, figure out
            // which case it represents, and copy its
            // associated value into the right variable.
            do {
                for try await value in group {
                    switch value {
                    case .username(let value):
                        username = value
                    case .favorites(let value):
                        favorites = value
                    case .messages(let value):
                        messages = value
                    }
                }
            } catch {
                // If any of the fetches went wrong, we might
                // at least have partial data we can send back.
                print("Fetch at least partially failed; sending back what we have so far. \(error.localizedDescription)")
            }

            // Send back our user, either filled with
            // default values or using the data we
            // fetched from the server.
            return User1(username: username, favorites: favorites, messages: messages)
        }

        // Now do something with the finished user data.
        print("User \(user.username) has \(user.messages.count) messages and \(user.favorites.count) favorites.")
    }
    //-----------------------------------
    // 任务本地变量
    enum User2 {
//        使用@TaskLocal属性包装器标记每个任务本地值。这些属性可以是您想要的任何类型，包括选项，但必须标记为static。
        @TaskLocal static var id = "Anonymous"
    }
    func User2Test() async {
//        Starting a new task-local scope using YourType.$yourProperty.withValue(someValue) { … }.
            Task {
                try await User2.$id.withValue("Piper") {
                    print("Start of task: \(User2.id)")
                    try await Task.sleep(nanoseconds: 1_000_000)
                    print("End of task: \(User2.id)")
                }
            }
            Task {
                try await User2.$id.withValue("Alex") {
                    print("Start of task: \(User2.id)")
                    try await Task.sleep(nanoseconds: 1_000_000)
                    print("End of task: \(User2.id)")
                }
            }
            print("Outside of tasks: \(User2.id)")
        }
    // 日志器案例
    enum LogLevel: Comparable {
        case debug, info, warn, error, fatal
    }

    struct Logger {
        // The log level for an individual task
        @TaskLocal static var logLevel = LogLevel.info

        // Make this struct a singleton
        private init() { }
        static let shared = Logger()

        // Print out a message only if it meets or exceeds our log level.
        func write(_ message: String, level: LogLevel) {
            if level >= Logger.logLevel {
                print(message)
            }
        }
    }
    // Returns data from a URL, writing log messages along the way.
    static func fetch(url urlString: String) async throws -> String? {
        Logger.shared.write("Preparing request: \(urlString)", level: .debug)

        if let url = URL(string: urlString) {
            let (data, _) = try await URLSession.shared.data(from: url)
            Logger.shared.write("Received \(data.count) bytes", level: .info)
            return String(decoding: data, as: UTF8.self)
        } else {
            Logger.shared.write("URL \(urlString) is invalid", level: .error)
            return nil
        }
    }

    // Starts a couple of fire-and-forget tasks with different log levels.
    static func LoggerTest() async throws {
        Task {
            try await Logger.$logLevel.withValue(.debug) {
                try await fetch(url: "https://hws.dev/news-1.json")
            }
        }

        Task {
            try await Logger.$logLevel.withValue(.error) {
                try await fetch(url: "https:\\hws.dev/news-1.json")
            }
        }
    }
    //-----------------------------------
//    actor
//    在概念上类似于可以在并发环境中安全使用的类
//    1.使用actor关键字创建actor。这是Swift中的一种具体的命名类型，如结构、类和枚举。
//    2.与类一样，actor也是引用类型
//    3.actor有许多与类相同的特性：actor可以有属性、方法、构造器、下标，可以实现协议，也可是泛型
//    4.actor不支持继承，所以不能有便利构造器，也不支持final或override
//    5.所有actor自动实现Actor协议
//    如果要在actor访问属性或者调用方法，必须使用await
    actor User3 {
        var score = 10

        func printScore() {
            print("My score is \(score)")
        }
        func copyScore(from other: User3) async {
//            我们试图从另一个用户那里读取分数，如果不将请求标记为wait，我们无法读取他们的分数属性
            score = await other.score
        }
    }
    let actor1 = User3()
    let actor2 = User3()
//    await print(actor1.score)
//    await actor1.copyScore(from: actor2)
    
//    无论是否await，都不允许从actor外部写入属性。
    actor URLCache {
        private var cache = [URL: Data]()

        func data(for url: URL) async throws -> Data {
            if let cached = cache[url] {
                return cached
            }

            let (data, _) = try await URLSession.shared.data(from: url)
            cache[url] = data
            return data
        }
    }
    static func URLCacheTest() async throws {
        let cache = URLCache()

        let url = URL(string: "https://apple.com")!
        let apple = try await cache.data(for: url)
        let dataString = String(decoding: apple, as: UTF8.self)
        print(dataString)
    }
//    记住actor的串行队列行为非常重要，因为完全有可能仅仅因为编写了actor而不是类，就在代码中创建了大量的减速。
    
    //防止资源竞争的例子
    actor BankAccount {
        var balance: Decimal

        init(initialBalance: Decimal) {
            balance = initialBalance
        }

        func deposit(amount: Decimal) {
            balance = balance + amount
        }

        func transfer(amount: Decimal, to other: BankAccount) async {
            // Check that we have enough money to pay
            guard balance > amount else { return }

            // Subtract it from our balance
            balance = balance - amount

            // Send it to the other account
            await other.deposit(amount: amount)
        }
    }

//    let firstAccount = BankAccount(initialBalance: 500)
//    let secondAccount = BankAccount(initialBalance: 0)
//    await firstAccount.transfer(amount: 500, to: secondAccount)
    //-----------------------------------
//    isolated的使用
//    使外部方法访问actor内部属性、方法时，不需要使用await
//    像这样使用isolated不会绕过actor的任何潜在安全性或实现——在任何时候，仍然只能有一个线程访问actor。我们所做的只是将访问权限向外推了一个级别
//    副作用是：现在调用debugLog需要使用await，即使它没有标记为async
    actor DataStore {
        var username = "Anonymous"
        var friends = [String]()
        var highScores = [Int]()
        var favorites = Set<Int>()

        init() {
            // load data here
        }

        func save() {
            // save data here
        }
    }

    func debugLog(dataStore: isolated DataStore) {
        print("Username: \(dataStore.username)")
        print("Friends: \(dataStore.friends)")
        print("High scores: \(dataStore.highScores)")
        print("Favorites: \(dataStore.favorites)")
    }

//    let data = DataStore()
//    await debugLog(dataStore: data)
    //-----------------------------------
//    nonisolated 的使用
    
    
    actor User4: Codable {
        let username: String
        let password: String
        var isOnline = false

        init(username: String, password: String) {
            self.username = username
            self.password = password
        }
        //标记为nonisolated，意味着可以不用await在外部调用
        nonisolated func passwordHash() -> String {
            let passwordData = Data(password.utf8)//非隔离的属性、方法，只能能在非隔离的属性、方法里访问，这里是常量
            let hash = SHA256.hash(data: passwordData)
            return hash.compactMap { String(format: "%02x", $0) }.joined()
        }
        
//        nonisolated在实现一些协议，例如Hashable和Codable时，非常有用
        enum CodingKeys: CodingKey {
            case username, password
        }
        nonisolated func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(username, forKey: .username)
            try container.encode(password, forKey: .password)
        }
    }

//    let user = User4(username: "twostraws", password: "s3kr1t")
//    print(user.passwordHash())
    //-----------------------------------
//    @MainActor 的使用
//    @MainActor 是使用主队列执行工作的全局actor
//    使用@MainActor 标记的方法、类型可以安全地修改UI，因为它始终在主队列运行，并调用MainActor.run()将自定义任务推给main actor
    @MainActor
    class AccountViewModel: ObservableObject {
        @Published var username = "Anonymous"
        @Published var isAuthenticated = false
    }
    
    func couldBeAnywhere() async {
        //如果当前已经在main actor上了，会立即执行
        await MainActor.run {
            print("This is on the main actor.")
        }
//        let result = await MainActor.run { () -> Int in
//            print("This is on the main actor.")
//            return 42
//        }
        //不想立即执行，可以套个Task
//        Task {
//            await MainActor.run {
//                print("This is on the main actor.")
//            }
//        }
        //或者
        Task { @MainActor in
            print("This is on the main actor.")
        }
    }
//    await couldBeAnywhere()
    //如果当前已经main actor上了，await MainActor.run()会立即执行不等待下一个运行循环，但是使用Task会等待
    
    
//    1，如果一个类被标记为@MainActor，那么它的所有子类也会自动标记为@MainActor。
//    2，如果类中的一个方法被标记为@MainActor，那么该方法的任何重写也会自动被标记为@MainActor。
//    3，任何使用@MainActor作为其包装值的属性包装的结构或类都将自动成为@MainActor。
//    4：如果协议将一个方法声明为@MainActor，则任何符合该协议的类型都会自动将该方法声明为@MainActor，除非您将一致性与该方法分离。

//    // A protocol with a single `@MainActor` method.
//    protocol DataStoring {
//        @MainActor func save()
//    }
//
//    // A struct that does not conform to the protocol.
//    struct DataStore1 { }
//
//    // When we make it conform and add save() at the same time, our method is implicitly @MainActor.
//    extension DataStore1: DataStoring {
//        func save() { } // This is automatically @MainActor.
//    }
//
//    // A struct that conforms to the protocol.
//    struct DataStore2: DataStoring { }
//
//    // If we later add the save() method, it will *not* be implicitly @MainActor so we need to mark it as such ourselves.
//    extension DataStore2 {
//        @MainActor func save() { }
//    }
    //    5：如果整个协议都用@MainActor标记，那么符合该协议的任何类型也将自动成为@MainActor，除非您将一致性与主类型声明分开放置，在这种情况下，只有方法是@MainActor。
    // A protocol marked as @MainActor.
//    @MainActor protocol DataStoring {
//        func save()
//    }
//
//    // A struct that conforms to DataStoring as part of its primary type definition.
//    struct DataStore1: DataStoring { // This struct is automatically @MainActor.
//        func save() { } // This method is automatically @MainActor.
//    }
//
//    // Another struct that conforms to DataStoring as part of its primary type definition.
//    struct DataStore2: DataStoring { } // This struct is automatically @MainActor.
//
//    // The method is provided in an extension, but it's the same as if it were in the primary type definition.
//    extension DataStore2 {
//        func save() { } // This method is automatically @MainActor.
//    }
//
//    // A third struct that does *not* conform to DataStoring in its primary type definition.
//    struct DataStore3 { } // This struct is not @MainActor.
//
//    // The conformance is added as an extension
//    extension DataStore3: DataStoring {
//        func save() { } // This method is automatically @MainActor.
//    }
    //-----------------------------------
    func random6() async -> Int {
        print("random6 : \(Thread.current)")
        return Int.random(in: 1...6)
    }
    
    var imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(imageView)
//        Task {
//            let val = await random6()
//            print("val : \(val) _ \(Thread.current)")
//        }
//        print("viewDidLoad : \(Thread.current)")
        
//        Task(priority: .background) {
//            async let a = factors(for: 1000000000)
//        }
        
        
        
//        DispatchQueue.global().async {
//            let number = 1000000000
//            var result = [Int]()
//            for check in 1...number {
//                if number.isMultiple(of: check) {
//                    result.append(check)
//                    print("find---\(check)")
//
//                }
//            }
//        }
        
        Task {
            if #available(iOS 15.0, *) {
//                try? await shoutQuotes()
//                await fetchUpdates()
//                async let a = factors(for: 1000000000)
//                await fetchNews()
//                await testCancellation()
//                await User2Test()

            } else {
                // Fallback on earlier versions
            }
        }
        
        for i in 1...10 {
            Task {
                if #available(iOS 15.0, *) {
                    await printCurrentThread(i)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        
        print("viewDidLoad end")
    }
    
    func printCurrentThread(_ index: Int) async -> Int {
        await withCheckedContinuation({ continuation in
            DispatchQueue.global().async {
                sleep(1)
                print("index: \(index)   \(Thread.current)")
                continuation.resume(returning: 0)
            }
        })
    }
    
    var asyncAction: () async -> Void = {
        do {
            try await Task.sleep(nanoseconds: 10_000_000_000)
        } catch {}
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Task {
            await asyncAction()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
