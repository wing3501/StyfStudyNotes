//
//  CombineViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/2.
//  https://heckj.github.io/swiftui-notes/index_zh-CN.html

import UIKit
import Combine
import Contacts
import SwiftUI

class CombineViewController: UIViewController {

    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
        tf.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        tf.backgroundColor = UIColor.yellow
        return tf
    }()
    
    @objc func textChanged(_ sender: UITextField) {
        username = sender.text ?? ""
        print("Set username to ",username)
    }
    
    lazy var label: UILabel = {
        let l = UILabel(frame: CGRect(x: 50, y: 200, width: 200, height: 50))
        l.backgroundColor = UIColor.yellow
        return l
    }()
    //如果发布者 $username 有任何订阅者，它反过来就会触发数据流更新
    @Published var username: String = ""
    var username1 = ""
    
    var usernameSubscriber: AnyCancellable?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //            let vc = GithubViewController()
        //            let vc = FormViewController()
//                    let vc = HeadingViewController()
//                    let vc = NotificationViewController()
        let vc = UIHostingController(rootView: ReactiveForm(model: ReactiveFormModel()))
                    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        //--------------------
        
        view.addSubview(textField)
        view.addSubview(label)
        
        //------------------------------------
        //一个与UIKit协作的例子
//        在发布者 $username 上设置了一个订阅者，以触发进一步的行为
        usernameSubscriber = $username.throttle(for: 0.5, scheduler: DispatchQueue.global(), latest: true)
//        throttle 在这里是防止每编辑一次 UITextField 都触发一个网络请求。 throttle 操作符保证了每半秒最多可发出 1 个请求。
            .removeDuplicates()
//        removeDuplicates 移除重复的更改用户名事件，以便不会连续两次对相同的值发起 API 请求。 如果用户结束编辑时返回的是之前的值，removeDuplicates 可防止发起冗余请求。
            .map({ username -> AnyPublisher<String?,Never> in
                let name: String? = username + "123"
                return Just(name).eraseToAnyPublisher()
            })
            .switchToLatest()
//        switchToLatest 操作符接收发布者实例并解析其中的数据。
            .receive(on: RunLoop.main)
//            .assign(to: \.username1, on: self)
//            .eraseToAnyPublisher()
            .assign(to: \.text, on: label)
//            .sink(receiveValue: { text in
//                self.label.text = text
//            })
        //------------------------------------
//        flatMapcatchTest()
//        retryTest()
//        catchTest()
//        sortAsyncTest()
//        flatmapTest()
//        futureTest()
//        requestJson1()
//        requestJson()
//        assignTest()
//        publisher()
//        sinkTest()
    }
    //------------------------------------
//    网络受限时从备用 URL 请求数据
    func adaptiveLoader(regularURL: URL, lowDataURL: URL) -> AnyPublisher<Data, Error> {
        var request = URLRequest(url: regularURL)
        request.allowsConstrainedNetworkAccess = false  //设置 request.allowsConstrainedNetworkAccess 将导致 dataTaskPublisher 在网络受限时返回错误。
        return URLSession.shared.dataTaskPublisher(for: request)
        .tryCatch { error -> URLSession.DataTaskPublisher in //tryCatch 用于捕获当前的错误状态并检查特定错误（受限的网络）。
            guard error.networkUnavailableReason == .constrained else {
                throw error
            }
            return URLSession.shared.dataTaskPublisher(for: lowDataURL)
        }.tryMap { data,response -> Data in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                throw MyNetworkingError.invalidServerResponse
                throw APIError.unknown
            }
            return data
        }.eraseToAnyPublisher()
    }
    //------------------------------------
