//
//  LayoutTestView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/28.
//

import SwiftUI

struct LayoutTestView: View {
    
    @State var selectedIndex = 0
    
    let names = [
    "onevcat | Wei Wang", "zaq | Hao Zang", "tyyqa | Lixiao Yang"
    ]
    
    @State var doSelect = true
    
    var body: some View {
//        HStack {
//            Image(systemName: "person.circle")
//            Text("User:")
//            Text("onevcat | Wei Wang")
//        }
//        .lineLimit(1)
        
//        HStack {
//          Image(systemName: "person.circle")
//            .background(Color.yellow)
//          Text("User:")
//            .background(Color.red)
//          Text("onevcat | Wei Wang")
//            .background(Color.green)
//        }
//        .lineLimit(1)
//        .frame(width: 200, alignment: .leading)
//        .frame(width: 200)
        
//        默认情况下，布局优先级都是 0
//        HStack {
//          Image(systemName: "person.circle")
//            .background(Color.yellow)
//          Text("User:")
//            .background(Color.red)
//        Text("onevcat | Wei Wang")
//            .layoutPriority(1)
//            .background(Color.green)
//        }
//        .lineLimit(1)
//        .frame(width: 200)
        
//        可以使用 fixedSize。这个 modifier 将提示布局系统忽 略掉外界条件，让被修饰的 View 使用它在无约束下原本应有的理想尺寸。
//        HStack {
//          Image(systemName: "person.circle")
//            .background(Color.yellow)
//
//        Text("User:")
//            .background(Color.red)
//          Text("onevcat | Wei Wang")
//            .layoutPriority(1)
//            .background(Color.green)
//        }
//        .lineLimit(1)
//        .fixedSize()
//        .frame(width: 200)
        
//        alignmentGuide使用
//        通过 alignmentGuide，我们可以进一步调整 View 在容器 (比如各类 Stack) 中的对 齐方式
//        它负责修改 g (HorizontalAlignment 或者 VerticalAlignment) 的对齐方式，把原来 的 defaultValue(in:) 所提供的默认值，用 computeValue 的返回值进行替代。
//        HStack(alignment: .center) {
//          Text("User:")
//            .font(.footnote)
//            .alignmentGuide(VerticalAlignment.center) { d in
//                d[.bottom]
//                //对于 “User:”，返回的是 d[.bottom]，也即 Text 的底边作为对齐线
////                注意，只 有当 alignmentGuide 的第一个参数 VerticalAlignment.center 和 HStack 的 alignment 参数一致时，它才会被考虑。因为 alignmentGuide API 的作用就 是修改传入的 alignment 的数值。
//            }
//          Image(systemName: "person.circle")
//          Text("onevcat | Wei Wang")
        
        
//        如果显式定义了 .leading，则在计算 center 这个 alignmentGuide 实际作 用时，就可以通过 explicit 的下标方法读取它，并将它加到对齐中去。在这里的 HStack 里，可能看不太出这么做的意义。不过在 ZStack 中，同时会涉及到水平和 竖直两种情况，如果两个方向上的对齐方式具有相关性，那么 d[explicit:] 就非常有 用了。
//        HStack(alignment: .center) {
//            Text("User:")
//                .font(.footnote)
//                .alignmentGuide(.leading) { _ in
//                    10
//                }
//                .alignmentGuide(VerticalAlignment.center) { d in
//                    d[.bottom] + (d[explicit: .leading] ?? 0)
//                }
//
//              Image(systemName: "person.circle")
//              Text("onevcat | Wei Wang")
//        }
        
        
//        自定义 Alignment 和跨 View 对齐
        HStack(alignment: .select, spacing: 0) {
//            对于上标 Text，以底部为基准，再加上选中的行到整个 HStack 上端的总高 度。这会将 “User:” 上标文本固定在 HStack 最上方且超出自身一半高度的位 置上。
            Text("User:")
                .font(.footnote)
                .foregroundColor(.green)
                .alignmentGuide(.select) { d in
                    d[.bottom] + CGFloat(selectedIndex) * 20.3
                }
            Image(systemName: "person.circle")
                .foregroundColor(.green)
                .alignmentGuide(.select) { d in
//                    明确指定 Image 的中心部位应该和其他部分对齐。
                    d[VerticalAlignment.center]
                }
//            VStack 有自 己的布局规则，那就是顺次将每个子 View 竖直放置。在这个基础上，我们把 被选中行的中线位置设定成了对齐位置。这样，SwiftUI 将尝试在满足 VStack 的竖直叠放特性的同时，去满足把选中行和 HStack 中其他部分的对齐。
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<names.count) { index in
                    if index == selectedIndex {
                        Text(names[index])
                            .foregroundColor(.green)
                            .alignmentGuide(.select) { d in
                                    d[VerticalAlignment.center]
                                }
                    }else {
                        Text(names[index])
                            .onTapGesture {
                                selectedIndex = index
                            }
                    }
                }
            }
        }
        .animation(.linear(duration: 0.2), value: true)
    }
}

extension VerticalAlignment {
    struct SelectAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
//            这个方法需要返回一个 CGFloat，该数字代表了使用对齐方式时 View 的偏移量
            context[VerticalAlignment.center] //通过 HorizontalAlignment 或者 VerticalAlignment 以下标的方式从 ViewDimensions 中获取数据。默认情况下，它会返回对应 alignment 的 defaultValue 方法的返回值。
        }
    }
    
    static let select = VerticalAlignment(SelectAlignment.self)
}

extension VerticalAlignment {
    struct MyCenter: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context.height / 2  //我们指定对齐位置为 height 值的一半，这恰好就是竖直方 向上各个 View 的水平中线所在位置。
        }
    }
    static let myCenter = VerticalAlignment(MyCenter.self)
}

struct LayoutTestView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutTestView()
    }
}

//  alignmentGuide 案例
struct HeartView: View {
    var body: some View {
        Circle()
            .fill(.yellow)
            .frame(width: 30, height: 30)
            .overlay(Image(systemName: "heart").foregroundColor(.red))
    }
}

struct ButtonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.blue.gradient)
            .frame(width: 150, height: 50)
    }
}

// ZStack
struct IconDemo1: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ButtonView()
            HeartView()
                .alignmentGuide(.top, computeValue: { $0.height / 2 })
                .alignmentGuide(.trailing, computeValue: { $0.width / 2 })
        }
    }
}

// overlay
struct IconDemo2: View {
    var body: some View {
        ButtonView()
            .overlay(alignment: .topTrailing) {
                HeartView()
                    .alignmentGuide(.top, computeValue: { $0.height / 2 })
                    .alignmentGuide(.trailing, computeValue: { $0.width / 2 })
            }
    }
}

// background
struct IconDemo3: View {
    var body: some View {
            HeartView()
            .background(alignment:.center){
                ButtonView()
                    .alignmentGuide(HorizontalAlignment.center, computeValue: {$0[.trailing]})
                    .alignmentGuide(VerticalAlignment.center, computeValue: {$0[.top]})
            }
    }
}
