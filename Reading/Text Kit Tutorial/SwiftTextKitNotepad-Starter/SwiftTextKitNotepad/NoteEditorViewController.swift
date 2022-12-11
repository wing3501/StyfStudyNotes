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

class NoteEditorViewController: UIViewController {
//  @IBOutlet var textView: UITextView!
    
    var textView: UITextView!
    var textStorage: SyntaxHighlightTextStorage!

  
  var note: Note!
    
    var timeView: TimeIndicatorView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    createTextView()

    textView.isScrollEnabled = true
//    textView.text = note.contents
    navigationController?.navigationBar.barStyle = .black

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardDidShow),
                                           name: UIResponder.keyboardDidShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardDidHide),
                                           name: UIResponder.keyboardDidHideNotification,
                                           object: nil)
    // ✅ 1 响应系统字体动态变化，需要这两行
//    textView.font = .preferredFont(forTextStyle: .body)
    textView.adjustsFontForContentSizeCategory = true
    // ✅ 4.1 添加排除路径
    timeView = TimeIndicatorView(date: note.timestamp)
    textView.addSubview(timeView)
  }
  
    
    override func viewDidLayoutSubviews() {
      updateTimeIndicatorFrame()
        
        textStorage.update()

    }
      
    func updateTimeIndicatorFrame() {
        // ✅ 4.2 添加排除路径
      timeView.updateSize()
      timeView.frame = timeView.frame
        .offsetBy(dx: textView.frame.width - timeView.frame.width, dy: 0)
        
     let exclusionPath = timeView.curvePathWithOrigin(timeView.center)
     textView.textContainer.exclusionPaths = [exclusionPath]

    }

    
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  func updateTextViewSizeForKeyboardHeight(keyboardHeight: CGFloat) {
    textView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - keyboardHeight)
  }
    // ✅ 5 使用自定义TextStorage
    func createTextView() {
      // 1 初始化自定义TextStorage
      let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
      let attrString = NSAttributedString(string: note.contents, attributes: attrs)
      textStorage = SyntaxHighlightTextStorage()
      textStorage.append(attrString)
        
      let newTextViewRect = view.bounds
        
      // 2 初始化NSLayoutManager
      let layoutManager = NSLayoutManager()
        
      // 3 初始化NSTextContainer,NSLayoutManager关联NSTextContainer,NSTextStorage 关联NSLayoutManager
      let containerSize = CGSize(width: newTextViewRect.width,
                                 height: .greatestFiniteMagnitude)
      let container = NSTextContainer(size: containerSize)
      container.widthTracksTextView = true //宽度变化是否影响text container size
      layoutManager.addTextContainer(container)
      textStorage.addLayoutManager(layoutManager)
    
      // 4 使用NSTextContainer
      textView = UITextView(frame: newTextViewRect, textContainer: container)
      textView.delegate = self
      view.addSubview(textView)

      // 5
      textView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        textView.topAnchor.constraint(equalTo: view.topAnchor),
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
    }


  @objc func keyboardDidShow(notification: NSNotification) {
    if let rectValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
      let keyboardSize = rectValue.cgRectValue.size
      updateTextViewSizeForKeyboardHeight(keyboardHeight: keyboardSize.height)
    }
  }
  
  @objc func keyboardDidHide(notification: NSNotification) {
    updateTextViewSizeForKeyboardHeight(keyboardHeight: 0)
  }
}

// MARK: - UITextViewDelegate
extension NoteEditorViewController: UITextViewDelegate {
  func textViewDidEndEditing(_ textView: UITextView) {
    note.contents = textView.text
  }
}
