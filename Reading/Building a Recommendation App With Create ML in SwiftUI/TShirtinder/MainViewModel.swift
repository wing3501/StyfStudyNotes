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

@MainActor
final class MainViewModel: ObservableObject {
  private var allShirts: [FavoriteWrapper<Shirt>] = []
  @Published private(set) var shirts: [Shirt] = []
  @Published private(set) var recommendations: [Shirt] = []

  private let recommendationStore: RecommendationStore
  
  private var recommendationsTask: Task<Void, Never>?

  init(recommendationStore: RecommendationStore = RecommendationStore()) {
    self.recommendationStore = recommendationStore
  }

  func loadAllShirts() async {
    guard let url = Bundle.main.url(forResource: "shirts", withExtension: "json") else {
      return
    }

    do {
      let data = try Data(contentsOf: url)
      allShirts = (try JSONDecoder().decode([Shirt].self, from: data)).shuffled().map {
        FavoriteWrapper(model: $0)
      }
      shirts = allShirts.map(\.model)
    } catch {
      print(error.localizedDescription)
    }
  }

  func didRemove(_ item: Shirt, isLiked: Bool) {
    shirts.removeAll { $0.id == item.id }
    if let index = allShirts.firstIndex(where: { $0.model.id == item.id }) {
      allShirts[index] = FavoriteWrapper(model: item, isFavorite: isLiked)
    }
    
    // 1
    recommendationsTask?.cancel()

    // 2
    recommendationsTask = Task {
      do {
        // 3 计算推荐
        let result = try await recommendationStore.computeRecommendations(basedOn: allShirts)

        // 4 
        if !Task.isCancelled {
          recommendations = result
        }
      } catch {
        // 5
        print(error.localizedDescription)
      }
    }

  }

  func resetUserChoices() {
    shirts = allShirts.map(\.model)
    recommendations = []
  }
}
