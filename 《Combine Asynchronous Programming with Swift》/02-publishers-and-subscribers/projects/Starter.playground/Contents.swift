import Foundation
import Combine
import _Concurrency

var subscriptions = Set<AnyCancellable>()

example(of: "Publisher") {
    // 1
    let myNotification = Notification.Name("MyNotification")
    // 2
    let publisher = NotificationCenter.default.publisher(for: myNotification, object: nil)
    // 3
    let center = NotificationCenter.default
    // 4
    let observer = center.addObserver(
      forName: myNotification,
      object: nil,
      queue: nil) { notification in
        print("Notification received!")
    }
    // 5
    center.post(name: myNotification, object: nil)
    // 6
    center.removeObserver(observer)
}

example(of: "Subscriber") {
    let myNotification = Notification.Name("MyNotification")
    let center = NotificationCenter.default
    let publisher = center.publisher(for: myNotification, object: nil)
    let subscription = publisher.sink { notification in
        print("Notification received from a publisher!")
    }
    
    center.post(name: myNotification, object: nil)
    subscription.cancel()
}

example(of: "Just") {
    // 1
    let just = Just("Hello world!")
    // 2
    _ = just
        .sink(
          receiveCompletion: {
            print("Received completion", $0)
          },
          receiveValue: {
            print("Received value", $0)
        })
}
// ✅ assign把订阅收到的值，分配到对象的属性
example(of: "assign(to:on:)") {
  // 1
  class SomeObject {
    var value: String = "" {
        didSet {
            print(value)
        }
    }
  }
  // 2
  let object = SomeObject()
  // 3
  let publisher = ["Hello", "world!"].publisher
  // 4
  _ = publisher
    .assign(to: \.value, on: object)
}
// ✅ 使用assign分配到另一个发布者，把收到的值重发布出去
// ⚠️ 这里的assign方法不会返回AnyCancellable，因为内部管理生命周期，@Published属性析构时会取消订阅
example(of: "assign(to:)") {
  // 1
  class SomeObject {
    @Published var value = 22
  }
  let object = SomeObject()
  // 2 使用带$的变量名，访问publisher
  object.$value
    .sink { print($0) }
  // 3
  (0..<10).publisher
    .assign(to: &object.$value)
    print("------\(object.value)")
    
    // ✅ 一个使用场景
    class MyObject {
      @Published var word: String = ""
      var subscriptions = Set<AnyCancellable>()
      init() {
        ["A", "B", "C"].publisher
          // ❌ 这种使用方式有循环引用 self->subscriptions->publisher->self
//          .assign(to: \.word, on: self)
//          .store(in: &subscriptions)
          // ✅
              .assign(to: &$word)
      }
    }
    
}

// ✅ 自定义订阅者
example(of: "Custom Subscriber") {
  // 1
  let publisher = (1...6).publisher
  // 2
  final class IntSubscriber: Subscriber {
    // 3
    typealias Input = Int
    typealias Failure = Never
    // 4 publisher会调用这个方法，提供一个subscription
    func receive(subscription: Subscription) {
      subscription.request(.max(3))//初始化的需求
    }
    // 5 publisher会调用这个方法，提供它刚刚发布的新值
    // 返回值是可以调整对后续需求的数量，这个值是累加的，如果返回.max(3),累加之前的就是6
    func receive(_ input: Int) -> Subscribers.Demand {
      print("Received value", input)
//      return .none
//        return .max(1)
        return .unlimited
    }
    // 6 publisher会调用这个方法，告诉订阅者它结束生产了或者产生错误了
    func receive(completion: Subscribers.Completion<Never>) {
      print("Received completion", completion)
    }
  }
    
    let subscriber = IntSubscriber()
    publisher.subscribe(subscriber)
}
// ✅ Future用于异步生产一个值
//example(of: "Future") {
//  func futureIncrement(
//    integer: Int,
//    afterDelay delay: TimeInterval) -> Future<Int, Never> {
//        Future<Int, Never> { promise in
//            // ✅ Future一创建就会立即执行，并不需要等待订阅
//            print("Original")
//          DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
//            promise(.success(integer + 1))
//          }
//        }
//  }
//
//
//    // 1
//    let future = futureIncrement(integer: 1, afterDelay: 3)
//    // 2
//    future
//      .sink(receiveCompletion: { print($0) },
//            receiveValue: { print($0) })
//      .store(in: &subscriptions)
//    // ✅ 第二次订阅并不会让Future执行第二次，Future会把值分享或重播给第二次的订阅者
//    future
//      .sink(receiveCompletion: { print("Second", $0) },
//            receiveValue: { print("Second", $0) })
//      .store(in: &subscriptions)
//}


