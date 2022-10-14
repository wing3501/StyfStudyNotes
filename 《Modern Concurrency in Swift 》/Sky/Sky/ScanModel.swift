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

  @MainActor @Published var isConnected = false
  private var systems: Systems
  private(set) var service: ScanTransport
  
  // MARK: - Methods

  init(total: Int, localName: String) {
    self.total = total
    
    let localSystem = ScanSystem(name: localName)
    systems = Systems(localSystem)
    service = ScanTransport(localSystem: localSystem)
    service.taskModel = self
    
    systemConnectivityHandler()
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
//    await withTaskGroup(of: String.self, body: {[unowned self] group in
//      for number in 0..<total {
//        group.addTask {
//          await self.worker(number: number)
//        }
//      }
//      // ✅ 处理最终结果
////      return await group.reduce(into: [String]()) { result, string in
////          result.append(string)
////      }
//      // ✅ 分别处理每个子任务的结果，一有任务完成，就会执行一次遍历
//      for await result in group {
//        print("Completed: \(result)")
//      }
//      print("Done.")
//    })
    
    // ✅ 限制并发数
    // 使用这种方式，还可以做很多事情，比如
    // 1.通过不断添加任务，使group无限执行
    // 2.通过添加任务，重试失败的任务
    // 3.找到特定结果后，插入高优先级的UI更新任务
    try await withThrowingTaskGroup(of: Result<String, Error>.self, body: {[unowned self] group in
      // 限制并发4个任务
      let batchSize = 4
      for index in 0..<batchSize {
        group.addTask {
//          try await self.worker(number: index)
          await self.worker(number: index)
        }
      }
      // 1
      var index = batchSize
      // 2 每当一个任务完成，
      for try await result in group {
        switch result {
        case .success(let result):
          print("Completed: \(result)")
        case .failure(let error):
          print("Failed: \(error.localizedDescription)")
        }
        // 3 就加入另一个任务
        if index < total {
          group.addTask { [index] in
//            try await self.worker(number: index)
            await self.worker(number: index)
          }
          index += 1
        }
      }
      
      // group中的for await会保证任务全部结束，所以不必使用TaskGroup.waitForAll()
      await MainActor.run {
        completed = 0
        countPerSecond = 0
        scheduled = 0
      }
    })
    
  }
  // 分布式任务版本
  func runAllTasks1() async throws {
    started = Date()
    try await withThrowingTaskGroup(of: Result<String, Error>.self) { [unowned self] group in
      
      for number in 0 ..< total {
        let system = await systems.firstAvailableSystem()
        group.addTask {
          return await self.worker(number: number, system: system)
        }
      }
      
      for try await result in group {
        switch result {
        case .success(let result):
          print("Completed: \(result)")
        case .failure(let error):
          print("Failed: \(error.localizedDescription)")
        }
      }
      await MainActor.run {
        completed = 0
        countPerSecond = 0
        scheduled = 0
      }
      print("Done.")
    }
  }
  
//  func worker(number: Int) async throws -> String {
  func worker(number: Int) async -> Result<String, Error> { // ✅ 使用Result处理异常，使得一个子任务出错时，其他子任务可以继续
    await onScheduled()
    let task = ScanTask(input: number)
//    let result = try await task.run()// 第一个task.run完成后，并发系统需要做出选择，是开始另一个任务，还是恢复任何一个完成的
    let result: String
    do {
      result = try await task.run()
    } catch {
      return .failure(error)
    }
    await onTaskCompleted() // ✅ 需要告诉并发系统，更新UI更重要
    return .success(result)
  }
  
  func worker(number: Int, system: ScanSystem) async -> Result<String, Error> { // ✅ 使用Result处理异常，使得一个子任务出错时，其他子任务可以继续
    await onScheduled()
    let task = ScanTask(input: number)
//    let result = try await task.run()// 第一个task.run完成后，并发系统需要做出选择，是开始另一个任务，还是恢复任何一个完成的
    let result: String
    do {
      result = try await system.run(task)
    } catch {
      return .failure(error)
    }
    await onTaskCompleted() // ✅ 需要告诉并发系统，更新UI更重要
    return .success(result)
  }
  
  
  func systemConnectivityHandler() {
    Task {
      for await notification in NotificationCenter.default.notifications(named: .connected) {
        guard let name = notification.object as? String else { continue }
        print("[Notification] Connected: \(name)")
        await systems.addSystem(name: name, service: self.service)
        // ✅ 这里需要回到主线程更新isConnected，但是使用MainActor.run(...)的话，内部是一个同步的闭包
        //   而这里异步地访问systems.systems.count
        //  所以这里使用Task+@MainActor。既能让代码在main actor执行，又能使用await
        Task { @MainActor in
          isConnected = await systems.systems.count > 1
        }
      }
    }
    
    
    Task {
      for await notification in NotificationCenter.default.notifications(named: .disconnected) {
        guard let name = notification.object as? String else { return }
        print("[Notification] Disconnected: \(name)")
        await systems.removeSystem(name: name)
        Task { @MainActor in
          isConnected = await systems.systems.count > 1
        }
      }
    }
  }
  
  
  func run(_ task: ScanTask) async throws -> String {
    Task { @MainActor in scheduled += 1 }
    defer {
      Task { @MainActor in scheduled -= 1 }
    }
    return try await systems.localSystem.run(task)
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
