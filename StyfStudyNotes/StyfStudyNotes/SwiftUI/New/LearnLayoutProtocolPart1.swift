//
//  LearnLayoutProtocolPart1.swift
//
//
//  Created by styf on 2022/9/23.
//  https://swiftui-lab.com/layout-protocol-part-1/

// ✅ Layout 目前不支持懒加载容器
// ✅ Layout 不是View,没有body


import SwiftUI

struct LearnLayoutProtocolPart1: View {
    var body: some View {
//        Example2()
        
//        SimpleHStackTest()
//        LayoutAlignmentTest()
        LayoutPriorityTest()
    }
    // 示例1： 子视图需要的，比建议的，更少
    // 1 HStack 建议((400 – 40) / 3 = 120)
    // 2 Text只需要74,回报给HStack
    // 3 HStack把额外的分给其他子视图
    
    // 示例2： Shape是一个例子，接受提供给它们的任何内容
    struct Example1: View {
        var body: some View {
            HStack(spacing: 0) {
                 Rectangle().fill(.green)

                 Text("Hello World!")
                    .background(.purple)

                 Rectangle().fill(.green)
             }
             .padding(20)
             .background(.yellow)
        }
    }
    
    // 示例3： 子视图要求的比建议的多
    // 结果是，图片按300绘制了，但是父视图把它当作只有100宽一样去布局其他视图
    struct Example2: View {
        var body: some View {
            HStack(spacing: 0) {

                Rectangle().fill(.yellow)

                Image("peach") //除非使用了resizable，否则需要多少空间就占多少空间
                    .frame(width: 100)// 300x300的图但是限制了100
                    .border(.black, width: 3)
                    .zIndex(1)

                Rectangle().fill(.yellow)

            }
            .padding(20)
        }
    }
    
    // ✅ 当文本需要的尺寸，比建议尺寸更多时，会有多种表现，取决于我们怎么配置视图
    // 1. 文本截断
    // 2. 文本垂直增长
    // 3. 如果使用了fixedSize修饰符，甚至会像上个例子中的Image一样溢出。
    // ✅ fixedSize告诉视图使用理想尺寸，无论提供的大小有多小
    
    
    // ✅ 父级使用ProposedViewSize告诉子级如何计算自己的大小
    // 对于具体宽度，例如45.0，父级正好提供45.0磅，视图应该为所提供的宽度确定自己的大小。
    // 对于0.0宽度，子级应使用其最小大小进行响应。
    // 对于无限宽，子级应使用其最大大小进行响应。
    // 如果值为零，孩子应该以其理想大小作出反应。
    
    // ✅ SwiftUI将调用我们的sizeThatFits方法，以使用我们的布局确定容器的大小。在写这种方法时，我们应该把自己看作是父母和孩子：我们是父母，要求孩子查看他们的尺寸。但我们也是一个孩子，根据孩子的回答，告诉父母我们的尺寸。
    
    // ✅ 案例： SimpleHStack 不管建议尺寸，始终返回理想的尺寸
    struct SimpleHStackTest: View {
        var body: some View {
            VStack(spacing: 20) {
                
                HStack(spacing: 5)  {
                    contents()
                }
                .border(.blue)
                
                SimpleHStack(spacing: 5) {
                    contents()
                }
                .border(.blue)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
        }
        
        @ViewBuilder func contents() -> some View {
            Image(systemName: "globe.americas.fill")
            
            Text("Hello, World!")

            Image(systemName: "globe.europe.africa.fill")
        }
    }
    
    // ✅ 案例： 布局协议还允许我们为容器定义对齐指南
    struct LayoutAlignmentTest: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    contents()
                }
                .border(.black)

                SimpleHStack(spacing: 5) {
                    contents()
                }
                .border(.red)
                
