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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
// ✅ 5 自定义NSTextStorage
class SyntaxHighlightTextStorage: NSTextStorage {
    // 一个text storage子类必须提供自己的持久化存储
    let backingStore = NSMutableAttributedString()
    
    // 重写以下两个计算属性、方法。
    override var string: String {
      return backingStore.string
    }

    override func attributes(
      at location: Int,
      effectiveRange range: NSRangePointer?
    ) -> [NSAttributedString.Key: Any] {
      return backingStore.attributes(at: location, effectiveRange: range)
    }

    // text storage 要求调用 beginEditing(), edited() and endEditing() 这三个方法去通知自己关联的layout manager
    override func replaceCharacters(in range: NSRange, with str: String) {
      print("replaceCharactersInRange:\(range) withString:\(str)")
        
      beginEditing()
      backingStore.replaceCharacters(in: range, with:str)
      edited(.editedCharacters, range: range,
             changeInLength: (str as NSString).length - range.length)
      endEditing()
    }
      
    override func setAttributes(_ attrs: [NSAttributedString.Key: Any]?, range: NSRange) {
      print("setAttributes:\(String(describing: attrs)) range:\(range)")
        
      beginEditing()
      backingStore.setAttributes(attrs, range: range)
      edited(.editedAttributes, range: range, changeInLength: 0)
      endEditing()
    }

}
