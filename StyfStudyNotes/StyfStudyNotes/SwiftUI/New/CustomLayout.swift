//
//  CustomLayout.swift
//  TestAnim
//
//  Created by styf on 2022/12/9.
//  使用Layout 协议构建自定义布局
//  Building custom layout in SwiftUI. Basics.  https://swiftwithmajid.com/2022/11/16/building-custom-layout-in-swiftui-basics/
//  Building custom layout in SwiftUI. Caching. https://swiftwithmajid.com/2022/11/29/building-custom-layout-in-swiftui-caching/
//  Building custom layout in SwiftUI. Spacing. https://swiftwithmajid.com/2022/12/06/building-custom-layout-in-swiftui-spacing/

// ✅ Layout protocol有两个方法需要实现
// sizeThatFits  必须计算，并返回布局的最终尺寸
// placeSubviews  根据你的布局规则，放置子视图

// ✅ Layout protocol有一个关联类型Cache
// 默认是Void, 但是我们可以实现为任何类型。最简单的办法是在我们自己的Layout类型中，内嵌一个Cache
// makeCache 我们可以实现它来提供缓存实例，并在布局更改期间进行一些初始计算以存储。

import SwiftUI

struct CustomLayout: View {
    var body: some View {
//        ✅ 基本使用：用Layout实现流式布局
        FlowLayoutDemo()
//        ✅ Layout中加入间距
        FlowLayoutDemo1()
    }
}



struct FlowLayoutDemo: View {
    var body: some View {
        FlowLayout {
            ForEach(0..<5) { _ in
                Group {
                    Text("Hello")
                        .font(.largeTitle)
                    Text("World")
                        .font(.title)
                    Text("!!!")
                        .font(.title3)
                }
                .border(Color.red)
            }
        }
    }
}

struct FlowLayoutDemo1: View {
    var body: some View {
        FlowLayout(spacing: 8) {
            Text("Hello")
                .font(.largeTitle)
            Text("World")
                .font(.title)
            Text("!!!")
                .font(.title3)
        }
        .border(Color.red)
    }
}

// ✅ 2 缓存的使用
extension FlowLayout {
    struct Cache {
        var sizes: [CGSize] = []
        var spacing: [CGFloat] = [] // 使用首选间距
    }
    
    // 📢 两个方法都没提供proposedSize和bounds，所以无法计算准确位置。
    //    但是允许在sizeThatFits、placeSubview中改变缓存
    
    // Layout协议具有makeCache函数，我们可以实现它来提供缓存实例，并在布局更改期间进行一些初始计算以存储。
//    func makeCache(subviews: Subviews) -> Cache {
//        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
//        return Cache(sizes: sizes)
//    }
    
    func makeCache(subviews: Subviews) -> Cache {
        // 使用首选间距
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let spacing: [CGFloat] = subviews.indices.map { index in
            guard index != subviews.count - 1 else {
                return 0
            }
            
            return subviews[index].spacing.distance(
                to: subviews[index+1].spacing,
                along: .horizontal
            )
        }
        return Cache(sizes: sizes, spacing: spacing)
    }
    
    // 实现updateCache函数，来更新缓存
    func updateCache(_ cache: inout Cache, subviews: Subviews) {
        cache.sizes = subviews.map { $0.sizeThatFits(.unspecified) }
    }
}

// ✅ 1 基本使用：用Layout实现流式布局
struct FlowLayout: Layout {
    // ✅ 3 在Layout中使用间距
//    var spacing: CGFloat = 0
    var spacing: CGFloat? = nil // 使用首选间距
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        // 询问所有子视图理想尺寸，可以使用zero 和 infinity来获取最小和最大尺寸
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var totalHeight: CGFloat = 0
        var totalWidth: CGFloat = 0
        
        var lineWidth: CGFloat = 0
        var lineHeight: CGFloat = 0
          
          for size in sizes {
            if lineWidth + size.width > proposal.width ?? 0 {
                totalHeight += lineHeight
                lineWidth = size.width
                lineHeight = size.height
            } else {
                lineWidth += size.width
                lineHeight = max(lineHeight, size.height)
            }

            totalWidth = max(totalWidth, lineWidth)
          }

        totalHeight += lineHeight
        
        return .init(width: totalWidth, height: totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {

        // ✅ bounds就是放置子视图的区域，不能假设它的起点为(0,0)

        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }

        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = 0

        for index in subviews.indices {
            if lineX + sizes[index].width > (proposal.width ?? 0) {
                lineY += lineHeight
                lineHeight = 0
                lineX = bounds.minX
            }

            let position = CGPoint(x: lineX + sizes[index].width / 2,
                                   y: lineY + sizes[index].height / 2)

            // 可以在这里更新缓存

            subviews[index].place(
                at: position,
                anchor: .center,
                proposal: ProposedViewSize(sizes[index])
            )

            lineHeight = max(lineHeight, sizes[index].height)
            lineX += sizes[index].width
        }
    }
    
