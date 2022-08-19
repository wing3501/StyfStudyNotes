//
//  UsingAttributedString.swift
//  UsingChart
//
//  Created by styf on 2022/8/19.
//  https://www.fatbobman.com/posts/attributedString/

import SwiftUI

struct UsingAttributedString: View {
    var body: some View {
        Example2()
    }
    
    //自定义属性
    
    
    //Markdown 符号
    func markdown() {
        var markdownString = AttributedString(localized: "**Hello** ~world~ _!_")
        for (inlineIntent,range) in markdownString.runs[\.inlinePresentationIntent] {
            guard let inlineIntent = inlineIntent else {continue}
            switch inlineIntent{
                case .stronglyEmphasized:
                    markdownString[range].foregroundColor = .red
                case .emphasized:
                    markdownString[range].foregroundColor = .green
                case .strikethrough:
                    markdownString[range].foregroundColor = .blue
                default:
                    break
            }
        }
        
        // Markdown 解析
        let mdString = try! AttributedString(markdown: "# Title\n**hello**\n")
        print(mdString)

        // 解析结果
//        Title {
//            NSPresentationIntent = [header 1 (id 1)] //字符性质：比如粗体、斜体、代码、引用等
//        }
//        hello {
//            NSInlinePresentationIntent = NSInlinePresentationIntent(rawValue: 2)//段落属性：比如段落、表格、列表等。
//            NSPresentationIntent = [paragraph (id 2)]
//        }
        
//        let url = Bundle.main.url(forResource: "README", withExtension: "md")!
//        var markdownString = try! AttributedString(contentsOf: url,baseURL: URL(string: "https://www.baidu.com"))
    }
    
    //创建本地化属性字符串
    func useLocalied() {
        // Localizable Chinese
        //"hello" = "你好";
        // Localizable English
        //"hello" = "hello";

        let attributedString = AttributedString(localized: "hello")//目前本地化的 AttributedString 只能显示为当前系统设置的语言，并不能指定成某个特定的语言
        // 中文环境下获取不到range
        var hello = AttributedString(localized: "hello")
        if let range = hello.range(of: "h") {
            hello[range].foregroundColor = .red
        }
        
        //replacementIndex --------------------
        // Localizable Chinese
        // "world %@ %@" = "%@ 世界 %@";
        // Localizable English
        // "world %@ %@" = "world %@ %@";
        var world = AttributedString(localized: "world \("👍") \("🥩")",options: .applyReplacementIndexAttribute) // 创建属性字符串时，将按照插值顺序设定 index ，👍 index == 1 🥩 index == 2

        for (index,range) in world.runs[\.replacementIndex] {
            switch index {
                case 1:
                    world[range].baselineOffset = 20
                    world[range].font = .title
                case 2:
                    world[range].backgroundColor = .blue
                default:
                    world[range].inlinePresentationIntent = .strikethrough
            }
        }
        
        // 使用 locale 设定字符串插值中的 Formatter
        // 即使在英文环境中也会显示 2021 年 10 月 7 日
        AttributedString(localized: "\(Date.now, format: Date.FormatStyle(date: .long))", locale: Locale(identifier: "zh-cn"))
        
        // 用 Formatter 生成属性字符串
        var dateString = Date.now.formatted(.dateTime.year().month().day().attributed)
        dateString.transformingAttributes(\.dateField) { dateField in
            switch dateField.value {
            case .month:
                dateString[dateField.range].foregroundColor = .red
            case .day:
                dateString[dateField.range].foregroundColor = .green
            case .year:
                dateString[dateField.range].foregroundColor = .blue
            default:
                break
            }
        }

    }
    
    
    // Range
    func useRange() {
        var multiRunString = AttributedString("The attributed runs of the attributed string, as a view into the underlying string.")
        // 通过关键字获取 Range
        // 从属性字符串的结尾向前查找，返回第一个满足关键字的 range（忽略大小写）
        if let range = multiRunString.range(of: "Attributed", options: [.backwards, .caseInsensitive]) {
            multiRunString[range].link = URL(string: "https://www.apple.com")
        }
        // 使用 Runs 或 transformingAttributes 获取 Range
        
        // 通过本文视图获取 Range
        if let lowBound = multiRunString.characters.firstIndex(of: "r"),
           let upperBound = multiRunString.characters.firstIndex(of: ","),
           lowBound < upperBound
        {
            multiRunString[lowBound...upperBound].foregroundColor = .brown
        }
    }
    
