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

import Combine
import SwiftUI

extension CompleteTaskView {
  class Model: ObservableObject {
    @Published var isTaskExecuting = false
    @Published var resultsMessage = initialMessage

    static let initialMessage = "Fibonacci Computations"
    static let maxValue = NSDecimalNumber(mantissa: 1, exponent: 40, isNegative: false)

    var previous = NSDecimalNumber.one
    var current = NSDecimalNumber.one
    var position: UInt = 1
    var updateTimer: Timer?
    
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid

    func beginPauseTask() {
      isTaskExecuting.toggle()
      if isTaskExecuting {
        resetCalculation()
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
          self?.calculateNextNumber()
        }
      } else {
        updateTimer?.invalidate()
        updateTimer = nil
        resultsMessage = Self.initialMessage
      }
    }

    func resetCalculation() {
      previous = .one
      current = .one
      position = 1
    }
    // ✅ 开启后台任务
    func registerBackgroundTask() {
      backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
        // ✅ 大概最后5秒左右会触发这个即将到期的回调
        print("iOS has signaled time has expired")
        self?.endBackgroundTaskIfActive()
      }
    }
    // ✅ 结束后台任务
    func endBackgroundTaskIfActive() {
      let isBackgroundTaskActive = backgroundTask != .invalid
      if isBackgroundTaskActive {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
      }
    }


    func calculateNextNumber() {
      let result = current.adding(previous)

      if result.compare(Self.maxValue) == .orderedAscending {
        previous = current
        current = result
        position += 1
      } else {
        // This is just too much.... Start over.
        resetCalculation()
      }

      resultsMessage = "Position \(self.position) = \(self.current)"

      switch UIApplication.shared.applicationState {
      case .background:
        let timeRemaining = UIApplication.shared.backgroundTimeRemaining
        if timeRemaining < Double.greatestFiniteMagnitude {
          let secondsRemaining = String(format: "%.1f seconds remaining", timeRemaining)
          print("App is backgrounded - \(resultsMessage) - \(secondsRemaining)")
        }
      default:
        break
      }
    }

    func onChangeOfScenePhase(_ newPhase: ScenePhase) {
      switch newPhase {
      case .background:
        let isTimerRunning = updateTimer != nil
        let isTaskUnregistered = backgroundTask == .invalid

        if isTimerRunning && isTaskUnregistered {
          registerBackgroundTask()
        }
      case .active:
        endBackgroundTaskIfActive()
      default:
        break
      }
    }
  }
}
