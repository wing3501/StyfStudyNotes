//
//  ImageLoader.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/12.
//

import Combine
import SwiftUI

class ImageLoader: ObservableObject {
  var didChange = PassthroughSubject<UIImage, Never>()
  var image = UIImage() {
    didSet {
      didChange.send(image)
    }
  }

  init(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    let task = URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let data = data else { return }
      DispatchQueue.main.async {
        self.image = UIImage(data: data) ?? UIImage()
      }
    }
    task.resume()
  }
}

