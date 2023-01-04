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
///
///
///   Background Modes Tutorial: Getting Started
///   https://www.kodeco.com/34269507-background-modes-tutorial-getting-started
///   后台模式使用教程
///    ✅ 教程包含内容：
///    1 Play audio: 后台继续播放音频
///    2 Receive location updates: 后台接受定位更新
///    3 Complete finite-length critical tasks: 移动到后台后，启用应用程序继续完成关键任务。
///    4 Background Fetch: 根据一个时间表，进行后台更新
///
///  ✅ 苹果支持的后台模式
//   Audio, AirPlay, and Picture in Picture: 后台播放音视频
//   Location Updates: 后台位置更新
//   Voice over IP: 通过互联网发送和接收语音。
//   External accessory communication: 通过雷电端口与外部附件通信。
//   Using Bluetooth LE accessories: 在后台与蓝牙LE配件进行通信。
//   Acting as a Bluetooth LE accessory: 允许应用程序向附件提供蓝牙LE信息。
//   Background fetch: 执行数据刷新。
//   Remote notitifications: 发送和接收远程通知。
//   Background processing: 执行更花时间的关键流程。


import SwiftUI

@main
struct AppMain: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
