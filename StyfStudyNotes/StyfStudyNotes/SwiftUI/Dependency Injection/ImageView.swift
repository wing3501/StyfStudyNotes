//
//  ImageView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/12.
//

import SwiftUI

struct ImageView: View {
  @ObservedObject var imageLoader: ImageLoader
  @State var image = UIImage(named: "img_placeholder", in: Bundle(for: ImageLoader.self), with: nil) ?? UIImage()

  init(withURL url: String) {
    self.imageLoader = ImageLoader(urlString: url)
  }

  var body: some View {
    Image(uiImage: image)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .onReceive(imageLoader.didChange) { image in
        self.image = image
      }
  }
}

struct ImageView_Previews: PreviewProvider {
  static var previews: some View {
    Image(uiImage: UIImage(named: "img_placeholder") ?? UIImage())
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: 100, height: 100)
      .clipped()
  }
}

