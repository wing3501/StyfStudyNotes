import UIKit
import Combine

//Empty 是一个最简单的发布者，它只在被订阅的时候发布一个完成事件 (receive finished)。这个 publisher 不会输出任何的 output 值，只能用于表示某个事件已经 发生。
check("Empty") {
    Empty<Int,SampleError>()
}
//如果我们想要 publisher 在完成之前发出一个值的话，可以使用 Just，它表示一个 单一的值，在被订阅后，这个值会被发送出去，紧接着是 finished
check("Just") {
    Just(1)
}

check("Sequence") {
//    Publishers.Sequence<[Int],Never>(sequence: [1,2,3])
    [1,2,3].publisher
}

check("Map") {
    [1,2,3].publisher.map { a in
        a * 2
    }
}

check("Map Just") {
    Just(5)
        .map { $0 * 2}
}

check("Reduce") {
    [1,2,3,4,5].publisher.reduce(0, +)
}
//有些情况下，除了最终的结果，我们也有可能会想要把中途的过程保存下来。在 Array 中，这种操作一般叫做 scan。
check("Scan") {
    [1,2,3,4,5].publisher.scan(0, +)
}

//compactMap 比较简单，它的作用是将 map 结果中那些 nil 的元素去除掉，这个操
//作通常会 “压缩” 结果，让其中的元素数减少，这也正是其名字中 compact 的来源
check("Compact Map") {
    ["1", "2", "3", "cat", "5"].publisher.compactMap { Int($0) }
}

check("Compact Map By Filter") {
    ["1", "2", "3", "cat", "5"]
        .publisher
        .map { Int($0) }
        .filter { $0 != nil }
        .map { $0! }
}

//map 及 compactMap 的闭包返回值是单个的 Output 值。而与它们不同，flatMap 的变形闭包里需要返回 一个 Publisher。
//flatMap 将会涉及两个 Publisher:一个是 flatMap 操 作本身所作用的外层 Publisher，一个是 flatMap 所接受的变形闭包中返回的内层 Publisher。
//外层 Publisher 提供数据，内层 Publisher 提供变形方式并控制输出。
check("Flat Map 1") {
    [[1,2,3],["a","b","c"]]
        .publisher
        .flatMap { $0.publisher } //内层 Publisher 实际上是 [1, 2, 3].publisher 和 ["a", "b", "c"].publisher
}

check("Flat Map 2") {
    ["A","B","C"]
        .publisher
        .flatMap { letter in
            [1,2,3]
                .publisher
                .map { "\(letter)\($0)" }
        }
}

check("Remove Duplicates") {
    ["S", "Sw", "Sw", "Sw", "Swi",
      "Swif", "Swift", "Swift", "Swif"]
        .publisher
        .removeDuplicates()
}
//Combine 中提供了 Fail 这个内建的基础 Publisher，它所做的事情就是在被订阅时 发送一个错误事件
check("Fail") {
    Fail<Int, SampleError>(error: .sampleError)
}

//我们可以通过使用 mapError 来将 Publisher 的 Failure 转换成 Subscriber 所需要的 Failure 类型
enum MyError: Error {
    case myError
}
check("Map Error") {
    Fail<Int,SampleError>(error: .sampleError)
        .mapError { _ in
            MyError.myError
        }
}
//使用 tryMap 我们就可以将这类处理数据时发生的错误转变为标志事件流失败的结束事 件
check("Throw") {
    ["1", "2", "Swift", "4"]
        .publisher
        .tryMap { s in
//            guard let value = Int(s) else {
//                //当问题发生时，我们 抛出了一个自定义的 myError 错误。这导致整个事件流以错误结果终止，接下来的 “4” 也不再会被计算和发布。
//                throw MyError.myError
//            }
//            return value
        }
}

//replaceError，它会把错误替换成一个给定的值，并且立即发送 finished 事件
//replaceError 会将 Publisher 的 Failure 类型抹为 Never，这正是我们使用 assign 来将 Publisher 绑定到 UI 上时所需要的 Failure 类型
check("Replace Error") {
    ["1", "2", "Swift", "4"]
        .publisher
        .tryMap { s in
            guard let value = Int(s) else {
                throw MyError.myError
            }
            return value
        }
        .replaceError(with: -1)
}

//replaceError 在错误时接受单个值，另一个操作 catch 则略有不同，它接受的是一 个新的 Publisher，当上游 Publisher 发生错误时，catch 操作会使用新的 Publisher 来把原来的 Publisher 替换掉。
check("Catch with Just") {
    ["1", "2", "Swift", "4"]
        .publisher
        .tryMap { s in
            guard let value = Int(s) else {
                throw MyError.myError
            }
            return value
        }
        .catch { _ in
//            实际上，任何满足 Output == Int 和 Failure == Never 的 Publisher 都可以作为 catch 的闭包被返回， 并替代原来的 Publisher
            Just(-1)
        }
}

check("Catch with Another Publisher")  {
    ["1", "2", "Swift", "4"]
        .publisher
        .tryMap { s in
            guard let value = Int(s) else {
                throw MyError.myError
            }
            return value
        }
        .catch { _ in
            [-1,-2,-3].publisher
        }
}

