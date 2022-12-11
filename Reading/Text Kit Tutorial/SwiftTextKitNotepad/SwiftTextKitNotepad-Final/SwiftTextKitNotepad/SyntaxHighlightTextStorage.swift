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

import UIKit

class SyntaxHighlightTextStorage: NSTextStorage {
  let backingStore = NSMutableAttributedString()
  private var replacements: [String: [NSAttributedString.Key: Any]] = [:]

  
  override var string: String {
    return backingStore.string
  }
  
  override init() {
    super.init()
    createHighlightPatterns()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [NSAttributedString.Key: Any] {
      return backingStore.attributes(at: location, effectiveRange: range)
  }
  
  override func replaceCharacters(in range: NSRange, with str: String) {
    print("replaceCharactersInRange:\(range) withString:\(str)")
    
    beginEditing()
    backingStore.replaceCharacters(in: range, with:str)
    edited(.editedCharacters, range: range, changeInLength: (str as NSString).length - range.length)
    endEditing()
  }
  
  override func setAttributes(_ attrs: [NSAttributedString.Key: Any]?, range: NSRange) {
    print("setAttributes:\(String(describing: attrs)) range:\(range)")
    
    beginEditing()
    backingStore.setAttributes(attrs, range: range)
    edited(.editedAttributes, range: range, changeInLength: 0)
    endEditing()
  }
  
  func applyStylesToRange(searchRange: NSRange) {
    let normalAttrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
    addAttributes(normalAttrs, range: searchRange)
    
    // iterate over each replacement
    for (pattern, attributes) in replacements {
      do {
        let regex = try NSRegularExpression(pattern: pattern)
        regex.enumerateMatches(in: backingStore.string, range: searchRange) {
          match, flags, stop in
          // apply the style
          if let matchRange = match?.range(at: 1) {
            print("Matched pattern: \(pattern)")
            addAttributes(attributes, range: matchRange)
            
            // reset the style to the original
            let maxRange = matchRange.location + matchRange.length
            if maxRange + 1 < length {
              addAttributes(normalAttrs, range: NSMakeRange(maxRange, 1))
            }
          }
        }
      }
      catch {
        print("An error occurred attempting to locate pattern: \(error.localizedDescription)")
      }
    }
  }
  
  func performReplacementsForRange(changedRange: NSRange) {
    var extendedRange =
      NSUnionRange(changedRange,
                   NSString(string: backingStore.string).lineRange(for: NSMakeRange(changedRange.location, 0)))
    extendedRange =
      NSUnionRange(changedRange,
                   NSString(string: backingStore.string).lineRange(for: NSMakeRange(NSMaxRange(changedRange), 0)))
    applyStylesToRange(searchRange: extendedRange)
  }
  
  override func processEditing() {
    performReplacementsForRange(changedRange: editedRange)
    super.processEditing()
  }
  
  func createAttributesForFontStyle(_ style: UIFont.TextStyle, withTrait trait: UIFontDescriptor.SymbolicTraits) -> [NSAttributedString.Key: Any] {
      let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
      let descriptorWithTrait = fontDescriptor.withSymbolicTraits(trait)
      let font = UIFont(descriptor: descriptorWithTrait!, size: 0)
      return [.font: font]
  }
  
  func createHighlightPatterns() {
    let scriptFontDescriptor = UIFontDescriptor(fontAttributes: [.family: "Zapfino"])
    
    // 1
    let bodyFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
    let bodyFontSize = bodyFontDescriptor.fontAttributes[.size] as! NSNumber
    let scriptFont = UIFont(descriptor: scriptFontDescriptor, size: CGFloat(bodyFontSize.floatValue))
    
    // 2. create the attributes
    let boldAttributes = createAttributesForFontStyle(.body, withTrait:.traitBold)
    let italicAttributes = createAttributesForFontStyle(.body, withTrait:.traitItalic)
    let strikeThroughAttributes =  [NSAttributedString.Key.strikethroughStyle: 1]
    let scriptAttributes = [NSAttributedString.Key.font: scriptFont]
    let redTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    
    // 3. construct a dictionary of replacements based on regexes
    replacements = [
      "(\\*\\w+(\\s\\w+)*\\*)": boldAttributes,
      "(_\\w+(\\s\\w+)*_)": italicAttributes,
      "([0-9]+\\.)\\s": boldAttributes,
      "(-\\w+(\\s\\w+)*-)": strikeThroughAttributes,
      "(~\\w+(\\s\\w+)*~)": scriptAttributes,
      "\\s([A-Z]{2,})\\s": redTextAttributes
    ]
  }
  
  func update() {
    let bodyFont = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
    addAttributes(bodyFont, range: NSMakeRange(0, length))
    
    createHighlightPatterns()
    applyStylesToRange(searchRange: NSMakeRange(0, length))
  }
}
