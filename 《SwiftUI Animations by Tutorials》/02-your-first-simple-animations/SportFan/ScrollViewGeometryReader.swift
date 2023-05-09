/// Copyright (c) 2023 Kodeco Inc.
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

struct ScrollViewGeometryReader: View {
  @Binding var pullToRefresh: PullToRefresh
  
  let update: () async -> Void
  
  @State private var startOffset: CGFloat = 0
  
    var body: some View {
      GeometryReader<Color> { proxy in
        Task {
          // 因为内部会修改状态，所以使用异步
          calculateOffset(from:proxy)
        }
        return Color.clear
      }
      .task {
        await update()
      }
    }
  
  private func calculateOffset(from proxy: GeometryProxy) {
    // 当前下拉位置
    let currentOffset = proxy.frame(in: .global).minY
    
    switch pullToRefresh.state {
    case .idle://开始下拉
      startOffset = currentOffset
      pullToRefresh.state = .pulling
      
    case .pulling where pullToRefresh.progress < 1:
      pullToRefresh.progress = min(1, (currentOffset - startOffset) / Constants.maxOffset)
      
    case .pulling:
      pullToRefresh.state = .ongoing//触发刷新
      pullToRefresh.progress = 0
      Task {
        await update()
        pullToRefresh.state = .idle
      }
      
    default: return
    }
  }
}
