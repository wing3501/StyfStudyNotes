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

import SwiftUI
import Combine

// ✅ 当有动态数量的异步任务需要并发执行，使用TaskGroup
// 两个变体： TaskGroup  ThrowingTaskGroup
// withTaskGroup(of:returning:body:):
// withThrowingTaskGroup(of:returning:body:):
// 这些Group都是所有任务完成后才返回

// 一个🌰
//struct TaskGroupExample {
//  func test() {
//    //1
//    let images = try await withThrowingTaskGroup(
//      of: Data.self // 每个Task返回Data
//      returning: [UIImage].self // 整个TaskGroup返回[UIImage]
//    ) { group in
//      // 2
//      for index in 0..<numberOfImages {
//        let url = baseURL.appendingPathComponent("image\(index).png")
//        // 3 添加任务
//        group.addTask {
//          // 4
//          return try await URLSession.shared.data(from: url, delegate: nil).0
//        }
//      }
//      // 5 TaskGroup遵循AsyncSequence，所以可以使用reduce
//      return try await group.reduce(into: [UIImage]()) { result, data in
//        if let image = UIImage(data: data) {
//          result.append(image)
//        }
//      }
//    }
//  }
//}

// ✅ 管理子任务的API
// addTask(priority:operation:):
// addTaskUnlessCancelled(priority:operation:): 同上，除了当group取消时，不做任何处理
// cancelAll(): 取消group
// isCancelled: group是否已取消
// isEmpty: 如果group已经完成了所有任务，或者没有任务可以开始则返回true
// waitForAll(): 等待所有子任务完成。如果需要在group完成执行后做一些事情，可以使用

@main
struct SkyApp: App {
  @ObservedObject
  var scanModel = ScanModel(total: 20, localName: UIDevice.current.name)

  @State var isScanning = false

  /// The last error message that happened.
  @State var lastMessage = "" {
    didSet {
      isDisplayingMessage = true
    }
  }
  @State var isDisplayingMessage = false

  var body: some Scene {
    WindowGroup {
      NavigationView {
        VStack {
          TitleView(isAnimating: $scanModel.isCollaborating)

          Text("Scanning deep space")
            .font(.subheadline)

          ScanningView(
            total: $scanModel.total,
            completed: $scanModel.completed,
            perSecond: $scanModel.countPerSecond,
            scheduled: $scanModel.scheduled
          )

          Button(action: {
            Task {
              isScanning = true
              do {
                let start = Date().timeIntervalSinceReferenceDate
                try await scanModel.runAllTasks()
                let end = Date().timeIntervalSinceReferenceDate
                lastMessage = String(
                  format: "Finished %d scans in %.2f seconds.",
                  scanModel.total,
                  end - start
                )
              } catch {
                lastMessage = error.localizedDescription
              }
              isScanning = false
            }
          }, label: {
            HStack(spacing: 6) {
              if isScanning { ProgressView() }
              Text("Engage systems")
            }
          })
          .buttonStyle(.bordered)
          .disabled(isScanning)
        }
        .alert("Message", isPresented: $isDisplayingMessage, actions: {
          Button("Close", role: .cancel) { }
        }, message: {
          Text(lastMessage)
        })
        .toolbar {
          if scanModel.isConnected {
            Image(systemName: "link.circle")
          }
        }
        .padding()
        .statusBar(hidden: true)
      }
    }
  }
}