check("Catch and Continue") {
    ["1", "2", "Swift", "4"]
        .publisher
        .flatMap { s in
            return Just(s)
                .tryMap { s in
                    guard let value = Int(s) else {
                        throw MyError.myError
                    }
                    return value
                }
                .catch { _ in
                    Just(-1)
                }
        }
}

//let p1_ = Publishers.FlatMap(upstream: [[1, 2, 3], [4, 5, 6]].publisher,
//                             maxPublishers: .unlimited)
//                           {
//                             $0.publisher
//                           })
//let p2_ = Publishers.Map(upstream: p1_) { $0 * 2 }
//
//let p3 = p2_.eraseToAnyPublisher()

check("Contains") {
    [1,2,3,4,5].publisher
      .print("[Original]")
      .contains(3)
}

check("prefix") {
    [1,2,3,4,5].publisher
        .prefix(2)
}

check("drop") {
    [1,2,3,4,5].publisher
        .drop { a in
            a != 3
        }
        
}

check("replaceNil") {
    ["1", "2", "Swift", "4"]
        .publisher
        .map { Int($0)}
        .replaceNil(with: 33)
}

check("replaceEmpty") {
    []
        .publisher
        .replaceEmpty(with: 11)
}

check("max") {
    [11,2,23,4,5].publisher
        .max()
}

check("allSatisfy") {
    [11,2,23,4,5].publisher
        .allSatisfy { aa in
            aa > 0
        }
}

check("collect") {
    [11,2,23,4,5].publisher
        .collect()
}

//let s1 = check("Subject") {
//    () -> PassthroughSubject<Int, Never> in
//    let subject = PassthroughSubject<Int,Never>()
//    delay(1) {
//        subject.send(1)
//        delay(1) {
//            subject.send(2)
//            delay(1) {
//                subject.send(completion: .finished)
//            }
//        }
//    }
//    return subject
//}

let subject_example1 = PassthroughSubject<Int, Never>()
let subject_example2 = PassthroughSubject<Int, Never>()
check("Subject Order") {
  subject_example1.merge(with: subject_example2)
}
subject_example1.send(20)
subject_example2.send(1)
subject_example1.send(40)
subject_example1.send(60)
subject_example2.send(1)
subject_example1.send(80)
subject_example1.send(100)
subject_example1.send(completion: .finished)
subject_example2.send(completion: .finished)

//Zip 它会把两个 (或多个) Publisher 事 件序列中在同一 index 位置上的值进行合并
//zip 在时序语义上更接近于 “当...且...”，当 Publisher1 发布值，且 Publisher2 发布 值时，将两个值合并，作为新的事件发布出去。
//在实践中，zip 经常被用在合并多个 异步事件的结果，比如同时发出了多个网络请求，希望在它们全部完成的时候把结 果合并在一起。
let subject1 = PassthroughSubject<Int, Never>()
let subject2 = PassthroughSubject<String, Never>()
check("Zip") {
  subject1.zip(subject2)
}
subject1.send(1)
subject2.send("A")
subject1.send(2)
subject2.send("B")
subject2.send("C")
subject2.send("D")
subject1.send(3)
subject1.send(4)
subject1.send(5)//最后 5 在 Publisher2 里并没有对应位置的 Output 事件，因此它被最终的 Publisher 忽略了

//combineLatest 和 zip 相反，它的语义接近于 “当...或...”，当 Publisher1 发布 值，或者 Publisher2 发布值时，将两个值合并，作为新的事件发布出去。
let subject3 = PassthroughSubject<String, Never>()
let subject4 = PassthroughSubject<String, Never>()
check("Combine Latest") {
  subject3.combineLatest(subject4)
}
subject3.send("1")
subject4.send("A")
subject3.send("2")
subject4.send("B")
subject4.send("C")
subject4.send("D")
subject3.send("3")
subject3.send("4")
subject3.send("5")

func loadPage(url: URL,handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        handler(data,response,error)
    }.resume()
}

//Future 提供了一种方式，可以让我们创建一个接受未来的事件的 Publisher
//let future = check("Future") {
//    Future<(Data,URLResponse), Error> {
//        promise in
//        loadPage(url: URL(string: "https://example.com")!) { data, response, error in
//            if let data = data,let response = response {
//                promise(.success((data,response)))
//            }else {
//                promise(.failure(error!))
//            }
//        }
//    }
//}

//使用Subject
//包装通知
//var observer: NSObjectProtocol?
//let subject = PassthroughSubject<(), Never>()
//observer = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil,queue: .main)
//{ _ in subject.send() }

//包装定时器
//let subject = PassthroughSubject<Date, Never>()
//Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//  subject.send(Date())
//}
//let timer = check("Timer") { subject }


//Foundation 中的 Publisher
//URLSession Publisher
struct Response: Decodable {
    struct Args: Decodable {
        let foo: String
    }
    let args: Args?
}

