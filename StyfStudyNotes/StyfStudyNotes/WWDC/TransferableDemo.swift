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
            // SwiftUI 也新增了 PasteButton 和 ShareLink 两种系统的视图来方便开发者实现复制和分享的功能，两者也都只需要提供支持 Transferable 的类型即可：
            // 👇🏻 实现 Transferable 的类型
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
// ✅ 正确的方式
struct PortraitView: View {
  @State var portrait: Image // 👈🏻 Transferable type
//    因为 String、Image、Data、URL、AttributedString 这几个系统的类型都已经默认实现了 Transferable
  var body: some View {
//    portrait
//      .cornerRadius(8)
//      .draggable(portrait) // 👈🏻 支持 drag
//      .dropDestination(payloadType: Image.self) { (images: [Image], _) in // 👈🏻 支持 drop
//        if let image = images.first {
//          portrait = image
//          return true
//        }
//        return false
//      }
      //报错，暂时注释
      EmptyView()
  }
}

// 🤔 以前的处理方式
struct NSItemProviderDemo: View {
    var body: some View {
        VStack {
            // 比如下面的例子就是支持把文本拖拽到别的 app 的实现，还需要将 String 转换成 NSString：
            // 除了不够 Swift，回调也没有类型保证
            Text("Hello World")
                .onDrag {
                    NSItemProvider(object: "Hello World" as NSString)
                }
            // 比如下面的例子，只是接收图片就得处理一堆分支，非常蛋疼，更不用说支持多个类型的内容了
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
