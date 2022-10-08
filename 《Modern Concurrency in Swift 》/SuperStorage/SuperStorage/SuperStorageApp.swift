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
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

// ✅ async/await的几种用法
// 1 基本使用
//func myFunction() async throws -> String {
//    ...
//}
//let myVar = try await myFunction()

// 2 异步属性
//var myProperty: String {
//  get async {
//    ...
//  }
//}
//print(await myProperty)

// 3 异步闭包
//func myFunction(worker: (Int) async -> Int) -> Int {
//  ...
//}
//myFunction {
//  return await computeNumbers($0)
//}

// ✅ Task API
// 1. Task(priority:operation) 按给定优先级，安排异步执行。从当前同步上下文继承默认值。（当你的代码在主线程创建一个Task,Task也会运行在主线程）
// 2. Task.detached(priority:operation) 同上，除了不继承
// 3. Task.value 类似一个任务值的promise
// 4. Task.isCancelled 从上一个暂停点到现在是否任务被取消了。
// 5. Task.checkCancellation() 如果任务被取消了，抛出一个CancellationError
// 6. Task.sleep(nanoseconds:) 让任务休眠指定时间，不会阻塞线程

// ✅ Task 取消相关API
// Task.isCancelled 如果任务仍处于活动状态，但自上一个挂起点以来已取消，则返回true。
// Task.currentPriority 返回当前任务的优先级。
// Task.cancel() 尝试取消任务及其子任务。
// Task.checkCancellation() 如果任务被取消，则抛出CancellationError，从而更容易退出抛出上下文。
// Task.yield() 挂起当前任务的执行，使系统有机会自动取消它以执行其他具有更高优先级的任务

// ✅ 异步序列
// for遍历
//for try await item in asyncSequence {
// // Next item from `asyncSequence`
//}

// while遍历
//var iterator = asyncSequence.makeAsyncIterator()
//while let item = try await iterator.next() {
//  ...
//}

// 使用标准序列相同的方法
//for await item in asyncSequence
//  .dropFirst(5)
//  .prefix(10)
//  .filter { $0 > 10 }
//  .map { "Item: \($0)" } {
//    ...
//  }

// 使用字节序列相关方法
//let bytes = URL(fileURLWithPath: "myFile.txt").resourceBytes
//for await character in bytes.characters {
//  ...
//}
//for await line in bytes.lines {
//  ...
//}

import SwiftUI

@main
struct SuperStorageApp: App {
  var body: some Scene {
    WindowGroup {
      ListView(model: SuperStorageModel())
    }
  }
}
