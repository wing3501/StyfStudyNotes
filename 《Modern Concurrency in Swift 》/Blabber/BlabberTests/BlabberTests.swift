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

import XCTest
@testable import Blabber

class BlabberTests: XCTestCase {
  let model: BlabberModel = {
    // 1
    let model = BlabberModel()
    model.username = "test"
    // 2
    let testConfiguration = URLSessionConfiguration.default
    testConfiguration.protocolClasses = [TestURLProtocol.self]
    // 3
    model.urlSession = URLSession(configuration: testConfiguration)
    return model
  }()
  
  
  func testModelSay() async throws {
    try await model.say("Hello!")
    // 解包检查请求地址
    let request = try XCTUnwrap(TestURLProtocol.lastRequest)
    XCTAssertEqual(request.url?.absoluteString,"http://localhost:8080/chat/say")
    // 校验请求数据
    let httpBody = try XCTUnwrap(request.httpBody)
    let message = try XCTUnwrap(try? JSONDecoder().decode(Message.self, from: httpBody))
    XCTAssertEqual(message.message, "Hello!")
  }
  
  func testModelCountdown() async throws {
//    try await model.countdown(to: "Tada!")
    // ❌ countdown方法已经结束，所以for await遍历不到请求
    // ❌ for await永远不会结束
//    for await request in TestURLProtocol.requests {
//      print(request)
//    }
    
    // ✅ 使用TimeoutTask解决超时
//    try await TimeoutTask(seconds: 10) {
//      for await request in TestURLProtocol.requests {
//        print(request)
//      }
//    } .value
    
    // ✅ 用async let解决遍历不到请求的问题
    async let countdown: Void = model.countdown(to: "Tada!") // 📢因为countdown没有返回值，所以需要明确指明Void
    async let messages = TimeoutTask(seconds: 10) {
      await TestURLProtocol.requests
        .prefix(4) // 如果实际代码只发出3个请求，测试仍然挂起，需要 TimeoutTask
        .reduce(into: []) { partialResult, request in
          partialResult.append(request) // 把4个请求收集到数组中
        }
        .compactMap(\.httpBody)
        .compactMap { data in
          try? JSONDecoder()
            .decode(Message.self, from: data)
            .message
        }
    }
      .value
    
    let (messagesResult, _) = try await (messages, countdown)
    XCTAssertEqual(
    ["3...", "2...", "1...", "🎉 Tada!"],
      messagesResult
    )
  }
}
