//
//  ViewLayoutDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/11.
//

import SwiftUI

struct ViewLayoutDemo: View {
    var body: some View {
        //在安全区域放置内容
//        UsingSafeAreaInset()
        //突破安全区域
//        OutsideTheSafeArea()

        ScrollView {
            //使用foregroundStyle设置预设样式、或者统一设置渐变色等
            UsingForegroundStyle()
            //让多个视图尺寸相同的技巧
            MakeTwoViewsSameWidthHeight()
            //布局优先级的使用
            UsingLayoutPriority()
            //使用ForEach
            UsingForEach()
            //返回不同View报错的几种解决办法
            ReturnDifferentViewTypes()
            //获取建议尺寸
            UsingGeometryReader()
            //使用边距
            UsingPadding()
            //使用frame
            ViewCustomFrame()
        }
    }
}

struct UsingSafeAreaInset: View {
    var body: some View {
        NavigationView {
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle("Select a row")
            .safeAreaInset(edge: .bottom) {
                Text("Outside Safe Area")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.indigo)
            }
            
//            .safeAreaInset(edge: .bottom, spacing: 100) {//增大最后一行和下面的距离
//                Text("Outside Safe Area")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(.indigo)
//            }
            
            //类似悬浮按钮的效果
//            .safeAreaInset(edge: .bottom, alignment: .trailing) {
//                    Button {
//                        print("Show help")
//                    } label: {
//                        Image(systemName: "info.circle.fill")
//                            .font(.largeTitle)
//                            .symbolRenderingMode(.multicolor)
//                            .padding(.trailing)
//                    }
//                    .accessibilityLabel("Show help")
//            }
        }
    }
}

struct OutsideTheSafeArea: View {
    var body: some View {
//        TestWrap("把视图放到SafeArea之外") {
            Text("Hello World")
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                .background(Color.red)
                .ignoresSafeArea()
//                .safeAreaInset(edge: <#T##VerticalEdge#>, alignment: <#T##HorizontalAlignment#>, spacing: <#T##CGFloat?#>, content: <#T##() -> View#>)  //它允许我们在安全区域外放置不同的内容，同时调整剩余的安全区域，使其所有内容保持可见。
//        }
    }
}

