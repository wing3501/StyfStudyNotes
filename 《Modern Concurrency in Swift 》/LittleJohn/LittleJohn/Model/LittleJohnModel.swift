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

/// Easily throw generic errors with a text description.
extension String: Error { }

/// The app model that communicates with the server.
class LittleJohnModel: ObservableObject {
  /// Current live updates.
  @Published private(set) var tickerSymbols: [Stock] = []

  /// Start live updates for the provided stock symbols.
  func startTicker(_ selectedSymbols: [String]) async throws {
    await MainActor.run(body: {
      tickerSymbols = []
    })
    
    guard let url = URL(string: "http://localhost:8080/littlejohn/ticker?\(selectedSymbols.joined(separator: ","))") else {
      throw "The URL could not be created."
    }
    // ✅ URLSession.bytes(from:delegate:) 返回异步序列，steam是字节序列
    let (stream, response) = try await liveURLSession.bytes(from: url)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw "The server responded with an error."
    }
    for try await line in stream.lines { // ✅ line 行是对该序列的抽象，它逐行给出响应的文本行。
      let sortedSymbols = try JSONDecoder()
        .decode([Stock].self, from: Data(line.utf8))
        .sorted(by: { $0.name < $1.name })
      await MainActor.run {
        tickerSymbols = sortedSymbols
        print("Updated: \(Date())")
      }
    }
    print("异步序列遍历结束------")
    await MainActor.run(body: {
        tickerSymbols = []
    })
    
  }
  
  func availableSymbols() async throws -> [String] {
    guard let url = URL(string: "http://localhost:8080/littlejohn/symbols")
    else {
      throw "The URL could not be created."
    }
    let (data, response) = try await URLSession.shared.data(from:url)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw "The server responded with an error."
    }
    return try JSONDecoder().decode([String].self, from: data)
  }

  /// A URL session that lets requests run indefinitely so we can receive live updates from server.
  private lazy var liveURLSession: URLSession = {
    var configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = .infinity // ✅ 设置永不超时，以便于无期限接收一个超长服务器响应
    return URLSession(configuration: configuration)
  }()
}
