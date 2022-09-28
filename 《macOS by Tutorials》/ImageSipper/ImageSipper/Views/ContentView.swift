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


// ✅ 添加一项快捷指令
// 1. 新建Intent模板文件   intent是发布给Siri和快捷指令的服务
// 2. 选中模板文件，新建intent，配置Parameter部分
// 表示预期一个url参数，类型是URL,指向一个图片文件
//        新建参数url
//        修改Display Name,修改Type
//        修改File Type
//        修改Siri Dialog
// 3. 配置 Shortcuts app部分. Input Parameter和Key Parameter 都设为url。设置summary，url自动填充
// 4. 编译 Intent
// 5. 选择 target - General - Supported Intents,填入编译好的PrepareForWebIntent
// 6. 实现 PrepareForWebIntentHandler
// 7. 使用appDelegate代理方法接收intent

// ✅ 关于 快捷指令的调试问题
// 1 如果没有在“快捷指令”中看到你的intent，则 rm -rf ~/Library/Developer/Xcode/DerivedData 然后重新构建
// 2 确保代码没有问题，写个按钮调用一下代码
// 3 如果你的快捷指令挂起了，重启电脑

// ✅ dmg打包步骤
// 1 打开“磁盘工具”，文件-新建映像-空白映像
// 2 填入名称、大小比文件略大,保存
// 3 打开dmg,拖入app,cmd+option拖入Applications路径
// 4 拖入背景图，按Shift-Command-.显示隐藏文件，给文件名加.如.background.png让它成为隐藏文件
// 5 按Command-1 to View > as Icons,然后按Command-J打开View options
// 6 勾选 Always open in icon View,Group By和Sort By 设为None
// 7 icon size 设为80X80
// 8 选择Picture in View Options > Background，并拖入隐藏文件背景图
// 9 可以在Find > View中隐藏各类Bar
// 10 拖动文件到合适的位置
// 11 在另一个Finder 窗口，按Command-E弹出新映像
// 12 重新打开“磁盘工具”，在Images-Convert中选择DMG文件，权限设置为只读，点击转换
// 如果映像不显示背景图，则弹出、删除刚刚创建的只读映像，打开读写映像，确认设置正确，移动一下窗口，再尝试

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
    
    // ✅ 联系开发者邮箱
    func emailDeveloper() {
        let subject = "主题"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let link = "mailto:dev@example.com?subject=\(subject)"
        if let url = URL(string: link) {
            NSWorkspace.shared.open(url)
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