//    使用 flatMap 和 catch 在不取消管道的情况下处理错误
    func flatMapcatchTest() {
        remoteDataPublisher1 = Just(myURL!)
            .flatMap { url in
//                你提供一个闭包给 flatMap，该闭包可以获取所传入的值，并创建一个一次性的发布者，完成可能失败的工作。
                URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response -> Data in
                    guard let httpResponse = response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                            throw TestFailureCondition.invalidServerResponse
                    }
                    return data
                }
                .decode(type: PostmanEchoTimeStampCheckResponse.self, decoder: JSONDecoder())
                .catch {_ in
                    return Just(PostmanEchoTimeStampCheckResponse(valid: false))
                }
            }
            .eraseToAnyPublisher()
            .sink { checkResponse in
                print("result:",checkResponse)
            }
    }
    
    //------------------------------------
//    在发生暂时失败时重试
    var remoteDataPublisher2:AnyPublisher<PostmanEchoTimeStampCheckResponse, Error>?
    func retryTest() {
        remoteDataPublisher2 = URLSession.shared.dataTaskPublisher(for: myURL!)
            .delay(for: DispatchQueue.SchedulerTimeType.Stride(integerLiteral: 3), scheduler: DispatchQueue.global())//通过在管道中添加延迟，即使原始请求成功，重试也始终会发生。
            .retry(3)
            .print()
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw TestFailureCondition.invalidServerResponse
                }
                return data
            }
            .decode(type: PostmanEchoTimeStampCheckResponse.self, decoder: JSONDecoder())
            .subscribe(on: DispatchQueue.global())
            .eraseToAnyPublisher()
        
        
        remoteDataPublisher2?.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let anError):
                print("received error: ", anError)
            }
        }, receiveValue: { someValue in
            print("value:",someValue.valid,Thread.current)
        })

    }
    
    //------------------------------------
//    使用 catch 处理一次性管道中的错误
    struct IPInfo: Codable {
        var ip: String
    }
    let myURL1 = URL(string: "http://ip.jsontest.com")
    var remoteDataPublisher1: AnyCancellable?
    func catchTest() {
        remoteDataPublisher1 = URLSession.shared.dataTaskPublisher(for: myURL1!)
            // the dataTaskPublisher output combination is (data: Data, response: URLResponse)
            .map({ (inputTuple) -> Data in
                return inputTuple.data
            })
            .decode(type: IPInfo.self, decoder: JSONDecoder())
            .catch { err in
//                catch 处理错误的方式，是将上游发布者替换为另一个发布者，这是你在闭包中用返回值提供的。
//                catch 操作符将被放置在几个可能失败的操作符之后，以便在之前任何可能的操作失败时提供回退或默认值
                return Just(IPInfo(ip: "8.8.8.8"))
            }
            .eraseToAnyPublisher()
            .sink(receiveValue: { ipinfo in
                print("ipinfo:",ipinfo.ip)
            })
        
        
    }
    
    //------------------------------------
