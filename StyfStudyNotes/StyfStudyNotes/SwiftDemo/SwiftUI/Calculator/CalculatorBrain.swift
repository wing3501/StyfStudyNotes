//
//  CalculatorBrain.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/21.
//

import Foundation
//状态机
enum CalculatorBrain {
    case left(String)
    case leftOp(left: String,op: CalculatorButtonItem.Op)
    case leftOpRight(left: String, op: CalculatorButtonItem.Op, right: String)
    case error
    
    // 用于显示结果字符串
    var output: String {
        let result: String
        switch self {
        case .left(let left): result = left
        case .leftOp(let left,let op): result = left // TODO
        case .leftOpRight(let left,let op,let right): result = left // TODO
        case .error: result = "" // TODO
        }
        guard let value = Double(result) else { return "Error" }
        return formatter.string(from: value as NSNumber)!
    }
    
    func apply(item: CalculatorButtonItem) -> CalculatorBrain {
        switch item {
        case .digit(let num): return apply(num)
        case .dot: return applyDot()
        case .op(let op): return apply(op)
        case .command(let command): return apply(command)
        }
    }
    
    func apply(_ num: Int) -> CalculatorBrain {
        // TODO
        CalculatorBrain.left("")
    }
    
    func applyDot() -> CalculatorBrain {
        // TODO
        CalculatorBrain.left("")
    }
    
    func apply(_ op: CalculatorButtonItem.Op) -> CalculatorBrain {
        // TODO
        CalculatorBrain.left("")
    }
    func apply(_ command: CalculatorButtonItem.Command) -> CalculatorBrain {
        // TODO
        CalculatorBrain.left("")
    }
}

var formatter: NumberFormatter = {
    let f = NumberFormatter()
//        数字小数点后位数限定在八位以 内
    f.minimumFractionDigits = 0
    f.maximumIntegerDigits = 8
    f.numberStyle = .decimal
    return f
}()

typealias CalculatorState = CalculatorBrain
typealias CalculatorStateAction = CalculatorButtonItem

struct Reducer {
    static func reduce(state: CalculatorState, action:CalculatorStateAction) -> CalculatorState {
        return state.apply(item: action)
    }
}
