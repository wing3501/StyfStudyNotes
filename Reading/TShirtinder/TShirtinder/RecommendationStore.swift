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
import TabularData
#if canImport(CreateML)
import CreateML
#endif


final class RecommendationStore {
  
  private let queue = DispatchQueue(
    label: "com.recommendation-service.queue",
    qos: .userInitiated)

  
  func computeRecommendations(basedOn items: [FavoriteWrapper<Shirt>]) async throws -> [Shirt] {
    return try await withCheckedThrowingContinuation { continuation in
      queue.async {
        #if targetEnvironment(simulator)
        continuation.resume(
          throwing: NSError(
            domain: "Simulator Not Supported",
            code: -1
          )
        )
        #else
        let trainingData = items.filter {
          $0.isFavorite != nil
        }
        // 用于训练模型
        let trainingDataFrame = self.dataFrame(for: trainingData)
        
        let testData = items
        let testDataFrame = self.dataFrame(for: testData)

        do {
          // 1 创建线性回归
          let regressor = try MLLinearRegressor(
            trainingData: trainingDataFrame,
            targetColumn: "favorite")
          
          let predictionsColumn = (try regressor.predictions(from: testDataFrame))
            .compactMap { value in
              value as? Double
            }
          // 数据排序
          let sorted = zip(testData, predictionsColumn) // 1
            .sorted { lhs, rhs -> Bool in // 2
              lhs.1 > rhs.1
            }
            .filter { // 3
              $0.1 > 0
            }
            .prefix(10) // 4
          
          let result = sorted.map(\.0.model)
          continuation.resume(returning: result)

        } catch {
          // 2
          continuation.resume(throwing: error)
        }

        #endif

      }

    }

  }
  
  private func dataFrame(for data: [FavoriteWrapper<Shirt>]) -> DataFrame {
    // 1
    var dataFrame = DataFrame()

    // 2 将数据排列成列和行。每列都有一个名称。为颜色创建一个列
    dataFrame.append(column: Column(
      name: "color",
      contents: data.map(\.model.color.rawValue))
    )

    // 3
    dataFrame.append(column: Column(
      name: "design",
      contents: data.map(\.model.design.rawValue))
    )

    dataFrame.append(column: Column(
      name: "neck",
      contents: data.map(\.model.neck.rawValue))
    )

    dataFrame.append(column: Column(
      name: "sleeve",
      contents: data.map(\.model.sleeve.rawValue))
    )

    // 4 附加另一列以记录每个项目的收藏夹状态。如果值不是nil并且为true，则添加1。但是，如果为false，则添加-1。如果值为nil，则添加0表示用户尚未对此做出决定。这一步使用数字，而不是布尔值，因此您可以稍后应用回归算法。
    dataFrame.append(column: Column<Int>(
        name: "favorite",
        contents: data.map {
          if let isFavorite = $0.isFavorite {
            return isFavorite ? 1 : -1
          } else {
            return 0
          }
        }
      )
    )

    // 5
    return dataFrame

  }

}