    func placeSubviews1(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) {
        // ✅ 使用缓存
        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = 0
        
        for index in subviews.indices {
            if lineX + cache.sizes[index].width > (proposal.width ?? 0) {
                lineY += lineHeight
                lineHeight = 0
                lineX = bounds.minX
            }
            
            let position = CGPoint(
                x: lineX + cache.sizes[index].width / 2,
                y: lineY + cache.sizes[index].height / 2
            )
            
            // you can populate cache
            // with additional information here
            
            lineHeight = max(lineHeight, cache.sizes[index].height)
            lineX += cache.sizes[index].width
            
            subviews[index].place(
                at: position,
                anchor: .center,
                proposal: ProposedViewSize(cache.sizes[index])
            )
        }
    }
    
    
//    func sizeThatFits1(
//        proposal: ProposedViewSize,
//        subviews: Subviews,
//        cache: inout Cache
//    ) -> CGSize {
//        // ✅ 增加间距
//        var totalHeight = 0.0
//        var totalWidth = 0.0
//
//        var lineWidth = 0.0
//        var lineHeight = 0.0
//
//        for index in subviews.indices {
//            if lineWidth + cache.sizes[index].width > proposal.width ?? 0 {
//                totalHeight += lineHeight
//                lineWidth = cache.sizes[index].width
//                lineHeight = cache.sizes[index].height
//            } else {
//                lineWidth += cache.sizes[index].width + spacing
//                lineHeight = max(lineHeight, cache.sizes[index].height)
//            }
//
//            totalWidth = max(totalWidth, lineWidth)
//        }
//
//        totalHeight += lineHeight
//
//        return .init(width: totalWidth, height: totalHeight)
//    }
    
//    func placeSubviews2(
//        in bounds: CGRect,
//        proposal: ProposedViewSize,
//        subviews: Subviews,
//        cache: inout Cache
//    ) {
//        // ✅ 增加间距
//        var lineX = bounds.minX
//        var lineY = bounds.minY
//        var lineHeight: CGFloat = 0
//
//        for index in subviews.indices {
//            if lineX + cache.sizes[index].width > (proposal.width ?? 0) {
//                lineY += lineHeight
//                lineHeight = 0
//                lineX = bounds.minX
//            }
//
//            let position = CGPoint(
//                x: lineX + cache.sizes[index].width / 2,
//                y: lineY + cache.sizes[index].height / 2
//            )
//
//            lineHeight = max(lineHeight, cache.sizes[index].height)
//            lineX += cache.sizes[index].width + spacing
//
//            subviews[index].place(
//                at: position,
//                anchor: .center,
//                proposal: ProposedViewSize(cache.sizes[index])
//            )
//        }
//    }
    
    
    func sizeThatFits3(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) -> CGSize {
        // 使用首选间距
        var totalHeight = 0.0
        var totalWidth = 0.0
        
        var lineWidth = 0.0
        var lineHeight = 0.0
        
        for index in subviews.indices {
            if lineWidth + cache.sizes[index].width > proposal.width ?? 0 {
                totalHeight += lineHeight
                lineWidth = cache.sizes[index].width
                lineHeight = cache.sizes[index].height
            } else {
                lineWidth += cache.sizes[index].width + (spacing ?? cache.spacing[index])
                lineHeight = max(lineHeight, cache.sizes[index].height)
            }
            
            totalWidth = max(totalWidth, lineWidth)
        }
        
        totalHeight += lineHeight
        
        return .init(width: totalWidth, height: totalHeight)
    }
    
    func placeSubviews3(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) {
        // 使用首选间距
        var lineX = bounds.minX
        var lineY = bounds.minY
        var lineHeight: CGFloat = 0
        
        for index in subviews.indices {
            if lineX + cache.sizes[index].width > (proposal.width ?? 0) {
                lineY += lineHeight
                lineHeight = 0
                lineX = bounds.minX
            }
            
            let position = CGPoint(
                x: lineX + cache.sizes[index].width / 2,
                y: lineY + cache.sizes[index].height / 2
            )
            
            lineHeight = max(lineHeight, cache.sizes[index].height)
            lineX += cache.sizes[index].width + (spacing ?? cache.spacing[index])
            
            subviews[index].place(
                at: position,
                anchor: .center,
                proposal: ProposedViewSize(cache.sizes[index])
            )
        }
    }
}


