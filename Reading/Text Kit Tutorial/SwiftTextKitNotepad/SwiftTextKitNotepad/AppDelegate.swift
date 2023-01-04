/// Copyright (c) 2018 Razeware LLC
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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

// Text Kit Tutorial: Getting Started
// https://www.kodeco.com/5960-text-kit-tutorial-getting-started

// ✅
// NSTextStorage 把text保存为 attributed string。text内容的任何改变都会通知给 layout manager。我们可以子类化NSTextStorage，以实现文字改变时，自动改变attributes，类似这种功能

// NSLayoutManager 作为一个布局引擎，把保存的text渲染上屏

// NSTextContainer 描述了屏幕上渲染text的区域形状。每个NSTextContainer通常与一个UITextView关联。我们可以子类化NSTextContainer，来定义一个复杂形状用于渲染text


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    // style the navigation bar
    let navColor = UIColor(red: 0.175, green: 0.458, blue: 0.831, alpha: 1.0)
    UINavigationBar.appearance().barTintColor = navColor
    UINavigationBar.appearance().tintColor = .red
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    
    return true
  }
}