                HStack(spacing: 5) {
                    contents()
                }
                .border(.black)
                
            }
            .background { Rectangle().stroke(.green) }
            .padding()
            .font(.largeTitle)
                
        }
        
        @ViewBuilder func contents() -> some View {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
    }
    
    // ✅ 案例： 使用布局优先级
    struct LayoutPriorityTest: View {
        var body: some View {
            SimpleHStack(spacing: 5) {
                Circle().fill(.yellow)
                     .frame(width: 30, height: 30)
                                    
                Circle().fill(.green)
                    .frame(width: 30, height: 30)

                Circle().fill(.blue)
                    .frame(width: 30, height: 30)
//                    .layoutPriority(1) //蓝色会排在最前面
//                    .layoutValue(key: PreferredPosition.self, value: 1.0)
                    .preferredPosition(1)
            }
        }
    }
    // ✅ Layout没有实现View,却能被当作View来用，是因为 callAsFunction
    struct CallAsFunctionTest: View {
        var body: some View {
            SimpleHStack(spacing: 10).callAsFunction({
                Text("Hello World!")
            })
            // SE-0253之后可以简略
            SimpleHStack(spacing: 10) {
                Text("Hello World!")
            }
            
        }
    }
    // ✅ Layout可以更好的实现布局动画变换
    struct AnyLayoutTest: View {
        @State var isVertical = false
        
        var body: some View {
            let layout = isVertical ? AnyLayout(VStackLayout(spacing: 5)) : AnyLayout(HStackLayout(spacing: 10))
            
            layout {
                Group {
                    Image(systemName: "globe")
                    
                    Text("Hello World!")
                }
                .font(.largeTitle)
            }
            
            Button("Toggle Stack") {
                withAnimation(.easeInOut(duration: 1.0)) {
                    isVertical.toggle()
                }
            }
        }
    }
}

struct PreferredPosition: LayoutValueKey {
    static let defaultValue: CGFloat = 0.0
}

extension View {
    func preferredPosition(_ order: CGFloat) -> some View {
        self.layoutValue(key: PreferredPosition.self, value: order)
    }
}

extension LayoutSubview {
    var preferredPosition: CGFloat {
        self[PreferredPosition.self]
    }
}

struct SimpleHStack: Layout {
    var spacing: CGFloat? = nil
    // ✅ 缓存的使用
    // 1 创建一个类型用来保存缓存数据,这里是 CacheData
    // 2 实现makeCache(subviews:) 创建缓存
    // 3 (可选) 实现 updateCache(subviews:)。默认的实现是调用makeCache创建缓存
    // 4 记得在 sizeThatFits 和 placeSubviews中更新缓存
    
    typealias Cache = CacheData
    
    struct CacheData {
        var maxHeight: CGFloat
        var spaces: [CGFloat]
    }
    
    func makeCache(subviews: Subviews) -> CacheData {
        return CacheData(maxHeight: computeMaxHeight(subviews: subviews),
                         spaces: computeSpaces(subviews: subviews))
    }
    
    func updateCache(_ cache: inout CacheData, subviews: Subviews) {
        cache.maxHeight = computeMaxHeight(subviews: subviews)
        cache.spaces = computeSpaces(subviews: subviews)
    }
    
