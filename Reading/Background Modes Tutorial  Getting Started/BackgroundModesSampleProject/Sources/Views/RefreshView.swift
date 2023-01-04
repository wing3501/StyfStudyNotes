/// Copyright (c) 2022 Razeware LLC
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
import BackgroundTasks

struct RefreshView: View {
  @AppStorage(UserDefaultsKeys.lastRefreshDateKey) var lastRefresh = "Never"
  @Environment(\.scenePhase) var scenePhase

  var body: some View {
    VStack(alignment: .center, spacing: 20) {
      Text("Background Refresh")
        .font(.largeTitle)
        .fontWeight(.bold)
        .padding(EdgeInsets(top: 50, leading: 50, bottom: 0, trailing: 50))

      Spacer()

      Text("Refresh last performed:")
        .multilineTextAlignment(.center)
        .font(.title)
        .onChange(of: scenePhase) { scenePhase in
          if scenePhase == .background {
            //✅ 由于无法确定系统什么时候会触发background fetch，所以要调试的话，需要在下面一行打断点
            // 在lldb中使用 以下命令 触发
            // e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.mycompany.myapp.task.refresh"]
            print("moved to background")
          }
        }
        .padding()

      Text(lastRefresh)
        .font(.title2)

      Spacer()
      Spacer()
    }
  }
}

struct FetchView_Previews: PreviewProvider {
  static var previews: some View {
    RefreshView()
  }
}
