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

import Foundation

extension Notification.Name {
    static let dataRefreshNeeded = Notification.Name("dataRefreshNeeded")
}

struct DataStore {
  func dataFileURL() -> URL? {
      let fileManager = FileManager.default
      
      do {
          // 使用documentDirectory会保存到沙盒内的文档文件夹
          let docsFolder = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
          let dataURL = docsFolder.appendingPathComponent("Timeato_Tasks.json")
          return dataURL
      } catch {
          print("URL error:\(error.localizedDescription)")
          return nil
      }
  }

  func readTasks() -> [Task] {
    guard let url = dataFileURL() else {
      return []
    }

    do {
      let data = try Data(contentsOf: url)
      let tasks = try JSONDecoder()
        .decode([Task].self, from: data)
      return tasks
    } catch {
      print("Read error: \(error.localizedDescription)")
      return []
    }
  }

  func save(tasks: [Task]) {
    guard
      let url = dataFileURL(),
      let data = try? JSONEncoder().encode(tasks)
    else {
      return
    }
    do {
      try data.write(to: url)
    } catch {
      print("Save error: \(error.localizedDescription)")
    }
  }
}
