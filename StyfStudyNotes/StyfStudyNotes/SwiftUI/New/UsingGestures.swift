//
//  UsingGestures.swift
//  TestAnim
//
//  Created by styf on 2022/11/25.
//  How to use Gestures In SwiftUI 手势使用汇总
//  https://www.swiftanytime.com/gestures-in-swiftui/

import SwiftUI

struct UsingGestures: View {
    var body: some View {
        VStack {
            TapGestures()
            LongPressGesture1()
            MagnificationGestures()
        }
    }
}
struct TapGestures: View {
    var body: some View {
        GroupBox {
            VStack(alignment: .center, spacing: 20) {
                Text("每次触发")
                    .onTapGesture {
                        print("View Tapped")
                    }
                
                Text("快速点三次才触发")
                     .onTapGesture(count: 3) {
                         print("View tapped mulitple times")
                      }
            }
        }
    }
}

struct LongPressGesture1: View {
    @State var backgroundColor = Color.orange
    
    var body: some View {
        GroupBox {
            TimelineView(.animation) { context in
                //        Button {
                //                  print("Button Tapped")
                //              } label : {
                Label("\(context.date)", systemImage: "play") // 1 实际测试中，把按钮去掉了才响应长按
                //              }
                                  .padding()
                                  .foregroundColor(.black)
                                  .background(Color.orange)
                                  .cornerRadius(10)
                                  .onLongPressGesture  {
                                      print("Long Press Gesture") // 2
                                  }
                
                Label("Start", systemImage: "play")
                    .padding()
                    .background(backgroundColor) // 1
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 3) { isPressing in // 2 最少长按3秒
                        if isPressing == true { // 3
                            self.backgroundColor = .red
                        } else {
                            self.backgroundColor = .orange
                        }
                    } perform: { // 4
                        print("Long Press Gesture")
                    }

            }
        }
    }
}

struct MagnificationGestures: View {
    @State var zoomScale = 1.0 // 1
       var body: some View {
           
           Image(systemName: "photo.fill") // 2
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(width: 100, height: 100)
               .scaleEffect(zoomScale) // 3
               .gesture( // 4 捏合放大
               MagnificationGesture()
                   .onChanged({ amount in
                       print("----\(amount)")
                      zoomScale += amount
                   })
           )
           
       }
}
struct UsingGestures_Previews: PreviewProvider {
    static var previews: some View {
        UsingGestures()
    }
}
