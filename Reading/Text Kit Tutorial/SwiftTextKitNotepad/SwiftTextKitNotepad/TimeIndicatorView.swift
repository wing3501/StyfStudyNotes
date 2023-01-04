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

class TimeIndicatorView: UIView {
  let fillColor = UIColor(red: 0.329, green: 0.584, blue: 0.898, alpha: 1)
  var label = UILabel()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init(date: Date) {
    super.init(frame: CGRect.zero)
    
    // Initialization code
    backgroundColor = .clear
    clipsToBounds = false
    
    // format and style the date
    let formatter = DateFormatter()
    formatter.dateFormat = "dd\rMMMM\ryyyy"
    let formattedDate = formatter.string(from: date)
    label.text = formattedDate.uppercased()
    label.textAlignment = .center
    label.textColor = .white
    label.numberOfLines = 0
    
    addSubview(label)
  }
  
  func updateSize() {
    // size the label based on the font
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.frame = CGRect(x: 0, y: 0, width: .max, height: .max)
    label.sizeToFit()
    
    // set the frame to be large enough to accomodate the circle that surrounds the text
    let radius = radiusToSurroundFrame(label.frame)
    frame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
    
    // center the label within this circle
    label.center = center
    
    // offset the center of this view to ... erm ... can I just draw you a picture?
    // You know the story - the designer provides a mock-up with some static data, leaving
    // you to work out the complex calculations required to accomodate the variability of real-world
    // data. C'est la vie!
    let padding: CGFloat = 5.0
    center = CGPoint(x: center.x + label.frame.origin.x - padding, y: center.y - label.frame.origin.y + padding)
  }
  
  // calculates the radius of the circle that surrounds the label
  func radiusToSurroundFrame(_ frame: CGRect) -> CGFloat {
    return max(frame.width, frame.height) * 0.5 + 20.0
  }
  
  func curvePathWithOrigin(_ origin: CGPoint) -> UIBezierPath {
    return UIBezierPath(arcCenter: origin, radius: radiusToSurroundFrame(label.frame), startAngle: -.pi, endAngle: .pi, clockwise: true)
  }
  
  override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    context?.setShouldAntialias(true)
    let path = curvePathWithOrigin(label.center)
    fillColor.setFill()
    path.fill()
  }
}
