//
//  StaticTextApp.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/10.
//

import SwiftUI

struct StaticTextApp: View {
    var body: some View {
        ScrollView {
            VStack {
                // Text基本使用
                BaseUse()
                
                Group {
                    //文字的选中
                    TextSelectionTest()
                    //对Markdown的支持
                    MarkdownTest()
                    //标记文本为敏感信息
                    PrivacySensitiveTest()
                    //标记文本为占位信息
                    RedactedTest()
                    //使用label来显示一个图片和文字
                    LabelTest()
                    //文字的大小写转换
                    TextCaseTest()
                    //日期格式化
                    DateStyleTest()
                }
                
                VStack {
                    Text("格式化日期范围：\(Date()...Date().addingTimeInterval(600))")

                    KerningAndTracking()

                    Text("文字增加空隙20pt")
                        .tracking(20)

                    DateFormatterTest()
                    //度量尺寸的格式化
                    MeasurementTest()
                    //list拼接内容
                    TextListTest()
                    //多行文本对齐
                    MultilineTextAlignmentTest()

                    Group {
                        Text("This is an extremely long text string that will never fit even the widest of phones without wrapping")
                            .font(.largeTitle)
                            .lineSpacing(20)
                            .frame(width: 300)

                        Text("This is an extremely long string of text that will never fit even the widest of iOS devices even if the user has their Dynamic Type setting as small as is possible, so in theory it should definitely demonstrate truncationMode().")
                            .lineLimit(1)
                            .truncationMode(.middle)
                        
                        Text("Hello World")
                            .lineLimit(2...3)
                        Text("Hello World")
                            .lineLimit(nil)//无限制
                        Text("Lorem ipsum")
                                .lineLimit(2, reservesSpace: true) //不足2行也留空
                        Text("Lorem ipsum")
                                .lineLimit(2...)// 设置一个最小行数
                        Text("The best laid plans")
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
            }
        }
    }
}
// Text基本使用
struct BaseUse: View {
    var body: some View {
        Group {
            VStack {
                // 添加文本视图，文本加粗
                Text("Hello, world!").bold()
                // 添加文本视图，文本倾斜
                Text("Hello, world!").italic()
                // 添加文本视图，文本下划线
                Text("Hello, world!").underline()
                // 添加文本视图，文本下划线的颜色为橙色
                Text("Hello, world!").underline(true,color: .orange)
                // 添加文本视图，文本添加删除线
                Text("Hello, world!").strikethrough()
                // 添加文本视图，文本添加删除线，设置删除线为橙色
                Text("Hello, world!").strikethrough(true,color: .orange)
                // 添加文本视图，设置文本颜色为橙色
                Text("Hello, world!").foregroundColor(.orange)
                // 添加文本视图，设置文本向上的偏移值为15，设置文本的背景色为橙色
                Text("Hello, world!").baselineOffset(15).background(Color.orange)
                // 添加文本视图，设置背景图片，设置文本在视图底部
                Text("Hello, Pic!").background(Image("Pic"),alignment: .bottom).foregroundColor(.white).font(.system(size: 13))
            }
            
            VStack{
                // 添加文本视图，设置文字的字体尺寸为脚注样式
                Text("Hello, world!,footnote").font(.footnote)
                // 添加文本视图，设置字体大小为36
                Text("Hello, world!").font(.system(size:36))
                // 添加文本视图，设置文字的字体为标题样式，该样式可以根据屏幕尺寸的大小，自动调整自身的尺寸
                Text("Hello, world!,Automatic").font(.system(.title,design: .monospaced)).lineLimit(2)
                // 添加文本视图，设置文字的字体，尺寸为36
                Text("Hello, world!").font(.custom("BradleyHandITCTT-Bold", size: 36))
                // 添加文本视图，通过字体粗细属性设置加粗效果
                Text("Hello, world!").fontWeight(Font.Weight.heavy)
                // 添加文本视图，通过字体粗细属性设置显示纤细文字
                Text("Hello, world!").fontWeight(Font.Weight.ultraLight)
            }
            
            // 通过段落属性可以调整文字的间距、行距、偏移值、框架和对齐方式等视觉样式
            VStack(spacing: 4.0){
                // 添加文本视图，文本加粗
                Text("Hello, world!")
                // 添加文本视图，设置字体属性的字距为10
                Text("www.hdjc8.com").tracking(10)
                // 添加文本视图，设置字体属性的字距为10。字距调整属性表示一对字元的字距
                Text("www.hdjc8.com").kerning(10)
                // 添加文本视图，给文本视图添加模糊效果，并设置模糊效的半径为1
                Text("www.hdjc8.com").blur(radius: 1)
                // 添加一个具有长文字内容的文本视图，设置文本视图的行距为20，同时不限制文字的行数
                Text("www.hdjc8.com,www.hdjc8.com,www.hdjc8.com,www.hdjc8.com,www.hdjc8.com,www.hdjc8.com,").multilineTextAlignment(.leading).lineSpacing(11).lineLimit(nil)
                // 添加文本视图，设置文字向右侧偏移40的距离
                Text("www.hdjc8.com").offset(x: 40, y: 0)
                // 添加文本视图，设置宽度为200，高度为80，文字位于文本视图的右下角，颜色为橙色
                Text("www.hdjc8.com").frame(width: 200, height: 80, alignment: .bottomTrailing).background(Color.orange)
                VStack{
                    // 添加文本视图，设置宽度为300，高度为100，文字位于文本视图的右下角
                    // position方法会使对其属性失效，因此文字不再位于视图的右下角，会向右和向下各偏移50点的位置
                    Text("www.hdjc8.com").position(x: 50, y: 50).frame(width: 300, height: 100, alignment: .bottomTrailing).background(Color.orange)
                    // 添加文本视图，设置可以显示4行文字
                    // 最后调用多行文字的对齐方法
                    // multilineTextAlignment:多行文本对齐
                    Text("西瓜\n香蕉\n苹果\n车厘子").frame(width: 200, height: 100).lineLimit(4).multilineTextAlignment(.center)
                }
            }
            
            // 使用填充属性，修改文字内容和文本视图边框之间的距离，即修改文本视图的上下左右的内边距
            VStack(spacing: 4.0){
                // 添加文本视图，文本加粗
                // background：背景颜色
                // foregroundColor:前景颜色
                Text("Hello, world!")
                    .background(Color.black)
                    .foregroundColor(.white)
                    .padding(20)
                
                // 链式调用的顺序由上而下，
                // 所以首先设置第二个文本视图的那边句，
                // 然后再给文本视图设置背景颜色和字体颜色，
                // 这时那边句也会有有相应的背景颜色
                Text("Hello, world!")
                    .padding(20)
                    .background(Color.black)
                    .foregroundColor(.white)
                
                // 创建多个填充属性，创建由外向内颜色渐变的边框
                // 设置文字样式为巨型标题样式
                Text("Hello, world!")
                    .font(.largeTitle)
                    .padding(15)
                    .background(Color.yellow)
                    .padding(15)
                    .background(Color.orange)
                    .padding(10)
                    .background(Color.red)
            }
        }
    }
}

struct TextSelectionTest: View {
    //在任何类型的视图组上设置textSelection（），都会自动选择该组中的所有文本。
    var body: some View {
        TestWrap("文字选中案例") {
            VStack(spacing: 50) {
                Text("文本不可选中")

                Text("文本可以选中")
                    .textSelection(.enabled)
                List(0..<1) { index in
                    Text("Row \(index)")
                }
                .textSelection(.enabled)
            }
        }
    }
}

struct MarkdownTest: View {
    var body: some View {
        TestWrap("SwiftUI内部支持Markdown文本,除了图片！") {
            VStack {
                Text("This is regular text.")
                Text("* This is **bold** text, this is *italic* text, and this is ***bold, italic*** text.")
                Text("~~A strikethrough example~~")
                Text("`Monospaced works too`")
                Text("Visit Apple: [click here](https://apple.com)")
                Text(content)
                Text(attributedString)
            }
        }
    }
    var content: AttributedString {
         var attributedString = try! AttributedString(markdown: "**AttributedString内置支持Markdown**")
         attributedString.foregroundColor = .blue
         return attributedString
    }
    
    var attributedString: AttributedString = {
        do {
            var text = try AttributedString(markdown: "`SwiftUI` has evolved so much in these two years. **Apple has packed even more features and brought more UI components to the `SwiftUI` framework**, which comes alongside with *Xcode 13*. It just takes UI development on iOS, iPadOS, and macOS to the **next level**.")

            if let range = text.range(of: "Apple") {
                text[range].backgroundColor = .yellow
            }

            if let range = text.range(of: "iPadOS") {
                text[range].backgroundColor = .purple
                text[range].foregroundColor = .white
            }

            return text

        } catch {
            return ""
        }
    }()
}

// 将文字标记为敏感信息
struct PrivacySensitiveTest: View {
    var body: some View {
        TestWrap("将文字标记为敏感信息") {
            VStack {
                Text("Card number")
                    .font(.headline)

                Text("1234 5678 9012 3456")
                    .privacySensitive() //1 在需要隐藏的View上加
                
                PrivacySensitiveTest1() //3 也可以使用自定义的敏感样式
            }
            .redacted(reason: .privacy) //2 在上级View上加
        }
    }
}

struct PrivacySensitiveTest1: View {
    @Environment(\.redactionReasons) var redactionReasons

    var body: some View {
        VStack {
            Text("Card number")
                .font(.headline)

            if redactionReasons.contains(.privacy) {
                Text("[HIDDEN]")
            } else {
                Text("1234 5678 9012 3456")
            }
        }
    }
}

// 将文字图片标记为占位
struct RedactedTest: View {
    var body: some View {
        TestWrap("SwiftUI允许我们在视图中将文本标记为占位符，这意味着它会被渲染，但会被灰色掩盖，以显示它不是最终内容") {
            Text("这是占位文字")
                .font(.title)
                .redacted(reason: .placeholder)
            VStack {
                Text("This is placeholder text")
                Text("And so is this")
            }
            .font(.title)
            .redacted(reason: .placeholder)
            
            RedactedTest1()
        }
    }
}
// redacted同样适用于图片
struct RedactedTest1: View {
    @Environment(\.redactionReasons) var redactionReasons
        let bio = "The rain in Spain falls mainly on the Spaniards"

        var body: some View {
            if redactionReasons == .placeholder {
                Text("Loading…")
            } else {
                Text(bio)
                    .redacted(reason: redactionReasons)
            }
        }
}

struct TestWrap<Content>: View where Content: View{
    var title: String = ""
    let content: Content
    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Divider()
            Text(title)
                .font(.headline)
            content
            Divider()
        }
    }
}

