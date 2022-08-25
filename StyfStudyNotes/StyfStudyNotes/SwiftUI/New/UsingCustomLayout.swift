//
//  UsingCustomLayout.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/25.
//  Custom Layout in SwiftUI: https://sarunw.com/posts/swiftui-custom-layout/
//  【WWDC22 10056】在 SwiftUI 中组合各种自定义布局: https://xiaozhuanlan.com/topic/1507368249

import SwiftUI

struct UsingCustomLayout: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        //需求1：需求是所有按钮的宽度与最宽的那个按钮保持一致。
        
        //需求2：可以不可以有什么智能的方式，在合适屏幕空间选择合适的布局容器呢？
        //        SwiftUI 提供了新的布局容器选择器 ViewThatFits，我们可以把它当做一个容器视图的集合，它可以自动选择合适的容器视图来适配屏幕的空间。
//            ViewThatFits {
//                MyEqualWidthHStack {
//                    Button()
//                }
//                MyEqualWidthVStack {
//                    Button()
//                }
//            }
        //需求3：宠物排名组件
//            使用 AnyLayout 来让同一个视图的不同布局切换时平滑过渡。使用 AnyLayout 可以避免重新创建一个新的视图，这样过渡动画也会十分的自然
//            let layout = isThreeWayTie ? AnyLayout(HStack()) : AnyLayout(VStack())
    }
}

//需求1：需求是所有按钮的宽度与最宽的那个按钮保持一致。
struct MyEqualWidthHStack1: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxSize = maxSize(subviews: subviews)
        
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) { $0 + $1 }
        
        return CGSize(width: maxSize.width * CGFloat(subviews.count) + totalSpacing, height: maxSize.height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)
        
        let sizeProposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
        var x = bounds.minX + maxSize.width / 2
        
        for index in subviews.indices {
            subviews[index].place(at: CGPoint(x: x, y: bounds.midY), anchor: .center, proposal: sizeProposal)
            x += maxSize.width + spacing[index]
        }
    }
    
    private func maxSize(subviews: Subviews) -> CGSize {
        var maxSize: CGSize = .zero
        for subview in subviews {
            let size = subview.sizeThatFits(ProposedViewSize.infinity)
            if (size.width > maxSize.width) || (size.width == maxSize.width && size.height > maxSize.height) {
                maxSize = size
            }
        }
        return maxSize
    }
    
    private func spacing(subviews: Subviews) -> [CGFloat] {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(to: subviews[index + 1].spacing, along: .horizontal)
        }
    }
}

struct UsingCustomLayout_Previews: PreviewProvider {
    static var previews: some View {
        UsingCustomLayout()
    }
}
