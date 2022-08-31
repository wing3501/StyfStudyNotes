//
//  CenteringTheView.swift
//
//
//  Created by styf on 2022/8/30.
//  在 SwiftUI 中实现视图居中的若干种方法 https://www.fatbobman.com/posts/centering_the_View_in_SwiftUI/

import SwiftUI

struct CenteringTheView: View {
    var body: some View {
        example5
    }
    
    var hello: some View {
        Text("Hello world")
            .foregroundColor(.white)
            .font(.title)
            .lineLimit(1)
    }
    
    var example1: some View {
        HStack {
            Spacer(minLength: 0)// ✅ 垫片有最小宽度8
            hello
            Spacer(minLength: 0)
        }
        .frame(width: 300, height: 60)
        .background(.blue)
    }
    
    var example2: some View {
        VStack {
          // Hello world 视图 1
          HStack {
                Spacer(minLength: 0)
                hello
                Spacer(minLength: 0)
            }
            .frame(width: 300, height: 60)
//            .background(.blue) // 从 SwiftUI 3.0 开始，在使用 background 添加符合 ShapeStyle 协议的元素时，可以通过 ignoresSafeAreaEdges 参数设置是否忽略安全区域，默认值为 .all （ 忽略任何的安全区域 ）。
            .background(.blue, ignoresSafeAreaEdges: [])// ✅排除掉不希望忽略的安全区域。
            
          HStack {
                Spacer(minLength: 0)
                hello
                Spacer(minLength: 0)
            }
            .frame(width: 300, height: 60) // 相同的尺寸
            .background(.red)
        
          Spacer() // 让 VStack 充满可用空间
      }
    }
    
    var example3: some View {
        // HStack 的高度是由容器子视图对齐排列后的高度决定的
        List {
            HStack {
                Spacer(minLength: 0)
                hello
                Spacer(minLength: 0)
            }
            .frame(maxHeight: .infinity) // ✅ 用满建议高度
            .background(.blue)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0)) // 将 Row 的 Insets 设置为 0
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 80) // 设置 List 最小行高度
    }
    
    var example4: some View {
        // ✅其他填充物，需要配合layoutPriority、spacing
        // Rectangle().opacity(0)
        // Color.blue.opacity(0)
        // ContainerRelativeShape().fill(.clear)
        HStack {
            Color.clear
                .layoutPriority(0)
            hello
                .layoutPriority(1)
            Color.clear
                .layoutPriority(0)
        }
        .frame(width: 300, height: 60)
        .background(Color.cyan)
    }
    
    var example5: some View {
        // ✅ 常用frame
        hello
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.pink)
    }
    
    var example6: some View {
        // ✅ overlay
        Rectangle() // 直接使用 Color.orange 也可以
            .fill(Color.orange)
            .frame(width: 300, height: 60)
            .overlay(hello) // 相当于 .overlay(hello,alignment: .center)
    }
    
    var example7: some View {
        // ✅ GeometryReader
        GeometryReader { proxy in
            hello
                .position(.init(x: proxy.size.width / 2, y: proxy.size.height / 2))
                .background(Color.brown)
        }
        .frame(width: 300, height: 60)
        
//        GeometryReader 将获得 300 x 60 的建议尺寸
//        由于 GeometryReader 拥有与 Color、Rectangle 类似的特征，会将给定的建议尺寸作为需求尺寸（ 表现为占用全部可用空间 ）
//        GeometryReader 给 Text 提供 300 x 60 的建议尺寸
//        GeometryReader 中的视图，默认基于 topLeading 对齐（ 类似 overlay(alignment:.topLeading) 的效果 ）
//        使用 postion 将 Text 的中心点与给定的位置进行对齐（ postion 是一个通过 CGPoint 来对齐中心点的视图修饰器 ）
    }
}

struct CenteringTheView_Previews: PreviewProvider {
    static var previews: some View {
        CenteringTheView()
    }
}
