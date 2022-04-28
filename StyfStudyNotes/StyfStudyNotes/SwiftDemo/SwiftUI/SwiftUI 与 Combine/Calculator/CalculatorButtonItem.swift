//
//  CalculatorButtonItem.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/20.
//

import Foundation

enum CalculatorButtonItem {
    
    enum Op: String {
        case plus = "+"
        case minus = "-"
        case divide = "÷"
        case multiply = "×"
        case equal = "="
    }
    
    enum Command: String {
        case clear = "AC"
        case flip = "+/-"
        case percent = "%"
    }
    
    case digit(Int)
    case dot
    case op(Op)
    case command(Command)
}

// 在 extension 里追加定义必要的外观
// 严格来说，可能将上面的 extension 提取出来，遵照 MVVM 的架构模式将 它定义成一个新的 View Model 类型会更好
extension CalculatorButtonItem: CustomStringConvertible {
    var title: String {
        switch self {
        case .digit(let val): return String(val)
        case .dot: return "."
        case .op(let op): return op.rawValue
        case .command(let com): return com.rawValue
        }
    }
    
    var description: String {
        title
    }
    
    var size: CGSize {
        if case .digit(let val) = self,val == 0 {
            return CGSize(width: 88 * 2 + 8, height: 88)
        }
        return CGSize(width: 88, height: 88)
    }
    
    var backgroundColorName: String {
        switch self {
        case .digit, .dot: return "myGrayColor"
        case .op: return "myOrangeColor"
        case .command: return "myLightGrayColor"
        }
    }
}

extension CalculatorButtonItem: Hashable {}