    // Runs 视图  AttributedString 的属性视图。每个 Run 对应一个属性完全一致的字符串片段。
    func runs() {
        // 只有一个 Run, 整个属性字符串中所有的字符属性都一致
        let attributedString = AttributedString("Core Data")
        print(attributedString)
        // Core Data {}
        print(attributedString.runs.count) // 1
        
        // 两个 Run,属性字符串coreData，Core和 Data两个片段的属性不相同，因此产生了两个 Run
        var coreData = AttributedString("Core")
        coreData.font = .title
        coreData.foregroundColor = .green
        coreData.append(AttributedString(" Data"))

        for run in coreData.runs { //runs.count = 2
            print(run)
        }
        // 多个 Run
        var multiRunString = AttributedString("The attributed runs of the attributed string, as a view into the underlying string.")
        while let range = multiRunString.range(of: "attributed") {
            multiRunString.characters.replaceSubrange(range, with: "attributed".uppercased())
            multiRunString[range].inlinePresentationIntent = .stronglyEmphasized
        }
        var n = 0
        for run in multiRunString.runs {
            n += 1
        }
        // 利用 Run 的 range 进行属性设置
        // 继续使用上文的 multiRunString
        // 将所有非强调字符设置为黄色
        for run in multiRunString.runs {
            guard run.inlinePresentationIntent != .stronglyEmphasized else {continue}
            multiRunString[run.range].foregroundColor = .yellow
        }
        // 通过 Runs 获取指定的属性
        // 将颜色为黄色且为粗体的文字改成红色
        for (color,intent,range) in multiRunString.runs[\.foregroundColor,\.inlinePresentationIntent] {
            if color == .yellow && intent == .stronglyEmphasized {
                multiRunString[range].foregroundColor = .red
            }
        }
        // 通过 Run 的 attributes 收集所有使用到的属性
        var totalKeysContainer = AttributeContainer()
        for run in multiRunString.runs{
            let container = run.attributes
            totalKeysContainer.merge(container)
        }
        // 不使用 Runs 视图，达到类似的效果
        multiRunString.transformingAttributes(\.foregroundColor,\.font){ color,font in
            if color.value == .yellow && font.value == .title {
                multiRunString[color.range].backgroundColor = .green
            }
        }
    }
    
    // Character 和 unicodeScalar 视图
    func CharacterAndUnicodeScalar() {
        // 字符串长度
        var attributedString = AttributedString("Swift")
        attributedString.characters.count // 5
        // 长度 2
        let attributedString1 = AttributedString("hello 👩🏽‍🦳")
        attributedString1.characters.count // 7
        attributedString1.unicodeScalars.count // 10
        // 转换成字符串
        String(attributedString.characters) // "Swift"
        // 替换字符串
        var attributedString2 = AttributedString("hello world")
        let range = attributedString2.range(of: "hello")!
        attributedString2.characters.replaceSubrange(range, with: "good")
        // good world , 替换后的 good 仍会保留 hello 所在位置的所有属性
    }
    
    // AttributeScope
    func useAttributeScope() {
        var attributedString = AttributedString("Swift")
//        attributedString.swiftUI.foregroundColor = .red
//        attributedString.uiKit.foregroundColor = .red
//        attributedString.appKit.foregroundColor = .red
    }
    
