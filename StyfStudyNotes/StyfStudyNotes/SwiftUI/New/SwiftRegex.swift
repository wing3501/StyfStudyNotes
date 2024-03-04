//
//  SwiftRegex.swift
//  TestAnim
//
//  Created by styf on 2022/12/4.
//  【WWDC22 110357/110358】Swift Regex: 蓄谋已久的正则优化
//   https://xiaozhuanlan.com/topic/0563284917
//   Swift 正则速查手册
//   https://onevcat.com/2022/11/swift-regex/

import SwiftUI
import RegexBuilder

struct SwiftRegex: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
//                example2()
//                example3()
//                example4()
                try? example6()
            }
    }
    // ✅ 三种引入正则的方式
    func example1() throws {
        //1 正则字面量
        let digits = /\d+/
        
        //2 运行时基于字符串产生 Regex
        let runtimeString = #"\d+"#
        let digits1 = try Regex(runtimeString)
        
        //3 Regex Builder
        let digits2 = OneOrMore(.digit)
    }
    // ✅ 正则字面量解决，表单信息分割问题
    func example2() {
        let transaction = "DEBIT    03/05/2022    Doug's Dugout Dogs    $33.27"
        // \s{2,} 匹配两个及以上的空格
        // \t 匹配一个制表符
        // 中间的 | 表示或逻辑
        let normalized = transaction.split(separator: /\s{2,}|\t/)
        print(normalized)
    }
    // ✅ 引入 Regex Builder 来帮助我们用新方式完整地处理报表
    func example3() {
//        let transaction = """
//CREDIT    03/0212022    Payroll from employer        $200.23
//CREDIT    03/03/2022     Suspect A                    $2, 000, 000.00
//DEBIT     03/03/2022    Ted's Pet Rock Sanctuary     $2 , 000, 000. 00
//DEBIT     03/05/2022    Doug's Dugout Dogs           $33.27
//"""
        let transaction = "DEBIT    03/05/2022    Doug's Dugout Dogs    $33.27"
        let fieldSeparator = /\s{2,}|\t/
        // ✅ 匹配一行
        let transactionMatcher = Regex {
            /CREDIT|DEBIT/
            fieldSeparator
            One(.date(.numeric, locale: Locale(identifier: "en_US"), timeZone: .gmt))
            fieldSeparator
            // OneOrMore { CharacterClass.any } // 匹配任意字符，❌ 效率不高
            OneOrMore {
                NegativeLookahead { // ✅ 一遇到fieldSeparator就停下
                    fieldSeparator
                }
                CharacterClass.any
            }
            fieldSeparator
            One(.localizedCurrency(code: "USD", locale: Locale(identifier: "en_US")))
        }
        
        // ✅ 捕获数据
        let transactionCapture = Regex {
            Capture {
                /CREDIT|DEBIT/
            }
            fieldSeparator
            Capture {
                One(.date(.numeric, locale: Locale(identifier: "en_US"), timeZone: .gmt))
            }
            fieldSeparator
            // OneOrMore { CharacterClass.any } // 匹配任意字符，❌ 效率不高
            Capture {
                OneOrMore {
                    NegativeLookahead { // ✅ 一遇到fieldSeparator就停下
                        fieldSeparator
                    }
                    CharacterClass.any
                }
            }
            fieldSeparator
            Capture {
                One(.localizedCurrency(code: "USD", locale: Locale(identifier: "en_US")))
            }
        }
        
        guard let match = transaction.wholeMatch(of: transactionCapture) else {
            fatalError()
        }
        print(match.0) //DEBIT    03/05/2022    Doug's Dugout Dogs    $33.27
        print(match.1) //DEBIT
        let date: Date = match.2
        print(date) //2022-03-05 00:00:00 +0000
        print(match.3) //Doug's Dugout Dogs
        let amount: Decimal = match.4
        print(amount) //33.27
    }
    // ✅ 解决年月日格式不同问题
    func example4() {
        var ledger = """
    CREDIT    03/02/2022     Payroll from employer        $200.23
    CREDIT    03/03/2022     Suspect A                    $2, 000, 000.00
    DEBIT     03/03/2022     Ted's Pet Rock Sanctuary     $2 , 000, 000. 00
    DEBIT     03/05/2022     Doug's Dugout Dogs           $33.27
    DEBIT     06/03/2022     Oxford Comma Supply Ltd.     £57.33
    """
        //不同地区有不同的日期书写习惯，美式的写法是「月/日/年」，而英国则是「日/月/年」。为解决这个问题，我们首先要为正则字面量也引入扩展分隔符（斜杠外围的井号）：
        // 命名捕获为输出元组中的元素命名
        let regex = #/
        (?<date>        \d{2} / \d{2} / \d{4})
        (?<middle>      \P{currencySymbol}+)
        (?<currency>    \p{currencySymbol})
        /#
        //\P{currencySymbol}+ 则可匹配多个非货币字符
        //\p{currencySymbol} 名为 Unicode Property，可用于匹配任意一个货币符号
        
        ledger.replace(regex) { match -> String in
            let date = try! Date(String(match.date), strategy: pickStrategy(match.currency))
            let newDate = date.formatted(.iso8601.year().month().day())
            return newDate + match.middle + match.currency
        }
        print(ledger)
    }
    // 根据货币符号，返回日期匹配格式
    func pickStrategy(_ currency: Substring) -> Date.ParseStrategy {
        switch currency {
        case "$": return .date(.numeric, locale: Locale(identifier: "en_US"), timeZone: .gmt)
        case "£": return .date(.numeric, locale: Locale(identifier: "en_GB"), timeZone: .gmt)
        default:
            fatalError()
        }
    }
    
    // 有自定义输入正则时的处理
    func example5() throws {
        //CREDIT    <proprietary>   <redacted>      200.23      A1B34EFF
        let timestamp = Regex {
            OneOrMore {
                /\d/
            }
        }
        let inputString = ""
        let details = try Regex(inputString)
        let amountMatcher = /[\d.]+/
        
        let fieldSeparator = Local { // 我们可以加上 Local 使正则只匹配一次，在后面失败时直接退出以避免多余的回溯。
            /\s{2,}|\t/
        }
        let field = OneOrMore {
            NegativeLookahead { fieldSeparator }
            CharacterClass.any
        }
        let transactionMatcher = Regex {
            Capture { /CREDIT|DEBIT/ }
            fieldSeparator
            
            // ✅ 通过 TryCapture 来使用 field 进行分段预处理，再将切割好的字段放入后面的闭包中进行解析
            // 如果解析失败闭包返回 nil，则会导致回溯字符串，并重新预处理，以尝试其他可能的方案。以此来抵消多种预处理方式导致的不确定性。
//            TryCapture(field) { timestamp ~= $0 ? $0 : nil }
            fieldSeparator
            
//            TryCapture(field) { details ~= $0 ? $0 : nil }
            fieldSeparator
        }
    }
    // ✅ 解决贪婪策略问题
    func example6() throws {
        let testSuiteTestInputs = [
        "Test Suite 'RegexDSLTests' started at 2022-06-06 09:41:00.001",
        "Test Suite 'RegexDSLTests' failed at 2022-06-06 09:41:00.001.",
        "Test Suite 'RegexDSLTests' passed at 2022-06-06 09:41:00.001."
        ]
        
        let regex = Regex {
            "Test Suite '"
            Capture(/[a-zA-Z][a-zA-Z0-9]*/)
            "' "
            Capture {
                ChoiceOf {
                    "started"
                    "failed"
                    "passed"
                }
            }
            " at "
            //Capture(OneOrMore(.any))// ❌ OneOrMore(.any) 吸收了后面所有的字符，导致 Optionally(".") 从未被执行
            // ✅ OneOrMore、ZeroOrMore、Optionally、Repeat 所有这些与重复有关的正则构造器，都默认采取贪婪策略（.eager）
            // ✅ 我们需要手动设置 .reluctant 使构造器内的正则尽可能少重复，以避免吸收到句点。
            Capture(OneOrMore(.any, .reluctant))
            Optionally(".")
        }
        
        let r = Regex {
            OneOrMore(.digit)
            "."
            OneOrMore(.digit, .eager)
        }
            .repetitionBehavior(.reluctant)// ✅ .repetitionBehavior() 对某一层级进行全局设置。
        
        for line in testSuiteTestInputs {
            if let (whole, name, status, dateTime) = line.wholeMatch(of: regex)?.output {
                print("Matched: \(name),\(status),\(dateTime)")
            }
        }
    }
    
    // 总结
    func example7() {
        let input = "name: John Appleseed, user_id: 100"
        
        let regex = /user_id:\s*(\d+)/
        
        input.firstMatch(of: regex)
        input.wholeMatch(of: regex)
        input.prefixMatch(of: regex)
        input.matches(of: regex)
        
        input.starts(with: regex)
        input.replacing(regex, with: "456")
        input.trimmingPrefix(regex)
        input.split(separator: /\s*,\s*/)
        
//        switch "abc" {
//        case /\w+/:
//            print("It's a word!")
//        }
    }
}

struct SwiftRegex_Previews: PreviewProvider {
    static var previews: some View {
        SwiftRegex()
    }
}