    func computeMaxHeight(subviews: LayoutSubviews) -> CGFloat {
        return subviews.map { $0.sizeThatFits(.unspecified) }.reduce(0) { max($0, $1.height) }
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout CacheData) -> CGSize {
        let idealViewSizes = subviews.map { $0.sizeThatFits(.unspecified) } // 挨个询问子视图的理想尺寸
        
//        let spacing = spacing * CGFloat(subviews.count - 1)
//        let widths = spacing + idealViewSizes.reduce(0) { $0 + $1.width }// 宽度累加
//        let height = idealViewSizes.reduce(0) { max($0, $1.height) } // 高度取最高
        
        // ✅ 使用默认间距
//        let accumulatedWidths = idealViewSizes.reduce(0) { $0 + $1.width }
//        let maxHeight = idealViewSizes.reduce(0) { max($0, $1.height) }
//        let spaces = computeSpaces(subviews: subviews)
//        let accumulatedSpaces = spaces.reduce(0) { $0 + $1 }
//
//        return CGSize(width: accumulatedSpaces + accumulatedWidths,
//                      height: maxHeight)
        
        // ✅ 使用cache
        let accumulatedWidths = idealViewSizes.reduce(0) { $0 + $1.width }
        let accumulatedSpaces = cache.spaces.reduce(0) { $0 + $1 }
        
        return CGSize(width: accumulatedSpaces + accumulatedWidths,
                      height: cache.maxHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout CacheData)
    {
        var pt = CGPoint(x: bounds.minX, y: bounds.minY)
                
//        for v in subviews.sorted(by: { $0.priority > $1.priority }) {// 加入布局优先级的逻辑。❌ 但是不建议将优先级用于顺序
//            v.place(at: pt, anchor: .topLeading, proposal: .unspecified)
//
//            pt.x += v.sizeThatFits(.unspecified).width + spacing
//        }
        
        // ✅ 使用 LayoutValueKey 来实现位置的逻辑
//        let sortedViews = subviews.sorted { v1, v2 in
//            v1[PreferredPosition.self] > v2[PreferredPosition.self]
//        }
//
//        for v in sortedViews {
//            v.place(at: pt, anchor: .topLeading, proposal: .unspecified)
//
//            pt.x += v.sizeThatFits(.unspecified).width + spacing
//        }
        
//        for v in subviews.sorted(by: { $0.preferredPosition > $1.preferredPosition }) {
//            v.place(at: pt, anchor: .topLeading, proposal: .unspecified)
//
//            pt.x += v.sizeThatFits(.unspecified).width + spacing
//        }
        
        // ✅ 查询间距
//        let spaces = computeSpaces(subviews: subviews)
//
//        for idx in subviews.indices {
//            subviews[idx].place(at: pt, anchor: .topLeading, proposal: .unspecified)
//
//            if idx < subviews.count - 1 {
//                pt.x += subviews[idx].sizeThatFits(.unspecified).width + spaces[idx]
//            }
//        }
        
        // ✅ 使用cache
        for idx in subviews.indices {
            subviews[idx].place(at: pt, anchor: .topLeading, proposal: .unspecified)
            
            if idx < subviews.count - 1 {
                pt.x += subviews[idx].sizeThatFits(.unspecified).width + cache.spaces[idx]
            }
        }
    }
    
    func explicitAlignment(of guide: HorizontalAlignment, in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGFloat? {
        if guide == .leading {
            // ✅ 案例： 布局协议还允许我们为容器定义对齐指南
            // 调整整个SimpleHStack，与其他HStack的对齐
            return subviews[0].sizeThatFits(proposal).width + (spacing ?? 0)
        } else {
            return nil
        }
    }
    
    func computeSpaces(subviews: LayoutSubviews) -> [CGFloat] {
        if let spacing {
            return Array<CGFloat>(repeating: spacing, count: subviews.count - 1)
        } else {
            return subviews.indices.map { idx in
                guard idx < subviews.count - 1 else { return CGFloat(0) }
                
                return subviews[idx].spacing.distance(to: subviews[idx+1].spacing, along: .horizontal)
            }
        }

    }
    
    // ✅ Layout还有一个静态属性  stackOrientation告诉像Spacer这样的视图应该在水平轴还是垂直轴上展开。
    static var layoutProperties: LayoutProperties {
        var properties = LayoutProperties()
        
        properties.stackOrientation = .vertical
        
        return properties
    }
    
    // ✅ Layout的cache 可以提高布局性能。也可以将其视为存储我们需要跨sizeThatFits和placeSubviews调用持久化的数据的地方
}


struct LearnLayoutProtocol_Previews: PreviewProvider {
    static var previews: some View {
        LearnLayoutProtocolPart1()
    }
}