/// 使用Label来显示文本和图标
struct LabelTest: View {
    var body: some View {
        VStack {
            Divider()//分隔线使用
//            Divider()
//                    .background(Color.purple) //分割线的默认颜色为灰色，此处设置分割线的默认颜色为紫色
//                    .scaleEffect(CGSize(width: 1, height: 10)) //分割线高度放大10倍
//                        .padding(Edge.Set.init(arrayLiteral: .top, .bottom), 20) //将分割线的上下内边距设置为20，以增加分割线和上下两侧的视图的距离
            
            Label("Label的使用案例", image: "")
            
            Label("使用SF Symbols", systemImage: "folder.circle")
            Label("使用自己的图片", image: "baike")
            Label("使用font来放大", image: "baike")
                .font(.title)
            Label("font只对iconfont有效", systemImage: "person.crop.circle")
                .font(.title)
            //使用labelStyle来控制显示的内容
            VStack {
                Label("Text Only", systemImage: "heart")
                    .font(.title)
                    .labelStyle(.titleOnly)

                Label("Icon Only", systemImage: "star")
                    .font(.title)
                    .labelStyle(.iconOnly)

                Label("Both", systemImage: "paperplane")
                    .font(.title)
                    .labelStyle(.titleAndIcon)
            }
            
            Label {
                Text("可以给Label提供自定义View")
                    .foregroundColor(.primary)
                    .font(.largeTitle)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .clipShape(Capsule())
            } icon: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                    .frame(width: 64, height: 64)
            }
            Divider()
        }
    }
}