//check("URL Session") {
//    URLSession.shared.dataTaskPublisher(for: URL(string: "https://httpbin.org/get?foo=bar")!)
//        .map { data,_ in
//            data
//        }
//        .decode(type: Response.self, decoder: JSONDecoder())
//        .compactMap { $0.args?.foo }
//}


//Timer Publisher
let timer = Timer.publish(every: 1, on: .main, in: .default)
check("Timer Connected") {
    timer
}
//Timer.TimerPublisher 是一个满足 ConnectablePublisher 的类型。ConnectablePublisher 不同于普通的 Publisher， 你需要明确地调用 connect() 方法，它才会开始发送事件
timer.connect()
//connect() 会返回一个 Cancellable 值，我们需要在合适的时候调用 cancel() 来停止事件流并释放资源。
//对 于 普 通 的Publisher， 当Failure是Never时， 就 可 以 使 用 makeConnectable() 将它包装为一个 ConnectablePublisher。这会使得该 Publisher 在等到连接 (调用 connect()) 后才开始执行和发布事件。在某些
//情况下，如果我们希望延迟及控制 Publisher 的开始时间，可以使用这个方 法。
//对 ConnectablePublisher 的 对 象 施 加 autoconnect() 的 话， 可 以 让 这 个 ConnectablePublisher “恢复” 为被订阅时自动连接。

//Notification Publisher
//NotificationCenter.Publisher

//@Published
class Wrapper {
    @Published var text: String = "hoho"
}

var wrapper = Wrapper()
check("Published") {
    wrapper.$text
}
wrapper.text = "123"
wrapper.text = "abc"

//通过 assign 绑定 Publisher 值

class Clock {
    var timeString: String = "--:--:--" {
        didSet {
            print("\(timeString)")
        }
    }
}

let clock = Clock()
let formatter = DateFormatter()
formatter.timeStyle = .medium

//let timer1 = Timer.publish(every: 1, on: .main, in: .default)
//var token = timer1.map { formatter.string(from: $0) }
//    .assign(to: \.timeString, on: clock)
//timer1.connect()

//Publisher 的引用共享
class LoadingUI {
    var isSuccess: Bool = false
    var text: String = ""
}
//dataTaskPublisher 是 struct，它遵循值语义 (value semantics)。在变形的时候，
//负责网络请求的 Publisher 将被复制一份。这样一来，最后使用 assign 操作 isSuccess 和 latestText 时，最终订阅的是两个不同的 Publisher，因此网络请求也 发生了两次。
let dataTaskPublisher = URLSession.shared .dataTaskPublisher(for: URL(string: "https://httpbin.org/get?foo=bar")!)
    .share()//通过 share() 操作，原来的 Publisher 将被包装在 class 内，对它的进一步变形也会 适用引用语义
let isSuccess = dataTaskPublisher.map { data,response in
    guard let httpsRes = response as? HTTPURLResponse else {
        return false
    }
    return httpsRes.statusCode == 200
}
.replaceError(with: false)
let latestText = dataTaskPublisher.map { data,_ in
    data
}
.decode(type: Response.self, decoder: JSONDecoder())
.compactMap { $0.args?.foo }
.replaceError(with: "")

let ui = LoadingUI()
var token1 = isSuccess.assign(to: \.isSuccess, on: ui)
var token2 = latestText.assign(to: \.text, on: ui)


//对于一般的 Cancellable，例如 connect 的返回 值，我们需要显式地调用 cancel() 来停止活动，但 AnyCancellable 则在自己的 deinit 中帮我们做了这件事。换句话说，当 sink 或 assign 返回的 AnyCancellable 被释放时，它对应的订阅操作也将停止。

//内存管理规则
//1.对于需要 connect 的 Publisher，在 connect 后需要保存返回的 Cancellable，并在合适的时候调用 cancel() 以结束事件的持续发布。
//2.对于 sink 或 assign 的返回值，一般将其存储在实例的变量中，等待属性持有 者被释放时一同自动取消。不过，你也完全可以在不需要时提前释放这个变量 或者明确地调用 cancel() 以取消绑定。
//3.对于 1 的情况，也完全可以将 Cancellable 作为参数传递给 AnyCancellable 的初始化方法，将它包装成为一个可以自动取消的对象。这样一来，1 将被转 换为 2 的情况。


//debounce 防抖：Publisher 在接收到第一个值后，并不是立即将它发布出 去，而是会开启一个内部计时器，当一定时间内没有新的事件来到，再将这个值进行 发布。如果在计时期间有新的事件，则重置计时器并重复上述等待过程。
let searchText = PassthroughSubject<String,Never>()

check("Debounce") {
    searchText.debounce(for: .seconds(1), scheduler: RunLoop.main)
}
delay(0) { searchText.send("S") }
delay(0.1) { searchText.send("Sw") }
delay(0.2) { searchText.send("Swi") }
delay(1.3) { searchText.send("Swif") }
delay(1.4) { searchText.send("Swift") }


//throttle 防抖：它在收到一个事件后开始计时，并忽略计时 周期内的后续输入。
