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

struct PathView: NSViewRepresentable {
    
    
  var url: URL?

  func makeNSView(context: Context) -> NSPathControl {
      // ✅ 使用NSPathControl来显示文件路径 避免路径显示不全的问题
    let pathControl = NSPathControl()

    pathControl.isEditable = false
    pathControl.focusRingType = .none
    pathControl.pathStyle = .standard
      
      pathControl.target = context.coordinator
      pathControl.doubleAction = #selector(Coordinator.handDoubleClick(sender:))

    return pathControl
  }

  func updateNSView(_ nsView: NSPathControl, context: Context) {
    nsView.url = url
  }
    
    class Coordinator {
        // ✅ 双击打开一个路径
        @objc func handDoubleClick(sender: NSPathControl) {
            if let url = sender.clickedPathItem?.url {// 是否有一个url被双击了
                // 用Finer 显示这个路径
                NSWorkspace.shared.selectFile(url.path, inFileViewerRootedAtPath: "")
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}
