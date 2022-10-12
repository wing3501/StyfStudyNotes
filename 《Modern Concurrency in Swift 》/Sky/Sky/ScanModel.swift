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

import Foundation

class ScanModel: ObservableObject {
  // MARK: - Private state
  private var counted = 0
  private var started = Date()

  // MARK: - Public, bindable state

  /// Currently scheduled for execution tasks.  并发任务数量
  @MainActor @Published var scheduled = 0

  /// Completed scan tasks per second.  每秒完成的任务数量
  @MainActor @Published var countPerSecond: Double = 0

  /// Completed scan tasks. 已经完成的个数
  @MainActor @Published var completed = 0

  @Published var total: Int

  @MainActor @Published var isCollaborating = false

  // MARK: - Methods

  init(total: Int, localName: String) {
    self.total = total
  }

  func runAllTasks() async throws {
    started = Date()
    // ❌ 串行
//    var scans: [String] = []
//    for number in 0..<total {
//      scans.append(await worker(number: number))
//    }
//    print(scans)
    // ✅ 并发 需要真机测试
    await withTaskGroup(of: String.self, body: {[unowned self] group in
      for number in 0..<total {
        group.addTask {
          await self.worker(number: number)
        }
      }
      // ✅ 处理最终结果
//      return await group.reduce(into: [String]()) { result, string in
//          result.append(string)
//      }
      // ✅ 分别处理每个子任务的结果，一有任务完成，就会执行一次遍历
      for await result in group {
        print("Completed: \(result)")
      }
      print("Done.")
    })
    
    // ✅ 限制并发数
    // 使用这种方式，还可以做很多事情，比如
    // 1.通过不断添加任务，使group无限执行
    // 2.通过添加任务，重试失败的任务
    // 3.找到特定结果后，插入高优先级的UI更新任务
    await withTaskGroup(of: String.self, body: {[unowned self] group in
      // 限制并发4个任务
      let batchSize = 4
      for index in 0..<batchSize {
        group.addTask {
          await self.worker(number: index)
        }
      }
      // 1
      var index = batchSize
      // 2 每当一个任务完成，
      for await result in group {
        print("Completed: \(result)")
        // 3 就加入另一个任务
        if index < total {
          group.addTask { [index] in
            await self.worker(number: index)
          }
          index += 1
        }
      }
    })
  }
  
  func worker(number: Int) async -> String {
    await onScheduled()
    let task = ScanTask(input: number)
    let result = await task.run()// 第一个task.run完成后，并发系统需要做出选择，是开始另一个任务，还是恢复任何一个完成的
    await onTaskCompleted() // ✅ 需要告诉并发系统，更新UI更重要
    return result
  }
}

// MARK: - Tracking task progress.
extension ScanModel {
  @MainActor
  private func onTaskCompleted() {
    completed += 1
    counted += 1
    scheduled -= 1

    countPerSecond = Double(counted) / Date().timeIntervalSince(started)
  }

  @MainActor
  private func onScheduled() {
    scheduled += 1
  }
}
