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

/// A single scanning task.
struct ScanTask: Identifiable,Codable {
  let id: UUID
  let input: Int

  init(input: Int, id: UUID = UUID()) {
    self.id = id
    self.input = input
  }

  /// A method that performs the scanning.
  /// > Note: This is a mock method that just suspends for a second.
//  func run() async -> String {
  func run() async throws -> String {// 抛出异常的任务
    try await UnreliableAPI.shared.action(failingEvery: 10)
    
//    await Task { // ✅ 不设优先级的话，就会从父任务继承，最初始的任务从主线程来，所以是userInitiated
    await Task(priority: .medium) { //✅ 需要告诉并发系统，更新UI更重要
      // Block the thread as a real heavy-computation functon will.
      Thread.sleep(forTimeInterval: 1)
    }.value

    return "\(input)"
  }
}

struct TaskResponse: Codable {
  let result: String
  let id: UUID
}