//    使用 Combine 的管道来显式地对异步操作进行排序
    func createFuturePublisher(index: Int) -> AnyPublisher<Int, Error> {
            return Future<Int, Error> { promise in
                DispatchQueue.global(qos: .background).async {
                    sleep(.random(in: 1...4))
                    print("promise",index)
                    promise(.success(index))
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    var cancellable: AnyCancellable?
    func sortAsyncTest() {
//        步骤 1 先运行。
//        步骤 2 有三个并行的任务，在步骤 1 完成之后运行。
//        步骤 3 等步骤 2 的三个任务全部完成之后，再开始执行。
//        步骤 4 在步骤 3 完成之后开始执行。
        var coordinatedPipeline = createFuturePublisher(index: 1)
            .flatMap { flatMapInValue -> AnyPublisher<Int, Error> in
                print("flatMapInValue:",flatMapInValue)
//                如果你想强制一个 Future 发布者直到另一个发布者完成之后才被调用，你可以把 future 发布者创建在 flatMap 的闭包中，这样它就会等待有值被传入 flatMap 操作符之后才会被创建。
                let p2 = self.createFuturePublisher(index: 2)
                let p3 = self.createFuturePublisher(index: 3)
                let p4 = self.createFuturePublisher(index: 4)
                return Publishers.Zip3(p2, p3, p4).map { tuple in
                    return tuple.0 + tuple.1 + tuple.2
                }.eraseToAnyPublisher()
            }
            .flatMap { flatMapInValue -> AnyPublisher<Int, Error> in
                print("a:",flatMapInValue)
                return self.createFuturePublisher(index: 5)
            }
            .flatMap { _ in
                return self.createFuturePublisher(index: 6)
            }
            .eraseToAnyPublisher()
        
        
        
        cancellable = coordinatedPipeline.sink(receiveCompletion: { comletion in
            
        }, receiveValue: { val in
            print("receiveValue:",val)
        })
    }
    
    //------------------------------------
    //    flatMap 能将多个发布者的值打平发送给订阅者
    struct PersonS {
        let p: AnyPublisher<String, Never>
    }
    func flatmapTest() {
        let p1 = PersonS(p: Just("one").eraseToAnyPublisher())
        let p2 = PersonS(p: Just("two").eraseToAnyPublisher())
        let p3 = PersonS(p: Just("three").eraseToAnyPublisher())
        let pb = [p1,p2,p3].publisher
//        pb.sink { <#PersonS#> in
//            <#code#>
//        }
        pb.flatMap { personS in
            personS.p
        }.sink { string in
            print(string)
        }
    }
    //------------------------------------
//    用 Future 来封装异步请求以创建一次性的发布者
//    使用 Future 将异步请求转换为发布者，以便在 Combine 管道中使用返回结果。
    func futureTest() {
//        Future 在创建时立即发起其中异步 API 的调用，而不是 当它收到订阅需求时。 这可能不是你想要或需要的行为。
//        如果你希望在订阅者请求数据时再发起调用，你可能需要用 Deferred 来包装 Future。
        let futureAsyncPublisher = Future<Bool, Error> { promise in
            CNContactStore().requestAccess(for: .contacts) { grantedAccess, err in
                // err is an optional
                if let err = err {
                    return promise(.failure(err))
                }
                return promise(.success(grantedAccess))
            }
        }.eraseToAnyPublisher()
        
    }
    //------------------------------------
    class Person {
        var name: String
        var age: Int
        init(name: String,age: Int) {
            self.name = name
            self.age = age
        }
    }
    //------------------------------------
//    标准化 dataTaskPublisher 返回的错误
    enum APIError: Error, LocalizedError {
        case unknown, apiError(reason: String), parserError(reason: String), networkError(from: URLError)
        var errorDescription: String? {
                switch self {
                case .unknown:
                    return "Unknown error"
                case .apiError(let reason), .parserError(let reason):
                    return reason
                case .networkError(let from):
                    return from.localizedDescription
                }
            }
        }
        
    func fetch(url: URL) -> AnyPublisher<Data, APIError> {
        let request = URLRequest(url: url)

        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                if (httpResponse.statusCode == 401) {
                    throw APIError.apiError(reason: "Unauthorized");
                }
                if (httpResponse.statusCode == 403) {
                    throw APIError.apiError(reason: "Resource forbidden");
                }
                if (httpResponse.statusCode == 404) {
                    throw APIError.apiError(reason: "Resource not found");
                }
                if (405..<500 ~= httpResponse.statusCode) {
                    throw APIError.apiError(reason: "client error");
                }
                if (500..<600 ~= httpResponse.statusCode) {
                    throw APIError.apiError(reason: "server error");
                }
                return data
            }
            .mapError { error in
//                我们使用 mapError 将任何其他不可忽视的错误类型转换为通用的错误类型 APIError
                // if it's our kind of error already, we can return it directly
                if let error = error as? APIError {
                    return error
                }
                // if it is a TestExampleError, convert it into our new error type
//                if error is TestExampleError {
//                    return APIError.parserError(reason: "Our example error")
//                }
                // if it is a URLError, we can convert it into our more general error kind
                if let urlerror = error as? URLError {
                    return APIError.networkError(from: urlerror)
                }
                // if all else fails, return the unknown error condition
                return APIError.unknown
            }
            .eraseToAnyPublisher()
    }
    //------------------------------------
//    一个常见的用例是从 URL 请求 JSON 数据并解码
    let myURL = URL(string: "https://postman-echo.com/time/valid?timestamp=2016-10-10")
    
    var cancellableSink: AnyCancellable?
    struct PostmanEchoTimeStampCheckResponse: Decodable,Hashable {
        let valid: Bool
    }
    func requestJson() {
        let remoteDataPublisher = URLSession.shared.dataTaskPublisher(for: myURL!)
            .map { $0.data }
            .decode(type: PostmanEchoTimeStampCheckResponse.self, decoder: JSONDecoder())
        
        cancellableSink = remoteDataPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err)
                }
            } receiveValue: { model in
                print(model.valid)
            }
        
        print("end")
    }
    //------------------------------------
    //使用 dataTaskPublisher 进行更严格的请求处理
    enum TestFailureCondition: Error {
        case invalidServerResponse
    }
    func requestJson1() {
        let remoteDataPublisher = URLSession.shared.dataTaskPublisher(for: myURL!)
            .tryMap { data, response -> Data in
//                tryMap 接受任何输入和失败类型，并允许输出任何类型，但始终会输出 <Error> 的失败类型
//                tryMap 仍旧获得元组 (data: Data, response: URLResponse)，并且在这里定义仅返回管道中的 Data 类型
                        guard let httpResponse = response as? HTTPURLResponse,
                            httpResponse.statusCode == 200 else {
                                throw TestFailureCondition.invalidServerResponse
                        }
                        return data
            }
            .decode(type: PostmanEchoTimeStampCheckResponse.self, decoder: JSONDecoder())
        
        cancellableSink = remoteDataPublisher
            .sink(receiveCompletion: { completion in
                    print(".sink() received the completion", String(describing: completion))
                    switch completion {
                        case .finished:
                            break
                        case .failure(let anError):
                            print("received error: ", anError)
                    }
            }, receiveValue: { someValue in
                print(".sink() received \(someValue)")
            })
    }
    
