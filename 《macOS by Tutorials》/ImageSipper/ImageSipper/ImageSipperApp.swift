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
import Intents

@main
struct ImageSipperApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDel
    
    var serviceProvider = ServiceProvider()
    
    @StateObject var sipsRunner = SipsRunner()
    
  var body: some Scene {
    WindowGroup {
      ContentView()
            .environmentObject(sipsRunner)
            .onAppear {
                // ✅ 设置服务的响应 NSApp = NSApplication.shared
                NSApp.servicesProvider = serviceProvider
            }
    }
  }
}
// ✅ 服务响应处理
class ServiceProvider {
    @objc func openFromService(_ pboard: NSPasteboard, userData: String, error: NSErrorPointer) {
        let fileType = NSPasteboard.PasteboardType.fileURL
        guard
            let filePath = pboard.pasteboardItems?.first?.string(forType: fileType),
            let url = URL(string: filePath) else {
            return
        }
        NSApp.activate(ignoringOtherApps: true) // ✅ 将窗口置前
        // 检查一下传进来的url是否是文件夹或者图片
        let fileManager = FileManager.default
        if fileManager.isFolder(url: url) {
            NotificationCenter.default.post(name: .serviceReceivedFolder, object: url)
        }else if fileManager.isImageFile(url: url) {
            NotificationCenter.default.post(name: .serviceReceivedImage, object: url)
        }
    }
}

extension Notification.Name {
    static let serviceReceivedImage = NSNotification.Name("serviceReceivedImage")
    static let serviceReceivedFolder = NSNotification.Name("serviceReceivedFolder")
}
// ✅ 快捷指令响应处理
class PrepareForWebIntentHandler: NSObject,PrepareForWebIntentHandling {
//    func handle(intent: PrepareForWebIntent, completion: @escaping (PrepareForWebIntentResponse) -> Void) {
//        <#code#>
//    }
    
    func handle(intent: PrepareForWebIntent) async -> PrepareForWebIntentResponse {
        guard let fileURL = intent.url?.fileURL else {// 确认url有一个文件路径
            return PrepareForWebIntentResponse(code: .continueInApp, userActivity: nil)// 打开app
        }
        
        // 调用服务
        await SipsRunner().prepareForWeb(fileURL)
        
        return PrepareForWebIntentResponse(code: .success, userActivity: nil)
    }
    
//    func resolveUrl(for intent: PrepareForWebIntent, with completion: @escaping (INFileResolutionResult) -> Void) {
//        <#code#>
//    }
    
    func resolveUrl(for intent: PrepareForWebIntent) async -> INFileResolutionResult {
        // 确认提供了正确的参数
        guard let url = intent.url else { return .confirmationRequired(with: nil) }
        return .success(with: url)
    }
}
// ✅ 设置代理接收Intent
class AppDelegate: NSObject,NSApplicationDelegate {
    func application(_ application: NSApplication, handlerFor intent: INIntent) -> Any? {
        if intent is PrepareForWebIntent {
            return PrepareForWebIntentHandler()
        }
        return nil
    }
}
