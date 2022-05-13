//
//  StacksGridsScrollviews.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/12.
//

import SwiftUI

struct StacksGridsScrollviews: View {
    var body: some View {
        ScrollView {
            //模糊效果
            VisualEffectBlurs()
            //LazyVStack、LazyHStack使用
            LazyVStackAndLazyHStack()
            //网格布局
            LazyVGridAndLazyHGrid()
            //滚动视图的3D效果
            ScrollView3DEffects()
            //滚动到指定位置
            UsingScrollViewReader()
            //滚动视图的使用
            UsingScrollView()
            //使用SizeClasses来适配屏幕
            UsingSizeClasses()
            //使用ZStack
            UsingZStack()
            //使用固定尺寸的Spacer
            FixedSizeSpacer()
            UsingVStackAndHStack()
        }
    }
}

struct VisualEffectBlurs: View {
    var body: some View {
        TestWrap("模糊效果") {
            ZStack {
                Image("header")
                    .resizable()
                    .frame(height: 150)

                Text("Visit Singapore")
                    .foregroundColor(.secondary) //如果使用的是.secondary，SwiftUI会自动调整文本颜色，使其具有鲜明的效果，并能从背景中脱颖而出
                    .padding()
//                    .background(.thinMaterial)
                    .background(.ultraThinMaterial)
                
//                    .ultraThinMaterial
//                    .thinMaterial
//                    .regularMaterial
//                    .thickMaterial
//                    .ultraThickMaterial
            }
        }
    }
}

struct LazyVStackAndLazyHStack: View {
    var body: some View {
        //⚠️ LazyStack 会在第一次显示视图时创建，之后把保留在内存中
        TestWrap("LazyVStack LazyHStack实现懒加载") {
            LazyVStack2()
            LazyVStack1()
        }
    }
}

struct LazyVStack1: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...100, id: \.self) { value in
                    Text("Row \(value)") //和常规VStack不一样，Text占据了整行
                }
            }
        }
        .frame(height: 300)
    }
}

struct LazyVStack2: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...100, id: \.self, content: SampleRow.init)
            }
        }
        .frame(height: 300)
    }
}

struct SampleRow: View {
    let id: Int

    var body: some View {
        Text("Row \(id)")
    }

    init(id: Int) {
        print("Loading row \(id)")
        self.id = id
    }
}

struct LazyVGridAndLazyHGrid: View {
    var body: some View {
        TestWrap("Grid网格布局") {
            
            GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
            HGrid1()
            
            VGrid3()//一列固定宽，一列占满
            VGrid2()//固定列数
            VGrid1()//固定最小宽度
        }
    }
}

struct HGrid1: View {
    let items = 1...50

    let rows = [
        GridItem(.fixed(50)),
        GridItem(.fixed(50))
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, alignment: .center) {
                ForEach(items, id: \.self) { item in
                    Image(systemName: "\(item).circle.fill")
                        .font(.largeTitle)
                }
            }
            .frame(height: 150)
        }
    }
}

struct VGrid1: View {
    let data = (1...100).map { "Item \($0)" }

    let columns = [
        GridItem(.adaptive(minimum: 80))//意味着我们希望网格在每行中容纳尽可能多的项目，每个项目的最小大小为80。
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    Text(item)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 300)
    }
}

struct VGrid2: View {
    let data = (1...100).map { "Item \($0)" }

    let columns = [ //5列
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    Text(item)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 300)
    }
}

struct VGrid3: View {
    let data = (1...100).map { "Item \($0)" }

    let columns = [
        GridItem(.fixed(100)),
        GridItem(.flexible()),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    Text(item)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 300)
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct ScrollView3DEffects: View {
    @State var dragAmount = CGSize.zero
    var body: some View {
        TestWrap("GeometryReader和rotation3DEffect实现特效") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(1..<20) { num in
                        VStack {
                            GeometryReader { geo in
                                Text("Number \(num)")
                                    .font(.largeTitle)
                                    .padding()
                                    .background(Color.red)
                                    .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).minX) / 8), axis: (x: 0, y: 1, z: 0))//对着y轴进行翻转
                                    .frame(width: 200, height: 200)
                            }
                            .frame(width: 200, height: 200)
                        }
                    }
                }
            }
            //使用手势来实现3D效果
//            VStack {
//                Rectangle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                    .frame(width: 200, height: 150)
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                    .rotation3DEffect(.degrees(-Double(dragAmount.width) / 20), axis: (x: 0, y: 1, z: 0))
//                    .rotation3DEffect(.degrees(Double(dragAmount.height / 20)), axis: (x: 1, y: 0, z: 0))
//                    .offset(dragAmount)
//                    .gesture(
//                        DragGesture()
//                            .onChanged { dragAmount = $0.translation }
//                            .onEnded { _ in
//                                withAnimation(.spring()) {
//                                    dragAmount = .zero
//                                }
//                            }
//                    )
//            }
//            .frame(width: 400, height: 400)
        }
    }
}

struct UsingScrollViewReader: View {
    let colors: [Color] = [.red, .green, .blue]
    var body: some View {
        TestWrap("使用ScrollViewReader让ScrollView滚动到指定位置") {
            ScrollView {
                ScrollViewReader { value in
                    Button("Jump to #8") {
                        withAnimation {
//                            value.scrollTo(8) //按下按钮时，它将直接滚动到ID为8的框,scrollTo对 List也适用
                            value.scrollTo(8, anchor: .top)
                        }
                    }
                    .padding()

                    ForEach(0..<100) { i in
                        Text("Example \(i)")
                            .font(.title)
                            .frame(width: 200, height: 200)
                            .background(colors[i % colors.count])
                            .id(i)
                    }
                }
            }
            .frame(height: 350)
        }
    }
}

struct UsingScrollView: View {
    var body: some View {
        TestWrap("ScrollView的使用") {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<10) {
                        Text("Item \($0)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(width: 200, height: 200)
                            .background(Color.red)
                    }
                }
            }
            .frame(height: 350)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<10) {
                        Text("Item \($0)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(width: 200, height: 200)
                            .background(Color.red)
                    }
                }
            }
        }
    }
}

struct UsingSizeClasses: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        TestWrap("使用SizeClasses切换布局") {
            if horizontalSizeClass == .compact {
                Text("Compact")
            } else {
                Text("Regular")
            }
        }
    }
}

struct UsingZStack: View {
    var body: some View {
        TestWrap("zIndex更改层级") {
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 50, height: 50)
                    .zIndex(1) //视图的默认Z索引为0，但您可以提供正值或负值，将它们分别放置在其他视图的顶部或下方。

                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct FixedSizeSpacer: View {
    var body: some View {
        TestWrap("使用Spacer设定精确间隔") {
            VStack {
                Text("First Label")
//                Spacer(minLength: 50)
//                    .frame(height: 50)
//                    .frame(minHeight: 50, maxHeight: 500) //会自动取最大
                Text("Second Label")
            }
        }
    }
}

struct UsingVStackAndHStack: View {
    var body: some View {
        TestWrap("使用VStack HStack") {
            VStack(alignment: .leading) {//与左侧边缘对齐，但它们最终仍将位于屏幕中间，因为堆栈只占用所需的空间。
                Text("SwiftUI")
                Text("rocks")
            }
        }
    }
}

struct StacksGridsScrollviews_Previews: PreviewProvider {
    static var previews: some View {
        StacksGridsScrollviews()
    }
}
