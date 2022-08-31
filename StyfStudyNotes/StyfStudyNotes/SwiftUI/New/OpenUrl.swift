//
//  OpenUrl.swift
//
//
//  Created by styf on 2022/8/29.
//  在 SwiftUI 视图中打开 URL 的若干方法  https://www.fatbobman.com/posts/open_url_in_swiftUI/

import SwiftUI

struct OpenUrl: View {
    @Environment(\.openURL) private var openURL // 引入环境值
    
    let attributedString:AttributedString = {
        var fatbobman = AttributedString("肘子的 Swift 记事本")
        fatbobman.link = URL(string: "https://www.fatbobman.com")!
        fatbobman.font = .title
        fatbobman.foregroundColor = .green // link 不为 nil 的 Run，将自动屏蔽自定义的前景色和下划线
        var tel = AttributedString("电话号码")
        tel.link = URL(string:"tel://13900000000")
        tel.backgroundColor = .yellow
        var and = AttributedString(" and ")
        and.foregroundColor = .red
        return fatbobman + and + tel
    }()
    
    var body: some View {
        VStack {
            GroupBox("SwiftUI 2.0") {
                Button {
                            if let url = URL(string: "https://www.example.com") {
                                openURL(url) { accepted in  //  通过设置 completion 闭包，可以检查是否已完成 URL 的开启。状态由 OpenURLAction 提供
                                    print(accepted ? "Success" : "Failure")
                                }
                            }
                        } label: {
                            Label("Get Help", systemImage: "person.fill.questionmark")
                        }
                
                Link(destination: URL(string: "mailto://feedback@fatbobman.com")!, label: {
                    Image(systemName: "envelope.fill")
                    Text("发邮件")
                })
            }
            GroupBox("SwiftUI 3.0") {
                //Text 用例 1 ：自动识别 LocalizedStringKey 中的 URL
                Text("www.wikipedia.org 13900000000 feedback@fatbobman.com") //通过支持 LocalizedStringKey 的构造方法创建的 Text ，会自动识别文本中的网址
                //Text 用例 2 ：识别 Markdown 语法中的 URL 标记
                Text("[Wikipedia](https://www.wikipedia.org) ~~Hi~~ [13900000000](tel://13900000000)")
                //Text 用例 3 ：包含 link 信息的 AttributedString
                Text(attributedString)
                //Text 用例 4 ：识别字符串中的 URL 信息，并转换成 AttributedString
                Text("https://www.wikipedia.org 13900000000 feedback@fatbobman.com".toDetectedAttributedString())
            }
            
            GroupBox("自定义 Text 中链接的颜色") {
                Text("www.wikipedia.org 13900000000 feedback@fatbobman.com")
                    .tint(.green)

                Link("Wikipedia", destination: URL(string: "https://www.wikipedia.org")!)
                    .tint(.pink)
                // 可以用 Button 或 Link 创建可以自由定制外观的链接按钮
                Button(action: {
                    openURL(URL(string: "https://www.wikipedia.org")!)
                }, label: {
                    Circle().fill(.angularGradient(.init(colors: [.red,.orange,.pink]), center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
                        .frame(width: 50)
                })
            }
            
            GroupBox("自定义 openURL 的行为") {
                // 在 Button 中，我们可以通过在闭包中添加逻辑代码，自定义开启 URL 之前与之后的行为。
                Button("打开网页") {
                    if let url = URL(string: "https://www.example.com") {
                        // 开启 URL 前的行为
                        print(url)
                        openURL(url) { accepted in  //  通过设置 completion 闭包，定义点击 URL 后的行为
                            print(accepted ? "Open success" : "Open failure")
                        }
                    }
                }
                // 在 Link 和 Text 中，我们则需要通过为环境值 openURL 提供 OpenURLAction 处理代码的方式来实现自定义打开链接的行为。
                Text("Visit [Example Company](https://www.example.com) for details.")
                    .environment(\.openURL, OpenURLAction { url in
                        //handleURL(url)
                        return .handled
                    })
                  //handled 当前的代码已处理该 URL ，调用行为不会再向下传递   handled 时  accepted 为 true ， discarded 时 accepted 为 false
                  //discarded 当前的处理代码将丢弃该 URL ，调用行为不会再向下传递
                  //systemAction 当前代码不处理，调用行为向下传递（ 如果外层没有用户的自定义 OpenURLAction ，则使用系统默认的实现）
                  //systemAction(_ url: URL) 当前代码不处理，将新的 URL 向下传递（ 如果外层没有用户的自定义 OpenURLAction ，则使用系统默认的实现）
                
                Text("www.fatbobman.com feedback@fatbobman.com 13900000000".toDetectedAttributedString()) // 创建三个链接 https mailto tel
                    .environment(\.openURL, OpenURLAction { url in
                        switch url.scheme {
                        case "mailto":
                            return .discarded // 邮件将直接丢弃，不处理
                        default:
                            return .systemAction // 其他类型的 URI 传递到下一层（外层）
                        }
                    })
                    .environment(\.openURL, OpenURLAction { url in
                        switch url.scheme {
                        case "tel":
                            print("call number \(url.absoluteString)") // 打印电话号码
                            return .handled  // 告知已经处理完毕，将不会继续传递到下一层
                        default:
                            return .systemAction // 其他类型的 URI 当前代码不处理，直接传递到下一层
                        }
                    })
                    .environment(\.openURL, OpenURLAction { _ in
                        .systemAction(URL(string: "https://www.apple.com")!) // 由于在本层之后我们没有继续设定 OpenURLAction , 因此最终会调用系统的实现打开苹果官网
                    })
            }
            
            
            GroupBox("在点击链接后，用户可以选择是打开链接还是将链接复制在粘贴板上") {
                OpenUrlContentView()
            }
        }
    }
}

extension String {
    func toDetectedAttributedString() -> AttributedString {
        
        var attributedString = AttributedString(self)
        // 设定需要识别的类型
        let types = NSTextCheckingResult.CheckingType.link.rawValue | NSTextCheckingResult.CheckingType.phoneNumber.rawValue
        // 创建识别器
        guard let detector = try? NSDataDetector(types: types) else {
            return attributedString
        }
        // 获取识别结果
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: count))
        
        for match in matches {
            let range = match.range
            let startIndex = attributedString.index(attributedString.startIndex, offsetByCharacters: range.lowerBound)
            let endIndex = attributedString.index(startIndex, offsetByCharacters: range.length)
            // 为 link 设置 url
            if match.resultType == .link, let url = match.url {
                attributedString[startIndex..<endIndex].link = url
                // 如果是邮件，设置背景色
                if url.scheme == "mailto" {
                attributedString[startIndex..<endIndex].backgroundColor = .red.opacity(0.3)
                }
            }
            // 为 电话号码 设置 url
            if match.resultType == .phoneNumber, let phoneNumber = match.phoneNumber {
                let url = URL(string: "tel:\(phoneNumber)")
                attributedString[startIndex..<endIndex].link = url
            }
        }
        return attributedString
    }
}

struct OpenUrlContentView: View {
    @Environment(\.openURL) var openURL
    @State var url:URL?
    var show:Binding<Bool>{
        Binding<Bool>(get: { url != nil }, set: {_ in url = nil})
    }
    
    var body: some View {
        Form {
            Section("NSDataDetector + AttributedString"){
                // 使用 NSDataDetector 进行转换
                Text("https://www.fatbobman.com 13900000000 feedback@fatbobman.com".toDetectedAttributedString())
            }
        }
        .environment(\.openURL, .init(handler: { url in
            switch url.scheme {
            case "tel","http","https","mailto":
                self.url = url
                return .handled
            default:
                return .systemAction
            }
        }))
        .confirmationDialog("", isPresented: show){
            if let url = url {
                Button("复制到剪贴板"){
                    let str:String
                    switch url.scheme {
                    case "tel":
                        str = url.absoluteString.replacingOccurrences(of: "tel://", with: "")
                    default:
                        str = url.absoluteString
                    }
                    UIPasteboard.general.string = str
                }
                Button("打开 URL"){openURL(url)}
            }
        }
        .tint(.cyan)
    }
}
