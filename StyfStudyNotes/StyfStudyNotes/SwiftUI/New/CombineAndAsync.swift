//
//  CombineAndAsync.swift
//
//
//  Created by styf on 2022/8/31.
//  聊聊 Combine 和 async/await 之间的合作  https://www.fatbobman.com/posts/combineAndAsync/

import SwiftUI
import Combine

struct CombineAndAsync: View {
    
    let example = CombineAndAsyncExample()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
//                example.example1()
//                example.example2()
//                example.example3()
                example.example4()
            }
    }
    
}

class CombineAndAsyncExample {
    var cancellables = Set<AnyCancellable>()
    
    func asyncPrint(value: String) async {
        print("hello \(value)")
        try? await Task.sleep(nanoseconds: 1000000000)
    }
    
    // ✅ 方案一  设定 flatMap 的 maxPublishers
    //flatMap maxPublishers
    func example1() {
        // 3个并发事件，被限制为串行
        ["abc","sdg","353","4","5","6"].publisher
            .task(maxPublishers:.max(1)){ value in
                await self.asyncPrint(value:value)//配合
            }
            .emptySink()
            .store(in: &cancellables)
    }
    // 更换成 PassthoughSubject 或 Notification ，会出现数据遗漏的情况
    func example2()  {
        let publisher = PassthroughSubject<String, Never>()
        publisher // 这个状况是因为我们限制了数据的并行处理数量，从而导致数据的消耗时间超过了数据的生成时间
            .buffer(size: 10, prefetch: .keepFull, whenFull: .dropOldest) // 缓存数量和策略根据业务的具体情况确定
            .task(maxPublishers: .max(1)) { value in
                await self.asyncPrint(value:value)
            }
            .emptySink()
            .store(in: &cancellables)

        publisher.send("fat")
        publisher.send("bob")
        publisher.send("man")
    }
    
    // ✅ 方案二  采用的自定义 Subscriber
    func example3() {
        let resumeNotification = Notification.Name("resume")

        ["abc","sdg","353","4","5","6"].publisher
            .buffer(size: 10, prefetch: .keepFull, whenFull: .dropOldest)
            .oneByOneSink(
                resumeNotification,
                receiveValue: { value in
                    Task {
                        await self.asyncPrint(value: value)
                        NotificationCenter.default.post(name: resumeNotification, object: nil)
                    }
                }
            )
            .store(in: &cancellables)
    }
     
    // ✅ 方案三 Notification的AsyncSequence
    func example4() {
        let n = Notification.Name("event")
        Task {
            for await value in NotificationCenter.default.notifications(named: n, object: nil) {
                if let str = value.object as? String {
                    await asyncPrint(value: str)
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            NotificationCenter.default.post(name: n, object: "event1")
            NotificationCenter.default.post(name: n, object: "event2")
            NotificationCenter.default.post(name: n, object: "event3")
            NotificationCenter.default.post(name: n, object: "event4")
        }
    }
    
    // 使用values 将 Publisher 转换成 AsyncSequence
    func example5() {
        let publisher = PassthroughSubject<String, Never>()
        let p = publisher
                .buffer(size: 10, prefetch: .keepFull, whenFull: .dropOldest)
        Task {
            for await value in p.values {
                await asyncPrint(value: value)
            }
        }
    }
}





struct CombineAndAsync_Previews: PreviewProvider {
    static var previews: some View {
        CombineAndAsync()
    }
}
