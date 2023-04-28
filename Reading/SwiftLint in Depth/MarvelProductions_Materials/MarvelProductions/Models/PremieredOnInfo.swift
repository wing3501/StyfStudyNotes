/// Copyright (c) 2023 Kodeco Inc.
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

import Foundation

public enum PremieredOnInfo {
  case definedDate(Date)
  case estimatedYear(Int)
  case unknown

  public static func fromString(_ value: String) -> Self {
    let yearOnlyRegexString: String = #"\d{4}"#
    let datesRegexString: String = #"\S{3,4}\s.{1,2},\s\d{4}"#

    guard let yearOnlyRegex = try? Regex(yearOnlyRegexString),
      let datesRegex = try? Regex(datesRegexString) else {
      return .unknown
    }

    if let match = value.wholeMatch(of: yearOnlyRegex) {
      let result = match.first?.value as! Substring
      return .estimatedYear(Int(result)!)
    } else if let match = value.wholeMatch(of: datesRegex) {
      let result = match.first?.value as! Substring
      let dateStr = String(result)
      let date = Date.fromString(dateStr)
      return .definedDate(date)
    }

    return .unknown
  }

  func toString() -> String {
    switch self {
    case .definedDate(let date):
      return "\(date.toString())"
    case .estimatedYear(let year):
      return "In \(year)"
    case .unknown:
      return "Not Announced"
    }
  }
}

extension Date {
  static func fromString(_ dateString: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    let date = formatter.date(from: dateString)!
    return date
  }

  func toString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    let string = formatter.string(from: self)
    return string
  }
}
