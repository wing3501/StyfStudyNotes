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
