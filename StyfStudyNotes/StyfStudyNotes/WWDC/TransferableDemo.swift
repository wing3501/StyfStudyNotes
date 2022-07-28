//
//  TransferableDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/18.
//  【WWDC22 10062】初见 Transferable  https://xiaozhuanlan.com/topic/7965203418
//   透過 SwiftUI 的 ShareLink 來分享文本和圖像等資料   https://www.appcoda.com.tw/swiftui-sharelink/

import SwiftUI

struct TransferableDemo: View {
//    @State private var portrait: Image
    
    var body: some View {
        
        VStack {
            PasteButton(payloadType: String.self) { pastedString in
                
            }
//            ShareLink(item: portrait)
//            ShareLink(
//                        item: portrait,
//                        preview: SharePreview("Birthday Effects")
//                    )
//            ShareLink(item: url) {
//                Label("Tap me to share", systemImage:  "square.and.arrow.up")
//            }
            
            // 我們可以使用 subject 參數和 message 參數，分別為 URL 或想分享的項目添加 title 和描述。
//            ShareLink(item: url, subject: Text("Check out this link"), message: Text("If you want to learn Swift, take a look at this website.")) {
//                Image(systemName: "square.and.arrow.up")
//            }
//            private let photo = Image("bigben")
//            ShareLink(item: photo, preview: SharePreview("Big Ben", image: photo))
        }
        
    }
}

struct PortraitView: View {
  @State var portrait: Image // 👈🏻 Transferable type

  var body: some View {
    portrait
      .cornerRadius(8)
      .draggable(portrait) // 👈🏻 支持 drag
      .dropDestination(payloadType: Image.self) { (images: [Image], _) in // 👈🏻 支持 drop
        if let image = images.first {
          portrait = image
          return true
        }
        return false
      }
  }
}

struct NSItemProviderDemo: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .onDrag {
                    NSItemProvider(object: "Hello World" as NSString)
                }
            Rectangle()
                .fill(.gray)
                .frame(width: 200, height: 200)
                .onDrop(of: [.image], isTargeted: nil) { providers in
                    for provider in providers {
                        if provider.canLoadObject(ofClass: UIImage.self) {
                            provider.loadObject(ofClass: UIImage.self) { item, error in
                                if let image = item as? UIImage {
                                    // handle image
                                } else {
                                    print(error?.localizedDescription)
                                }
                            }
                            return true
                        }
                    }
                    return false
                }
        }
    }
}

struct TransferableDemo_Previews: PreviewProvider {
    static var previews: some View {
        TransferableDemo()
    }
}
