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

// ✅ 添加一项服务到服务菜单
// 1. 在info.plist 添加一行 Services
// 2. 填入服务配置
//    Instance method name 服务会调用的方法名
//    Incoming service port name 服务会唤起的应用
//    Send Types 本服务方法接收的参数类型  NSPasteboard.PasteboardType
//    Send File Types 本服务支持的文件类型
//    设置服务的context告诉系统，什么时候最合适显示我的特有服务  NSRequiredContext
//    NSTextContext = FilePath: 服务只有当你选中一个文件路径，并且指向一个图片或者文件夹时，才显示我的菜单项
// 3. （可选）如果服务里没出现，因为系统定期扫描服务。使用pbs强制系统刷新
//    /System/Library/CoreServices/pbs -flush
//    /System/Library/CoreServices/pbs -update
// 4. 设置ServiceProvider

struct ContentView: View {
  @State private var showTerminalOutput = true
  @State private var selectedTab = TabSelection.editImage

    @EnvironmentObject var sipsRunner: SipsRunner
    
  var body: some View {
    HSplitView {
      VStack {
        TabView(selection: $selectedTab) {
          ImageEditView(selectedTab: $selectedTab)
            .tabItem {
              Text("Edit Image")
            }
            .tag(TabSelection.editImage)

          ThumbsView(selectedTab: $selectedTab)
            .tabItem {
              Text("Make Thumbnails")
            }
            .tag(TabSelection.makeThumbs)
        }
        .padding([.horizontal, .top])
        .frame(minWidth: 650, minHeight: 450)

        HStack {
          Spacer()
          Button {
            showTerminalOutput.toggle()
          } label: {
            Text(showTerminalOutput ? "Hide Terminal Output" : "Show Terminal Output")
            Image(systemName: showTerminalOutput ? "chevron.right" : "chevron.left")
          }
          .padding([.horizontal, .bottom])
          .padding(.top, 2)
        }
      }

      if showTerminalOutput {
          TerminalView(commandRunner: sipsRunner.commandRunner)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

enum TabSelection {
  case editImage
  case makeThumbs
}
