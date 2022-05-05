//
//  Measure.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/29.
//

import SwiftUI

struct Measure: View {
    var body: some View {
//        Overlay 和 Background
        
//        Text("Hello").background(
//            Capsule()
//                .stroke()
//                .padding(-5) )
        
//        Circle()
//            .fill(.blue)
//            .frame(width: 75, height: 75, alignment: .center)
//            .overlay(content: {
//                Circle()
//                    .strokeBorder(.white)
//                    .padding(3)
//            })
//            .overlay {
//                Text("确定")
//                    .foregroundColor(.white)
//            }
        
//        裁切和遮罩
//        Rectangle()
//            .fill(.red)
//            .frame(width: 100, height: 100, alignment: .center)
//            .rotationEffect(.degrees(45))
//            .clipped()//加上 .clipped 修饰器，对这个旋转后的矩形来说，只有在父 view 的边界框中的部分可见
        
//        clipShape 方法，和 clipped 不同，它接受一个形状作为裁剪蒙版，而不是直 接使用边界矩形
//        我们可以通过 .mask 来提供遮罩。mask 和 clipped 的不同在于，mask 可以接受任意的 view
        
//        Stack View
        
//        MeasureBehavior(content: HStack {
//            Text("Hello, World")
//            Rectangle().fill(Color.red).frame(minWidth: 200)
//            })
        
//        布局优先级
//        HStack(spacing: 0) {
//            Text(longPath).truncationMode(.middle).lineLimit(1)
//            Text("chapter1.md").layoutPriority(1)
//        }
        
//        记住 stack 布局的过程的描述:
//        在第一轮，stack 的 layout 方法决定每个子 view 的尺寸是固 定的还是可变的。
//        在第二轮，可变的空间被分配给可变子 view。
//        当布局优先级被设置时，第二 轮会更加复杂一些。元素们会被按照布局优先级分组:拥有最高布局优先级的组将会首先被提 供可变空间，然后是第二高的组，以此类推。
        
//        如果最高布局优先级的组包含真正可变的元素 (没有任何约束)，这意味着其他组将不会得到任 何空间。不过，布局优先级在大部分时候都用来处理那些有最大宽度的元素。
    }
}

struct MeasureBehavior<Content: View>: View {
    @State private var width: CGFloat = 100
    @State private var height: CGFloat = 100
    var content: Content
    
    var body: some View {
        VStack {
            content
                .border(.gray)
                .frame(width: width, height: height, alignment: .center)
                .border(.black)
            Slider(value: $width, in: 0...500)
            Slider(value: $height, in: 0...200)
        }
    }
}

struct Measure_Previews: PreviewProvider {
    static var previews: some View {
        Measure()
    }
}