/// 大小写转换
struct TextCaseTest: View {
    @State private var name = "Paul"

    var body: some View {
        TextField("Shout your name at me", text: $name)
            .textFieldStyle(.roundedBorder)
            .textCase(.uppercase)
            .padding(.horizontal)
    }
}

// 日期格式化
struct DateStyleTest: View {
    var body: some View {
        VStack {
            // show just the date
            Text(Date().addingTimeInterval(600), style: .date)

            // show just the time
            Text(Date().addingTimeInterval(600), style: .time)

            // show the relative distance from now, automatically updating
            Text(Date().addingTimeInterval(600), style: .relative)

            // make a timer style, automatically updating
            Text(Date().addingTimeInterval(600), style: .timer)
        }
    }
}



// kerning和tracking的区别
struct KerningAndTracking: View {
    @State private var amount: CGFloat = 50
    var body: some View {
        VStack {
            Text("ffi")
                .font(.custom("AmericanTypewriter", size: 72))
                .kerning(amount)
            Text("ffi")
                .font(.custom("AmericanTypewriter", size: 72))
                .tracking(amount)

            Slider(value: $amount, in: 0...100) {
                Text("Adjust the amount of spacing")
            }
        }
    }
}

/// 日期格式化
struct DateFormatterTest: View {
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
//        formatter.dateStyle = .long
        return formatter
    }()

    let dueDate = Date()

    var body: some View {
        Text("Task due date: \(dueDate, formatter: Self.taskDateFormat)")
        
//        Text(timestamp, format: .dateTime.hour(.twoDigits(amPM: .abbreviated)).minute(.twoDigits).second(.twoDigits))
    }
}

