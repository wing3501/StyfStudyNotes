/// Copyright (c) 2023 Razeware LLC
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
import UIKit
import BackgroundTasks

// ✅ 使用background fetch的流程，系统不保证什么时候会触发，所以不要做关键性任务
//Check the box Background fetch in the Background Modes of your app’s Capabilities.
//Add an identifier to Info.plist for your refresh task.
//Invoke BGTaskScheduler.register(forTaskWithIdentifier:using:launchHandler:) in your app delegate to handle the background fetch.
//Create a BGAppRefreshTaskRequest with an earliestBeginDate for when to execute.
//Submit the request using BGTaskScheduler.submit(_:).

class AppDelegate: UIResponder, UIApplicationDelegate {
  static var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .long
    return formatter
  }()

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    // ✅ iOS 要求在didFinishLaunchingWithOptions里注册后台fetch任务
    
    
    BGTaskScheduler.shared.register(
      forTaskWithIdentifier: AppConstants.backgroundTaskIdentifier,
      using: nil) { task in
        // ✅
        self.refresh() // 1 执行第一次刷新
        task.setTaskCompleted(success: true) // 2 标记任务结束
        self.scheduleAppRefresh() // 3 设置下一次刷新时间
    }

    scheduleAppRefresh()
    return true

  }
  
  func refresh() {
    // to simulate a refresh, just update the last refresh date
    // to current date/time
    let formattedDate = Self.dateFormatter.string(from: Date())
    UserDefaults.standard.set(
      formattedDate,
      forKey: UserDefaultsKeys.lastRefreshDateKey)
    print("refresh occurred")
  }

  func scheduleAppRefresh() {
    let request = BGAppRefreshTaskRequest(
      identifier: AppConstants.backgroundTaskIdentifier)
    request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60)
    do {
      try BGTaskScheduler.shared.submit(request)
      print("background refresh scheduled")
    } catch {
      print("Couldn't schedule app refresh \(error.localizedDescription)")
    }
  }

}