    //AttributeContainer 是属性容器。通过配置 container，我们可以一次性地为属性字符串（或片段）设置、替换、合并大量的属性。
    func useAttributeContainer() {
        // 设置属性 --------
        var attributedString = AttributedString("Swift")
        attributedString.foregroundColor = .red

        var container = AttributeContainer()
        container.inlinePresentationIntent = .strikethrough
        container.font = .caption
        container.backgroundColor = .pink
        container.foregroundColor = .green //将覆盖原来的 red

        attributedString.setAttributes(container) // attributdString 此时拥有四个属性内容
        
        // 替换属性 --------
        // 此时 attributedString 有四个属性内容 font、backgroundColor、foregroundColor、inlinePresentationIntent

        // 被替换的属性
        var container1 = AttributeContainer()
        container1.foregroundColor = .green
        container1.font = .caption

        // 将要替换的属性
        var container2 = AttributeContainer()
        container2.link = URL(string: "https://www.swift.org")

        // 被替换属性 contianer1 的属性键值内容全部符合才可替换，比如 continaer1 的 foregroundColor 为。red 将不进行替换
        attributedString.replaceAttributes(container1, with: container2)
        // 替换后 attributedString 有三个属性内容 backgroundColor、inlinePresentationIntent、link
        
        // 合并属性 --------
        // 此时 attributedString 有四个属性内容 font、backgroundColor、foregroundColor、inlinePresentationIntent
        var container3 = AttributeContainer()
        container3.foregroundColor = .red
        container3.link = URL(string: "www.swift.org")

        attributedString.mergeAttributes(container3,mergePolicy: .keepNew)
        // 合并后 attributedString 有五个属性 ，font、backgroundColor、foregroundColor、inlinePresentationIntent 及 link
        // foreground 为。red
        // 属性冲突时，通过 mergePolicy 选择合并策略 .keepNew（默认） 或 .keepCurrent
        
    }
    
    //AttributedStringKey 定义了 AttributedString 属性名称和类型。通过点语法或 KeyPath，在保证类型安全的前提进行快捷访问。
    func useAttributedStringKey() {
        var string = AttributedString("hello world")
        // 使用点语法
        string.font = .callout
        let font1 = string.font

        // 使用 KeyPath
        let font2 = string[keyPath:\.font]
        
        // 自定义属性
//        string.outlineColor = .blue
    }
    
    enum OutlineColorAttribute : AttributedStringKey {
        typealias Value = Color // 属性类型
        static let name = "OutlineColor" // 属性名称
    }
    
    //苹果为 AttributedString 和 NSAttributedString 提供了相互转换的能力
    func changeToNS() {
        // AttributedString -> NSAttributedString
        let nsString = NSMutableAttributedString("hello")
        var attributedString = AttributedString(nsString)
        
        // NSAttribuedString -> AttributedString
        var attString = AttributedString("hello")
        attString.uiKit.foregroundColor = .red
        let nsString1 = NSAttributedString(attString)
    }
    
    // Formatter 支持
    struct Example2: View {
        var body: some View {
            return Text(text)
        }
        
        var text: AttributedString {
            var attributedString = Date.now.formatted(.dateTime.hour().minute().weekday().attributed)
            let weekContainer = AttributeContainer().dateField(.weekday)
            let colorContainer = AttributeContainer().foregroundColor(.red)
            attributedString.replaceAttributes(weekContainer, with: colorContainer)
            return attributedString
        }
    }
    
    // 基本使用
    struct Example1: View {
        var body: some View {
            return Text(text)
        }
        
        var text: AttributedString {
            var attributedString = AttributedString("使用必应搜索")
            let zhouzi = attributedString.range(of: "搜索")!
            attributedString[zhouzi].inlinePresentationIntent = .stronglyEmphasized // 设置属性——粗体
            let blog = attributedString.range(of: "必应")!
            attributedString[blog].link = URL(string: "https://www.bing.com")! // 设置属性——超链接
            return attributedString
        }
    }
}

struct UsingAttributedString_Previews: PreviewProvider {
    static var previews: some View {
        UsingAttributedString()
    }
}