//用户的设备上有美国语言环境，iOS将根据值的大小自动显示以英尺或英寸为单位的值。
struct MeasurementTest: View {
    let length = Measurement(value: 225, unit: UnitLength.centimeters)

    var body: some View {
        Text(length, format: .measurement(width: .wide))
    }
}
// 使用 .list来拼接
struct TextListTest: View {
    @State private var ingredients = [String]()
    @State private var rolls = [Int]()
    
    var body: some View {
        //用.list 拼接一个字符串数组  = Egg,Egg and Egg
//        VStack {
//            Text(ingredients, format: .list(type: .and))
//
//            Button("Add Ingredient") {
//                let possibles = ["Egg", "Sausage", "Bacon", "Spam"]
//
//                if let newIngredient = possibles.randomElement() {
//                    ingredients.append(newIngredient)
//                }
//            }
//        }
        // 用.list 拼接一个数字数组 = 1,2,3 and 4
        VStack {
            Text(rolls, format: .list(memberStyle: .number, type: .and))
            
            Button("Roll Dice") {
                let result = Int.random(in: 1...6)
                rolls.append(result)
            }
        }
    }
}

/// 多行文本的对齐
struct MultilineTextAlignmentTest: View {
    let alignments: [TextAlignment] = [.leading, .center, .trailing]
        @State private var alignment = TextAlignment.leading

        var body: some View {
            VStack {
                Picker("Text alignment", selection: $alignment) {
                    ForEach(alignments, id: \.self) { alignment in
                        Text(String(describing: alignment))
                    }
                }

                Text("处理多行文本的对齐，使用multilineTextAlignment。处理多行文本的对齐，使用multilineTextAlignment。处理多行文本的对齐，使用multilineTextAlignment。")
                    .font(.headline)
                    .multilineTextAlignment(alignment)
                    .frame(width: 300)
            }
        }
}

struct StaticTextApp_Previews: PreviewProvider {
    static var previews: some View {
        StaticTextApp()
    }
}
