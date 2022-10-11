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

/// A catch-all URL protocol that returns successful response and records all requests.
class TestURLProtocol: URLProtocol {
  
  static var lastRequest: URLRequest? {
    didSet {
      if let request = lastRequest {
        continuation?.yield(request)
      }
    }
  }
  
  static private var continuation: AsyncStream<URLRequest>.Continuation?
  static var requests: AsyncStream<URLRequest> = {
    return AsyncStream { continuation in
      TestURLProtocol.continuation = continuation
    }
  }()
  
  override class func canInit(with request: URLRequest) -> Bool {
    return true // 如果当前的URLProtocol可以处理给定的URLRequest，则返回true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request // 如有需要，修改URLRequest
  }

  /// Store the URL request and send success response back to the client.
  override func startLoading() {
    // 加载请求，给client返回一个response
    
    guard let stream = request.httpBodyStream else {
      fatalError("Unexpected test scenario")
    }
    var request = request // 创建一个可变请求
    request.httpBody = stream.data // 读取流中的字节，返回Data
    Self.lastRequest = request
    
    
    guard let client = client,
      let url = request.url,
      let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
      else { fatalError("Client or URL missing") }

    client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    client.urlProtocol(self, didLoad: Data()) // 测试不关心服务侧返回的数据
    client.urlProtocolDidFinishLoading(self)
  }

  override func stopLoading() {
    // 操作被取消，或session停止请求
  }
}
