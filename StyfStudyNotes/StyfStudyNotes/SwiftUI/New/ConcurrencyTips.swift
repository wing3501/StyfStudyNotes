//
//  ConcurrencyTips.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/11/9.
//  Swift Concurrency – Things They Don’t Tell You
// https://wojciechkulik.pl/ios/swift-concurrency-things-they-dont-tell-you
//
// 1. 给方法添加async关键词，确保做好以下准备
//  1.1 方法会被后台线程调用，除非使用@MainActor
//  1.2 actor的方法中await其他方法，而actor又被多次调用，可能引起"Actor 重入"。考虑await前后二次检查
//  1.3 await前后线程可能不同
// 2. Actor只保证两段代码不会同时运行，不会保证阻止数据竞争
// 3. 避免混用经典同步方法比如锁、信号量和swift并发
// 4. 设置Task的优先级，防止把所有任务派发到一个队列里
// 5. 真机测试异步代码
// 6. 不要在Task做耗时操作，用自定义DispatchQueue
// 7. 使用await Task.yield()允许更多地任务切换


import SwiftUI

struct ConcurrencyTips: View {
    let testClass = TestClass()
 
    var body: some View {
        VStack(spacing: 50) {
            // Tap next
            Button("Test UI action") {
                Task {
                    print("It works!")
                }
            }
            // To see a blocked UI issue - tap first
            Button("Start long-running Tasks") {
                (0..<20).forEach { _ in
                    Task {
                        await testClass.start()
                    }
                }
            }
            Button("Start improved long-running Tasks") {
                (0..<20).forEach { _ in
                    Task {
                        await testClass.startImproved()
                    }
                }
            }
            Button("Start long-running Tasks in background") {
                (0..<20).forEach { _ in
                    Task(priority: .background) {
                        await testClass.start()
                    }
                }
            }
            Button("Start long-running Tasks using DispatchQueue") {
                (0..<20).forEach { _ in
                    Task {
                        await testClass.startFixed()
                    }
                }
            }
        }
    }
    
    final class TestClass {
        private let queue = DispatchQueue(label: "heavy-work", attributes: .concurrent)
     
        func start() async {
            while true {
                longRunningWork(seconds: 1)
            }
        }
     
        func startImproved() async {
            while true {
                longRunningWork(seconds: 1)
                await Task.yield()
            }
        }
     
        func startFixed() async {
            await withCheckedContinuation { continuation in
                queue.async {
                    self.longRunningWork(seconds: 10)
                    continuation.resume(with: .success(()))
                }
            }
        }
     
        private func longRunningWork(seconds: Int) {
            usleep(useconds_t(seconds * 1_000_000))
        }
    }

}

struct ConcurrencyTips_Previews: PreviewProvider {
    static var previews: some View {
        ConcurrencyTips()
    }
}
