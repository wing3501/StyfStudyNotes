//
//  LearnLayoutProtocolPart2.swift
//  TestAnim
//
//  Created by styf on 2022/9/23.
//  https://swiftui-lab.com/layout-protocol-part-2/

import SwiftUI

struct LearnLayoutProtocolPart2: View {
    let colors: [Color] = [.yellow, .orange, .red, .pink, .purple, .blue, .cyan, .green]
    @State var radius: CGFloat = 130
    @State var angle: Angle = .zero
    
    @State var rotations: [Angle] = Array<Angle>(repeating: .zero, count: 16)
    
    var body: some View {
        VStack {
            WheelLayout(radius: radius, rotation: angle) {
                ForEach(0..<16) { idx in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(colors[idx%colors.count].opacity(0.7))
                        .frame(width: 70, height: 70)
                        .overlay { Text("\(idx+1)") }
                        .rotationEffect(rotations[idx])
                        .layoutValue(key: Rotation.self, value: $rotations[idx])
                    
                    // 封装简化
//                    WheelComponent {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(colors[idx%colors.count].opacity(0.7))
//                            .frame(width: 70, height: 70)
//                            .overlay { Text("\(idx+1)") }
//                    }
                }
            }
            Button("Rotate") {
                withAnimation(.easeInOut(duration: 2.0)) {
                    angle = (angle == .zero ? .degrees(90) : .zero)
//                    radius = (radius == 130 ? 100 : 130)
                }
            }
        }
    }
}

struct WheelComponent<V: View>: View {
    @ViewBuilder let content: () -> V
    @State private var rotation: Angle = .zero
    
    var body: some View {
        content()
            .rotationEffect(rotation)
            .layoutValue(key: Rotation.self, value: $rotation)
    }
}
// ✅ 使用LayoutValueKey，从Layout向子视图反向传递数据
struct Rotation: LayoutValueKey {
    static let defaultValue: Binding<Angle>? = nil
}

// ✅ 圆形布局
struct WheelLayout: Layout {
    var radius: CGFloat
    var rotation: Angle
    // ✅ 添加animatableData 就可以实现圆形路径动画了
//    var animatableData: CGFloat {
//        get { rotation.radians }
//        set { rotation = .radians(newValue) }
//    }
    // 支持多个参数
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(rotation.radians, radius) }
        set {
            rotation = Angle.radians(newValue.first)
            radius = newValue.second
        }
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        // 找到子视图中的最大宽，最大高
        let maxSize = subviews.map { $0.sizeThatFits(proposal) }.reduce(CGSize.zero) {
            return CGSize(width: max($0.width, $1.width), height: max($0.height, $1.height))
        }
        
        return CGSize(width: (maxSize.width / 2 + radius) * 2,
                      height: (maxSize.height / 2 + radius) * 2)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ())
    {
        let angleStep = (Angle.degrees(360).radians / Double(subviews.count)) // 每一步的弧度

        for (index, subview) in subviews.enumerated() {
            // 0度从正上方开始
            let angle = angleStep * CGFloat(index) + rotation.radians
            
            // Find a vector with an appropriate size and rotation.
            var point = CGPoint(x: 0, y: -radius).applying(CGAffineTransform(rotationAngle: angle))
            
            // Shift the vector to the middle of the region.
            point.x += bounds.midX
            point.y += bounds.midY
            
            // Place the subview.
            subview.place(at: point, anchor: .center, proposal: .unspecified) // 以中心为锚点
            
            // ✅ 避免布局循环
            DispatchQueue.main.async {
                subview[Rotation.self]?.wrappedValue = .radians(angle)
            }
        }
    }
}

// ✅ 使用类型擦除，可以调用系统方法 AnyLayout(HStackLayout(spacing: 0)).sizeThatFits(...) // it is possible!
// 当我们处理其他布局时，我们可以扮演SwiftUI的角色。子布局的任何缓存创建和更新都属于我们的责任。幸运的是，这很容易处理。我们只需要将子布局缓存添加到我们自己的缓存中。
//struct ComposedLayout: Layout {
//    private let hStack = AnyLayout(HStackLayout(spacing: 0))
//    private let vStack = AnyLayout(VStackLayout(spacing: 0))
//
//    struct Caches {
//        var topCache: AnyLayout.Cache
//        var centerCache: AnyLayout.Cache
//        var bottomCache: AnyLayout.Cache
//    }
//
//    func makeCache(subviews: Subviews) -> Caches {
//        Caches(topCache: hStack.makeCache(subviews: topViews(subviews: subviews)),
//               centerCache: vStack.makeCache(subviews: centerViews(subviews: subviews)),
//               bottomCache: hStack.makeCache(subviews: bottomViews(subviews: subviews)))
//    }
//
//    // ...
//}

struct LearnLayoutProtocolPart2_Previews: PreviewProvider {
    static var previews: some View {
        LearnLayoutProtocolPart2()
    }
}