struct UsingForegroundStyle: View {
    var body: some View {
        TestWrap("使用foregroundStyle控制整体样式") {
            VStack {
                HStack {
                    Image(systemName: "clock.fill")
                    Text("Set the time")
                }
                .font(.largeTitle.bold())
                .foregroundStyle(.secondary)//.tertiary and .quaternary
                
                //也可以使用 ShapeStyle
                HStack {
//                    Image("baike")//无效
                    Image(systemName: "clock.fill")
                    Text("Set the time")
                }
                .font(.largeTitle.bold())
                .foregroundStyle(
                    .linearGradient(
                        colors: [.red, .black],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
    }
}

struct MakeTwoViewsSameWidthHeight: View {
    var body: some View {
        TestWrap("让两个视图尺寸相同") {
            //使用frame() and fixedSize()，让两个视图尺寸相同
            VStack {
                HStack {
                    Text("This is a short string.")
                        .padding()
                        .frame(maxHeight: .infinity)
                        .background(Color.red)

                    Text("This is a very long string with lots and lots of text that will definitely run across multiple lines because it's just so long.")
                        .padding()
                        .frame(maxHeight: .infinity)
                        .background(Color.green)
                }
//                .fixedSize(horizontal: false, vertical: true)//可以在竖直方向上显示全部文本，同时在水平方向上保持按照上层 View 的限制来换行。
//                .frame(maxHeight: 500)
            }
            
            //让两个按钮等宽
            VStack {
                Button("再来一个") { }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .clipShape(Capsule())
                Button("Log in") { }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .clipShape(Capsule())

                Button("Reset Password") { }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .clipShape(Capsule())
            }
            .fixedSize(horizontal: true, vertical: false)
        }
    }
}

struct UsingLayoutPriority: View {
    var body: some View {
        TestWrap("LayoutPriority布局优先级") {
            //优先级默认为0
            HStack {
                Text("The rain Spain falls mainly on the Spaniards.")
                Text("Knowledge is power, France is bacon.")
                    .layoutPriority(1)
                //1 优先计算最低优先级需要的最小空间，剩余给高优先级
                //2 如果高优先级用不完，剩余的又会给低优先级
            }
            .font(.largeTitle)
        }
    }
}

struct UsingForEach: View {
    let colors: [Color] = [.red, .green, .blue]
    let results = [
        SimpleGameResult(score: 8),
        SimpleGameResult(score: 5),
        SimpleGameResult(score: 10)
    ]
    
    let results1 = [
            IdentifiableGameResult(score: 8),
            IdentifiableGameResult(score: 5),
            IdentifiableGameResult(score: 10)
        ]
    
    var body: some View {
        TestWrap("使用ForEach") {
            VStack(alignment: .leading) {
                ForEach((1...4).reversed(), id: \.self) {
                    Text("\($0)…")
                }
                Text("Ready or not, here I come!")
                
                ForEach(colors, id: \.self) { color in
                    Text(color.description.capitalized)
                        .padding()
                        .background(color)
                }
                
                ForEach(results, id: \.id) { result in
                    Text("Result: \(result.score)")
                }
                
                ForEach(results1) { result in
                    Text("Result: \(result.score)")
                }
            }
        }
    }
}

struct SimpleGameResult {
    let id = UUID()
    let score: Int
}

struct IdentifiableGameResult: Identifiable {
    var id = UUID()
    var score: Int
}

struct ReturnDifferentViewTypes: View {
    var body: some View {
        TestWrap("返回不同的View类型") {
            VStack {
                Group {
                    if Bool.random() {
                        Image("laser-show")
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("1.包一个Group让返回一致")
                            .font(.title)
                    }
                }
                .frame(width: 400, height: 100)
                
                tossResult
                
                tossResult1
                
                TossResult()
            }
        }
    }
    
    var tossResult: some View {
        if Bool.random() {
            return AnyView(Image("laser-show").resizable().scaledToFit())
        } else {
            return AnyView(Text("2.包一个AnyView，这会降低性能，最好用Group").font(.title))
        }
    }
    
    @ViewBuilder var tossResult1: some View {
            if Bool.random() {
                Image("laser-show")
                    .resizable()
                    .scaledToFit()
            } else {
                Text("3.使用@ViewBuilder包装属性，如果用这个，那为什么不封装出去呢？")
                    .font(.title)
            }
        }
}

struct TossResult: View {
    var body: some View {
        if Bool.random() {
            Image("laser-show")
                .resizable()
                .scaledToFit()
        } else {
            Text("4.封装出去，效果最好，可重用")
                .font(.title)
        }
    }
}

struct UsingGeometryReader: View {
    var body: some View {
        TestWrap("使用GeometryReader") {
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        Text("Left")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .frame(width: geometry.size.width * 0.33)
                            .background(Color.yellow)
                        Text("Right")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .frame(width: geometry.size.width * 0.67)
                            .background(Color.orange)
                    }
                }
                .frame(height: 50)
            }
        }
    }
}

struct UsingPadding: View {
    var body: some View {
        TestWrap("使用Padding") {
            VStack(spacing: 0) {
                Text("Using")
                Text("SwiftUI")
//                    .padding()
//                    .padding(100)
                    .padding(.bottom, 10)
                Text("rocks")
            }
        }
    }
}

struct ViewCustomFrame: View {
    var body: some View {
        TestWrap("给View一个自定义frame") {
            Button {
                print("Button tapped")
            } label: {
                Text("Welcome")
                    .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 200)
                    .font(.largeTitle)
            }
            
//            Text("Please log in")
//                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//                .font(.largeTitle)
//                .foregroundColor(.white)
//                .background(Color.red)
        }
    }
}

struct ViewLayoutDemo_Previews: PreviewProvider {
    static var previews: some View {
        ViewLayoutDemo()
    }
}
