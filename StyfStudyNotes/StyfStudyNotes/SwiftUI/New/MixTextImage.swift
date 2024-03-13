//
//  MixTextImage.swift
//  TextImage
//
//  Created by styf on 2022/8/19.
// 在 SwiftUI 中用 Text 实现图文混排
// https://www.fatbobman.com/posts/mixing_text_and_graphics_with_Text_in_SwiftUI/

import SwiftUI

struct MixTextImage: View {
    
    let str = "道可道，非常道；名可名，非常名。"
    var body: some View {
        TempView()
    }
    
    //----------------------------------------------
    // 方案一：在 Text 中直接使用图片
    // 1 从应用程序或网络上获取标签图片
    // 2 当动态类型变化时，将图片缩放至与关联的文本风格尺寸一致
//    var plan1: some View {
//        VStack(alignment: .leading, spacing: 50) {
//                    TitleWithImage(title: "佳农 马来西亚冷冻 猫山王浏览果肉 D197", fontStyle: .body, tagName: "JD_Tag")
//
//                    TitleWithImage(title: "佳农 马来西亚冷冻 猫山王浏览果肉 D197", fontStyle: .body, tagName: "JD_Tag")
//                        .environment(\.sizeCategory, .extraExtraExtraLarge)
//                }
//    }
    // 方案二：在 Text 上使用覆盖视图
//    1 不使用预制图片，通过 SwiftUI 视图创建标签
//    2 根据标签视图的尺寸创建空白占位图片
//    3 在 Text 中添加占位图片，进行混排
//    4 使用 overlay 将标签视图定位在 leadingTop 位置，覆盖于占位图片上
    
    // 方案三：将视图转换成图片，插入 Text 中
    // 1 与方案二一样，不使用预制图片，使用 SwiftUI 视图创建标签
    // 2 将标签视图转换成图片添加到 Text 中进行混排
//    func createImage() async {
//        let tagView = TagView(tag: tag, textStyle: textStyle, fontSize: fontSize - 6, horizontalPadding: 5.5, verticalPadding: 2)
//        tagView.generateSnapshot(snapshot: $tagImage)
//    }
//    func generateSnapshot(snapshot: Binding<Image>) {
//        Task {
//            let renderer = await ImageRenderer(content: self)
//            await MainActor.run {
//                renderer.scale = UIScreen.main.scale // 设置正确的 scale 值
//            }
//            if let image = await renderer.uiImage {
//                snapshot.wrappedValue = Image(uiImage: image)
//            }
//        }
//    }
    
    //----------------------------------------------
    @State private var wifiSelection = 0
    // 在 Text 中使用 SF Symbols
    var useSFSymbols: some View {
       
        VStack {
            Image(systemName: "ladybug")
                .symbolRenderingMode(.multicolor) // 指定渲染模式，Image 专用修饰器 ，Image 类型不发生改变
                .symbolVariant(.fill) // 设置变体 ，该修饰器适用于 View 协议，Image 类型发生了改变
                .font(.largeTitle) // 适用于 View 的修饰器，非 Text 专用版本
            
            VStack {
                HStack {
                    Image(systemName: "c")
                    Image(systemName: "o")
                    Image(systemName: "o")
                    Image(systemName: "k")
                }
                .symbolVariant(.fill.circle)
                .font(.title)
            }
            
            HStack{
                Image(systemName: "b.circle.fill")
                Image(systemName: "o.circle.fill")
                    .foregroundStyle(.red)
                Image(systemName: "o.circle.fill")
                    .imageScale(.large)
                Image(systemName: "k.circle.fill")
                    .accessibility(identifier: "Letter K")
            }
            .foregroundStyle(.blue)
            .font(.title)
            .padding()
            
            HStack {
                Picker("Pick One", selection: $wifiSelection) {
                    Text("No Wifi").tag(0)
                    Text("Searching").tag(1)
                    Text("Wifi On").tag(2)
                }
                .pickerStyle(.segmented)
                .frame(width: 240)
                .padding(.horizontal)
                Group {
                    switch wifiSelection {
                    case 0:
                        Image(systemName: "wifi")
                            .symbolVariant(.slash)
                    case 1:
                       Image(systemName: "wifi")
//                           .symbolEffect(.variableColor.iterative.reversing)
                    default:
                       Image(systemName: "wifi")
                           .foregroundStyle(.blue)
                    }
                }
                .foregroundStyle(.secondary)
                .font(.title)
            }
            .padding()
        }
        
    }
    