//    Assign 是专门设计用于将来自发布者或管道的数据应用到属性的订阅者
    func assignTest() {
        let p = Person(name: "Jack", age: 18)
        let name = "这是一个标题"
        let age = [11]
        age.publisher.assign(to: \.age, on: p)
        
        [name].publisher.receive(on: RunLoop.main).assign(to: \.title, on: self)
        
        print(p.age)
    }
    //------------------------------------
    //要接收来自发布者或管道生成的输出以及错误或者完成消息，你可以使用 sink 创建一个订阅者。
    func sinkTest() {
        var set = Set<AnyCancellable>()
        let pb = Just(Person(name: "Jack", age: 18))
        pb.print("✅")
            .sink { p in
                print("sink \(p.name)")
            }.store(in: &set)
        print(set.count)
        
        let cancellablePipeline = Just(Person(name: "Tom", age: 11)).sink { completion in
            switch completion {
            case .finished:
                print("正常")
                break
            case .failure(let anError):
                print("出错了 ",anError)
            }
        } receiveValue: { person in
            print(person.name,person.age)
        }

        cancellablePipeline.cancel()
    }
    //------------------------------------
    func publisher() {
        var set = Set<AnyCancellable>()
        [Person(name: "Jack", age: 18),Person(name: "Tom", age: 18)]
            .publisher
            .print("✅")
            .sink { person in
                print("person---\(person.name)")
            }
            .store(in: &set)
    }
    //------------------------------------
//    暴露简化类型
    func test1() {
        let xx = PassthroughSubject<String, Never>()
            .flatMap { name in
                return Future<String, Error> { promise in
                    promise(.success(""))
                    }.catch { _ in
                        Just("No user found")
                    }.map { result in
                        return "\(result) foo"
                    }.receive(on: RunLoop.main)//线程调度
        }.eraseToAnyPublisher()
        
    }
}
