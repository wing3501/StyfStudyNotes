//
//  UsingGestures.swift
//  TestAnim
//
//  Created by styf on 2022/11/25.
//  How to use Gestures In SwiftUI 手势使用汇总
//  https://www.swiftanytime.com/gestures-in-swiftui/

//  Using complex gestures in a SwiftUI ScrollView 在滚动视图中使用复杂手势
//  https://danielsaidi.com/blog/2022/11/16/using-complex-gestures-in-a-scroll-view

//  Applying complex gestures to a SwiftUI view 使用一个拖拽手势给view实现多种手势
//  https://danielsaidi.com/blog/2022/11/24/applying-complex-gestures-to-a-swiftui-view
//  https://github.com/danielsaidi/SwiftUIKit

import SwiftUI

struct UsingGestures: View {
    var body: some View {
        VStack {
            TapGestures()
            LongPressGesture1()
            MagnificationGestures()
            Problem1()
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
// 长按手势阻止了滚动事件问题
struct Problem1: View {
    @State var tapCount = 0
    var body: some View {
        VStack {
            Text("\(tapCount) taps")
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0...100, id: \.self) { _ in
//                        listItem
//                            .onTapGesture { print("Tap") } // 仍然工作
//                            .onLongPressGesture { print("Long press") } // ❌ 红方块上的左右滑动不可用
//                            .gesture(  // 使用gesture也一样不可用，使用DragGesture也一样
//                                LongPressGesture()
//                                    .onChanged { _ in print("Long press changed") }
//                                    .onEnded { _ in print("Long press ended") }
//                            )
                        // ✅ 原因是长按、拖动手势，窃取了滚动视图的滑动手势事件，而点击手势不会窃取
                        
                        // 第一种解决方案
//                            .onTapGesture { print("Tap") }
//                                .gesture(
//                                    LongPressGesture()
//                                        .onEnded { _ in print("Long press") }
//                                )
                        // 但是换成simultaneousGesture后，又不可用了
//                            .onTapGesture { print("Tap") }
//                                .simultaneousGesture(
//                                    LongPressGesture()
//                                        .onEnded { _ in print("Long press") }
//                                )
                        
                        // 第二种解决方案 ButtonStyle
                        ScrollViewGestureButton(longPressTime: 2) {
                            print("press")
                        } releaseAction: {
                            print("release")
                        } endAction: {
                            print("end")
                        } longPressAction: {
                            print("longPress")
                        } doubleTapAction: {
                            print("doubleTap")
                        } label: {
                            listItem
                        }
                    }
                }
            }
        }
    }

    var listItem: some View {
        Color.red
            .frame(width: 100, height: 100)
    }
}


struct UsingGestures_Previews: PreviewProvider {
    static var previews: some View {
        UsingGestures()
    }
}
