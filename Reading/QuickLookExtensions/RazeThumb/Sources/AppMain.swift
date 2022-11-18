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

// Quick Look 使用教程
// Custom Thumbnails and Previews with Quick Look on iOS
// https://www.kodeco.com/19636179-custom-thumbnails-and-previews-with-quick-look-on-ios#c-rate

// ✅ 包含内容
// 1 使用QLThumbnailGenerator生成缩略图
// 2 为自定义文件格式定义并导出自己的文档类型
// 3 构建您自己的Quick Look预览扩展
// 4 构建自己的缩略图扩展
// 5 调试在扩展中运行的代码

// ✅ 定义一个文档类型的步骤
// 在target的 Info tab下，展开Document Types，点击+
// Name 填 Thumb File.
// Types 填 com.raywenderlich.rwthumbfile.
// Handler Rank 填 Owner ，因为这个app就是这个文件类型的拥有者
// Click where it says Click here to add additional document type properties. 可以在info.plist里修改
// Key 填 CFBundleTypeRole.
// Type 保持 String.
// Value 填 Editor.

// ✅ 导出一个文档类型，导出可以让其他app了解这个文档   ✅ 定义、导出文档后，文档的缩略图可以生成成功了
// 展开 Exported Type Identifiers.
// 点 +
// Description 填 Thumb File.
// Identifier, 填 com.raywenderlich.rwthumbfile
// Conforms To, 填 public.data, public.content.
// Extensions, 填 thumb, 就是这个文件的后缀名

// ✅ 添加Quick Look preview extension，解决thumb文件不可预览的问题。所有已安装的app都能利用这个扩展
// 添加一个新的Target
// 双击Quick Look Preview Extension，使用名称ThumbFilePreview
// 先不激活
// 把ThumbFile.swift、ThumbFileViewController.swift共享给扩展

// ✅ 启用预览扩展的步骤
// 打开 ThumbFilePreview/Info.plist.
// 展开 NSExtension
// 在QLSupportedContentTypes 内，添加一项
// 让 Item 0 为 String 类型，value 填 com.raywenderlich.rwthumbfile
// 修改PreviewViewController

// ✅ 添加一个缩略图扩展，展示自定义的缩略图样式
// 添加一个新的Target
// 双击Thumbnail Extension，使用名称ThumbFileThumbnail

// ✅ 启动缩略图扩展
// 打开 Info.plist
// 展开 NSExtension
// 在QLSupportedContentTypes 内，添加一项
// 让 Item 0 为 String 类型，value 填 com.raywenderlich.rwthumbfile
// 把ThumbFile.swift、ThumbFileViewController.swift共享给扩展
// 修改 ThumbnailProvider
 
import SwiftUI

@main
struct AppMain: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