    // SF Symbols使用插值和加法
    var useSFSymbols1: some View {
        
        VStack {
            let bug = Image(systemName: "ladybug.fill") // 由于 symbolVariant 会改变 Image 的类型，因此我们采用直接在名称中添加变体的方式来保持类型的稳定
                .symbolRenderingMode(.multicolor) // 指定渲染模式，Image 专用修饰器 ，Image 类型不发生改变
            let bugText = Text(bug)
                .font(.largeTitle) // Text 专用版本，Text 类型不发生变化
            // 通过插值的方式
            Text("Hello \(bug)") // 在插值中使用 Image 类型，由于 font 会改变 Image 的类型，因此无法单独修改 bug 的大小

            Text("Hello \(bugText)") // 在插值中使用 Text，font（ Text 专用修饰器 ）不会改变 Text 类型，因此可以单独调整 bug 的大小

            // 使用加法运算符
            Text("Hello ") + bugText

        }
    }
    
    //----------------------------------------------
    
    // 多个 Text 转换成一个 Text
    // 1 插值
    var toOneText1: some View {
        HStack{
            let a = Text(str)
            let b = Text(str)
            let c = Text(str)
            Text("\(a) \(b) \(c)") //必须在插值符号 \( 前添加一个空格，否则会出现显示异常（ 这是一个持续了多个版本的 Bug ）。
        }
    }
    // 2 加法
    var toOneText2: some View {
        HStack{
            let a = Text(str)
            //      .background(Color.yellow) // background 是针对 View 协议的修饰器，会改变 Text 的类型，无法使用
            let b = Text(str)
            let c = Text(str)
            a + b + c //当我们对部分 Text 进行配置时，只能使用不改变 Text 类型的修饰器
        }
    }
}
//----------------------------------------------

//在可能的情况下，通过 Text + SF Symbols 的组合来实现图文混排是最佳的解决方案。
struct SymbolInTextView: View {
    @State private var value: Double = 0
    private let message = Image(systemName: "message.badge.filled.fill") // 􁋭
        .renderingMode(.original)
    private let wifi = Image(systemName: "wifi") // 􀙇
    private var animatableWifi: Image {
        Image(systemName: "wifi", variableValue: value)
    }

    var body: some View {
        VStack(spacing:50) {
            VStack {
                Text(message).font(.title) + Text("文字与 SF Symbols 混排。\(wifi) Text 会将插值图片视作文字的一部分。") + Text(animatableWifi).foregroundColor(.blue)
            }
        }
        .task(changeVariableValue)
        .frame(width:300)
    }

    @Sendable
    func changeVariableValue() async {
        while !Task.isCancelled {
            if value >= 1 { value = 0 }
            try? await Task.sleep(nanoseconds: 1000000000)
            value += 0.25
        }
    }
}
//----------------------------------------------
//使用 SwiftUI 提供的 @ScaledMetric 属性包装器，可以创建能够跟随动态类型自动缩放的数值
struct TempView: View {
    @ScaledMetric(relativeTo:.body) var height = 17 // body 的默认高度
    var body: some View {
        VStack {
            Image("belgium-flag")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height:height) //遗憾的是，由于 frame 会更改 Image 的类型，因此我们无法将通过 frame 动态更改尺寸后的图片嵌入到 Text 中，以实现可动态调整尺寸的图文混排。

            Text("欢迎访问！")
                .font(.body)
        }
        .padding()
    }
}

//使用 .dynamicTypeSize(DynamicTypeSize.xSmall...DynamicTypeSize.xxxLarge) 可以让视图只在指定的动态类型范围内发生变化。
//
//使用 .font(custom(_ name: String, size: CGFloat)) 设置的自定义尺寸的字体也会在动态类型变化时自动调整尺寸。
//
//使用 .font(custom(_ name: String, size: CGFloat, relativeTo textStyle: Font.TextStyle)) 可以让自定义尺寸的字体与某个预设文本风格的动态类型尺寸变化曲线相关联。
//
//使用.font(custom(_ name: String, fixedSize: CGFloat)) 将让自定义尺寸字体忽略动态类型的变化，尺寸始终不发生改变。

struct MixTextImage_Previews: PreviewProvider {
    static var previews: some View {
        MixTextImage()
    }
}
