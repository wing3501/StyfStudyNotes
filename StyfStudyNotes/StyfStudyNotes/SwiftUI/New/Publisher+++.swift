//
//  Publisher+++.swift
//  
//
//  Created by styf on 2022/8/31.
//

import Foundation
import Combine

public extension Publisher where Self.Failure == Never {
    func emptySink() -> AnyCancellable {
        sink(receiveValue: { _ in })
    }
}

// MARK: - 使用flatMap maxPublishers限制并发

public extension Publisher {
    func task<T>(maxPublishers: Subscribers.Demand = .unlimited,
                   _ transform: @escaping (Output) async -> T) -> Publishers.FlatMap<Deferred<Future<T, Never>>, Self> {
        //设定 flatMap 的 maxPublishers 限制数据的并发处理能力
        flatMap(maxPublishers: maxPublishers) { value in
            //        Future 在创建时立即发起其中异步 API 的调用，而不是 当它收到订阅需求时。 这可能不是你想要或需要的行为。
            //        如果你希望在订阅者请求数据时再发起调用，你可能需要用 Deferred 来包装 Future。
            Deferred {
                Future { promise in
                    Task {
                        let output = await transform(value)
                        promise(.success(output))
                    }
                }
            }
        }
    }
}

// MARK: - 使用flatMap maxPublishers限制并发

extension Subscribers {
    public class OneByOneSink<Input, Failure: Error>: Subscriber, Cancellable {
        let receiveValue: (Input) -> Void
        let receiveCompletion: (Subscribers.Completion<Failure>) -> Void

        var subscription: Subscription?
        var cancellable: AnyCancellable?

        public init(notificationName: Notification.Name,
                    receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
                    receiveValue: @escaping (Input) -> Void) {
            self.receiveCompletion = receiveCompletion
            self.receiveValue = receiveValue
            cancellable = NotificationCenter.default.publisher(for: notificationName, object: nil)
                .sink(receiveValue: { [weak self] _ in self?.resume() })
                // 在收到回调通知后，继续向 Publisher 申请新值
        }

        public func receive(subscription: Subscription) {
            self.subscription = subscription
            subscription.request(.max(1)) // 订阅时申请数据量
        }

        public func receive(_ input: Input) -> Subscribers.Demand {
            receiveValue(input)
            // ⚠️ 在receiveValue方法中使用 Task 调用 async/await 代码时会发现，由于没有提供回调机制，订阅者将无视异步代码执行完成与否，调用后直接会申请下一个值
            // return .max(1) // 数据处理结束后，再此申请的数据量
            return .none //✅ 修改为 调用函数后不继续申请新值
        }

        public func receive(completion: Subscribers.Completion<Failure>) {
            receiveCompletion(completion)
        }

        public func cancel() {
            subscription?.cancel()
            subscription = nil
        }
        
        private func resume() {
            subscription?.request(.max(1))
        }
    }
}

public extension Publisher {
    func oneByOneSink(
        _ notificationName: Notification.Name,
        receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
        receiveValue: @escaping (Output) -> Void
    ) -> Cancellable {
        let sink = Subscribers.OneByOneSink<Output, Failure>(
            notificationName: notificationName,
            receiveCompletion: receiveCompletion,
            receiveValue: receiveValue
        )
        self.subscribe(sink)
        return sink
    }
}

public extension Publisher where Failure == Never {
    func oneByOneSink(
        _ notificationName: Notification.Name,
        receiveValue: @escaping (Output) -> Void
    ) -> Cancellable where Failure == Never {
        let sink = Subscribers.OneByOneSink<Output, Failure>(
            notificationName: notificationName,
            receiveCompletion: { _ in },
            receiveValue: receiveValue
        )
        self.subscribe(sink)
        return sink
    }
}
