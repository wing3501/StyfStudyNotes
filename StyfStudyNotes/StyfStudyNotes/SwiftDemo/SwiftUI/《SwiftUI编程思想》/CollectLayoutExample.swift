//
//  CollectLayoutExample.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/5.
//

import SwiftUI
import CoreMIDI

struct CollectLayoutExample: View {
    let colors: [(Color, CGFloat)] = [(.red, 50), (.green, 30), (.blue, 75)]
    @State var horizontal = true
    var body: some View {
        VStack {
            Button {
                withAnimation(.default) {
                    horizontal.toggle()
                }
            } label: {
                Text("Toggle axis")
            }
            
            Stack(elements: colors, spacing: 8, axis: horizontal ? .horizontal : .vertical) { item in
                Rectangle()
                    .fill(item.0)
                    .frame(width: item.1, height: item.1)
            }
            .border(.black)
        }
        
    }
}

struct CollectSizePreference: PreferenceKey {
    static var defaultValue: [Int: CGSize] = [:]
    static func reduce(value: inout [Int : CGSize], nextValue: () -> [Int : CGSize]) {
        //合并字典，如果有重复Key，直接取第二个值
        value.merge(nextValue(), uniquingKeysWith: {$1})
    }
}

struct CollectSize: ViewModifier {
    var index: Int
    func body(content: Content) -> some View {
        content.background(GeometryReader(content: { proxy in
            Color.clear.preference(key: CollectSizePreference.self, value: [self.index: proxy.size])
        }))
    }
}

struct Stack<Element,Content: View>: View {
    var elements: [Element]
    var spacing: CGFloat = 8
    var axis: Axis = .horizontal
    var alignment: Alignment = .topLeading
    var content: (Element) -> Content
    @State private var offsets: [CGPoint] = []
    
    var body: some View {
        ZStack(alignment: alignment) {
            ForEach(elements.indices) { idx in
                content(elements[idx])
                    .modifier(CollectSize(index: idx))
                    .alignmentGuide(alignment.horizontal) { viewDimensions in
                        axis == .horizontal ? -offset(at: idx).x : viewDimensions[alignment.horizontal]
                    }
                    .alignmentGuide(alignment.vertical) { viewDimensions in
                        axis == .vertical ? -offset(at: idx).y : viewDimensions[alignment.vertical]
                    }
            }
        }
        .onPreferenceChange(CollectSizePreference.self, perform: computeOffsets(sizes:))
    }
    
    private func computeOffsets(sizes: [Int: CGSize]) {
//        在 computeOffsets 方法里，我们可以在同一轮里将所有子 view 的水平和竖直偏移量都计算出 来
        var offsets: [CGPoint] = [.zero]
        for idx in 0..<elements.count {
            guard let size = sizes[idx] else { fatalError() }
            var newPoint = offsets.last!
            newPoint.x += size.width + spacing
            newPoint.y += size.height + spacing
            offsets.append(newPoint)
        }
        self.offsets = offsets
    }
    // 获取指定子 view 的偏移量值
    private func offset(at index: Int) -> CGPoint {
        guard index < offsets.endIndex else { return .zero }
        return offsets[index]
    }
}

struct CollectLayoutExample_Previews: PreviewProvider {
    static var previews: some View {
        CollectLayoutExample()
    }
}
