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
    
    private var replacements: [String: [NSAttributedString.Key: Any]] = [:]

    
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

    // 给*文字*加粗体样式
    func applyStylesToRange(searchRange: NSRange) {
      // 1 用字体描述符创建普通字体和粗体字体
      let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
      let boldFontDescriptor = fontDescriptor.withSymbolicTraits(.traitBold)
      let boldFont = UIFont(descriptor: boldFontDescriptor!, size: 0)
      let normalFont = UIFont.preferredFont(forTextStyle: .body)
        
      // 2 样式
      let regexStr = "(\\*\\w+(\\s\\w+)*\\*)"
      let regex = try! NSRegularExpression(pattern: regexStr)
      let boldAttributes = [NSAttributedString.Key.font: boldFont]
      let normalAttributes = [NSAttributedString.Key.font: normalFont]
        
      // 3
      regex.enumerateMatches(in: backingStore.string, range: searchRange) {
        match, flags, stop in
        if let matchRange = match?.range(at: 1) {
          addAttributes(boldAttributes, range: matchRange)
          // 4 将匹配字符串中最后一个星号后面的字符的文本样式重置为“正常”。这可以确保在结束星号之后添加的任何文本都不会以粗体显示。
          let maxRange = matchRange.location + matchRange.length
          if maxRange + 1 < length {
            addAttributes(normalAttributes, range: NSMakeRange(maxRange, 1))
          }
        }
      }
    }

    // 将改动的范围扩展到一整行,changedRange通常是1个字符
    func performReplacementsForRange(changedRange: NSRange) {
      var extendedRange =
        NSUnionRange(changedRange,
        NSString(string: backingStore.string)
          .lineRange(for: NSMakeRange(changedRange.location, 0)))
      extendedRange =
        NSUnionRange(changedRange,
        NSString(string: backingStore.string)
          .lineRange(for: NSMakeRange(NSMaxRange(changedRange), 0)))
      applyStylesToRange(searchRange: extendedRange)
    }
    // ✅ 6 给*文字*加粗体样式   基本思路：通过正则找到要加样式的范围，添加样式
    override func processEditing() {
      // 当text改变时，processEditing()给layout manager发通知
      performReplacementsForRange(changedRange: editedRange)
      super.processEditing()
    }


    
    func createAttributesForFontStyle(
      _ style: UIFont.TextStyle,
      withTrait trait: UIFontDescriptor.SymbolicTraits
    ) -> [NSAttributedString.Key: Any] {
      let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
      let descriptorWithTrait = fontDescriptor.withSymbolicTraits(trait)
      let font = UIFont(descriptor: descriptorWithTrait!, size: 0)// 传0，强制UIFont返回当前用户字体首选项大小的字体
      return [.font: font]
    }

    func createHighlightPatterns() {
      let scriptFontDescriptor = UIFontDescriptor(fontAttributes: [.family: "Zapfino"])
        
      // 1
      let bodyFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
      let bodyFontSize = bodyFontDescriptor.fontAttributes[.size] as! NSNumber
      let scriptFont = UIFont(descriptor: scriptFontDescriptor,
                              size: CGFloat(bodyFontSize.floatValue))
        
      // 2
      let boldAttributes = createAttributesForFontStyle(.body,  withTrait:.traitBold)
      let italicAttributes = createAttributesForFontStyle(.body,
                                                          withTrait:.traitItalic)
      let strikeThroughAttributes =  [NSAttributedString.Key.strikethroughStyle: 1]
      let scriptAttributes = [NSAttributedString.Key.font: scriptFont]
      let redTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        
      // 3
      replacements = [
        "(\\*\\w+(\\s\\w+)*\\*)": boldAttributes,
        "(_\\w+(\\s\\w+)*_)": italicAttributes,
        "([0-9]+\\.)\\s": boldAttributes,
        "(-\\w+(\\s\\w+)*-)": strikeThroughAttributes,
        "(~\\w+(\\s\\w+)*~)": scriptAttributes,
        "\\s([A-Z]{2,})\\s": redTextAttributes
      ]
    }

}
