//
//  ConcurrencyViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/3/28.
//  https://www.hackingwithswift.com/quick-start/concurrency

import UIKit
import WebKit
import CoreLocation
import CoreLocationUI

extension URLSession {
    static let noCacheSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: config)
    }()
}

class ConcurrencyViewController: UIViewController {
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
    func random6() async -> Int {
        print("random6 : \(Thread.current)")
        return Int.random(in: 1...6)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
//        Task {
//            let val = await random6()
//            print("val : \(val) _ \(Thread.current)")
//        }
//        print("viewDidLoad : \(Thread.current)")
        
        Task {
            if #available(iOS 15.0, *) {
                try? await shoutQuotes()
            } else {
                // Fallback on earlier versions
            }
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
