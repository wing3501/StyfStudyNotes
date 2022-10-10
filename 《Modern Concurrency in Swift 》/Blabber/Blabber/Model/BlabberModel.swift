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
import CoreLocation
import Combine
import UIKit

/// The app model that communicates with the server.
class BlabberModel: ObservableObject {
  var username = ""
  var urlSession = URLSession.shared

  init() {
  }

  /// Current live updates
  @Published var messages: [Message] = []
  
  /// A chat location delegate
  private var delegate: ChatLocationDelegate?

  /// Shares the current user's address in chat.
  @MainActor  //❌ 不在主线程初始化，定位不回调
  func shareLocation() async throws {
    // ✅ 使用withCheckedThrowingContinuation创建Continuation
    let location: CLLocation = try await withCheckedThrowingContinuation { [weak self] continuation in
      self?.delegate = ChatLocationDelegate(continuation:continuation)
    }
    
    let address: String = try await withCheckedThrowingContinuation { continuation in
      AddressEncoder.addressFor(location: location) { address, error in
          switch (address, error) {
          case (nil, let error?):
            continuation.resume(throwing: error)
          case (let address?, nil):
            continuation.resume(returning: address)
          case (nil, nil):
            continuation.resume(throwing: "Address encoding failed")
          case let (address?, error?):
            continuation.resume(returning: address)
            print(error)
          }
        }
      }
    try await say(" \(address)")
  }

//  var countdown = 3
  /// Does a countdown and sends the message.
  @MainActor
  func countdown(to message: String) async throws {
    guard !message.isEmpty else { return }
    // ✅ 使用continuation闭包的方式初始化AsyncStream
//    let counter = AsyncStream<String> { continuation in
//
//      Timer.scheduledTimer(withTimeInterval: 1.0,repeats: true) { timer in
//        guard self.countdown > 0 else {
//          self.countdown = 3
//          timer.invalidate()
////          continuation.yield("💐" + message)
////          continuation.finish() // 调用finish结束序列
////          ==
//          continuation.yield(with: .success("💐" + message))
//          return
//        }
//        continuation.yield("\(self.countdown) ...") // 使用yield生产一个值
//        self.countdown -= 1
//      }
//    }
    // 消费数据，否则数据都保存在缓冲区
//    for await countdownMessage in counter {
//      try await say(countdownMessage)
//    }
    
    // ✅ 使用unfolding闭包的方式实现同样的倒计时功能
    var countdown = 3
    let counter = AsyncStream<String> {
      do {
        try await Task.sleep(nanoseconds: 1_000_000_000)
      } catch {
        return nil
      }

      defer { countdown -= 1 }

      switch countdown {
      case (1...): return "\(countdown)..."
      case 0: return "🎉 " + message
      default: return nil
      }
    }
    
    try await counter.forEach { [weak self] in
      try await self?.say($0)
    }
  }

  /// Start live chat updates
  @MainActor
  func chat() async throws {
    guard
      let query = username.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
      let url = URL(string: "http://localhost:8080/chat/room?\(query)")
      else {
      throw "Invalid username"
    }

    let (stream, response) = try await liveURLSession.bytes(from: url, delegate: nil)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw "The server responded with an error."
    }

    print("Start live updates")

    try await withTaskCancellationHandler {
      print("End live updates")
      messages = []
    } operation: {
      try await readMessages(stream: stream)
    }
  }

  /// Reads the server chat stream and updates the data model.
  @MainActor
  private func readMessages(stream: URLSession.AsyncBytes) async throws {
    // 第一行是状态信息,迭代器只为读取第一行
    var iterator = stream.lines.makeAsyncIterator()
    guard let first = try await iterator.next() else {
      throw "No response from server"
    }
    guard let data = first.data(using: .utf8),
          let status = try? JSONDecoder().decode(ServerStatus.self, from: data) else {
      throw "Invalid response from server"
    }
    messages.append(
      Message(message: "\(status.activeUsers) active users")
    )
    
    let notifications = Task {
     await observeAppStatus()
    }
    
    defer {
     notifications.cancel() // for await抛出异常或者正常结束时，会取消任务
    }
    
    // 读取无限的消息列表
    for try await line in stream.lines {
      if let data = line.data(using: .utf8),
        let update = try? JSONDecoder().decode(Message.self, from: data) {
        messages.append(update)
      }
    }
  }

  /// Sends the user's message to the chat server
  func say(_ text: String, isSystemMessage: Bool = false) async throws {
    guard
      !text.isEmpty,
      let url = URL(string: "http://localhost:8080/chat/say")
    else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try JSONEncoder().encode(
      Message(id: UUID(), user: isSystemMessage ? nil : username, message: text, date: Date())
    )

    let (_, response) = try await urlSession.data(for: request, delegate: nil)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw "The server responded with an error."
    }
  }

  /// A URL session that goes on indefinitely, receiving live updates.
  private var liveURLSession: URLSession = {
    var configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = .infinity
    return URLSession(configuration: configuration)
  }()
  
  /// 监听app状态
  func observeAppStatus() async {
//    for await _ in await NotificationCenter.default.notifications(for: UIApplication.willResignActiveNotification) {
//      try? await say("\(username) went away", isSystemMessage: true)
//    }
    // ✅ 必须包在task中，否则第二个循环会等待第一个循环完成
    Task {
      for await _ in await NotificationCenter.default.notifications(for: UIApplication.willResignActiveNotification) {
        try? await say("\(username) went away", isSystemMessage: true)
      }
    }
    
    Task {
      for await _ in await NotificationCenter.default.notifications(for: UIApplication.didBecomeActiveNotification) {
        try? await say("\(username) came back", isSystemMessage: true)
      }
    }
  }
}

extension AsyncSequence {
  func forEach(_ body: (Element) async throws -> Void) async throws {
    for try await element in self {
      try await body(element)
    }
  }
}