example(of: "PassthroughSubject") {
  // 1
  enum MyError: Error {
      case test
  }
  // 2
  final class StringSubscriber: Subscriber {
    typealias Input = String
    typealias Failure = MyError
    func receive(subscription: Subscription) {
      subscription.request(.max(2))
    }
    func receive(_ input: String) -> Subscribers.Demand {
      print("Received value", input)
      // 3
      return input == "World" ? .max(1) : .none
    }
    func receive(completion: Subscribers.Completion<MyError>) {
      print("Received completion", completion)
    }
  }
    // 4
    let subscriber = StringSubscriber()
    
    // 5
    let subject = PassthroughSubject<String, MyError>()
    // 6
    subject.subscribe(subscriber)
    // 7
    let subscription = subject
      .sink(
        receiveCompletion: { completion in
          print("Received completion (sink)", completion)
        },
        receiveValue: { value in
          print("Received value (sink)", value)
        }
    )
    
    subject.send("Hello")
    subject.send("World")
    
    // 8 一个订阅取消后，只有另一个收到了
    subscription.cancel()
    // 9
    subject.send("Still there?")
    // ✅ 订阅者接收一个正常的完成或失败，都不会再接收值了
    subject.send(completion: .failure(MyError.test))
    // ✅ 完成后不再发布新值
    subject.send(completion: .finished)
    subject.send("How about another one?")
}

// ✅ 适合关心最新值
example(of: "CurrentValueSubject") {
  // 1
  var subscriptions = Set<AnyCancellable>()
  // 2
  let subject = CurrentValueSubject<Int, Never>(0)
  // 3
  subject
    .sink(receiveValue: { print($0) }) //✅ 新的订阅者会马上收到最近的值
    .store(in: &subscriptions) // 4
    
    subject.send(1)
    subject.send(2)
    
    // ✅ 不同于PassthroughSubject，CurrentValueSubject任何时候都可以访问当前的值
    print(subject.value)
    // ✅ 除了可以用send发布新值，也可以直接修改value属性
    subject.value = 3
    //✅ 新的订阅者会马上收到最近的值
    subject
//        .print()// ✅ 打印所有发布事件
      .sink(receiveValue: { print("Second subscription:", $0) })
      .store(in: &subscriptions)
    
    // ✅ 如何发布一个完成事件
    subject.send(completion: .finished)
}

// ✅ 动态调整需求数量
example(of: "Dynamically adjusting Demand") {
  final class IntSubscriber: Subscriber {
    typealias Input = Int
    typealias Failure = Never
      func receive(subscription: Subscription) {
        subscription.request(.max(2))
      }
      func receive(_ input: Int) -> Subscribers.Demand {
        print("Received value", input)
        switch input {
        case 1:
          return .max(2) // 1
        case 3:
          return .max(1) // 2
        default:
          return .none // 3
        }
      }
      func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion", completion)
      }
    }
    let subscriber = IntSubscriber()
    let subject = PassthroughSubject<Int, Never>()
    subject.subscribe(subscriber)
    subject.send(1)
    subject.send(2)
    subject.send(3)
    subject.send(4)
    subject.send(5)
    subject.send(6)
  }

/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
