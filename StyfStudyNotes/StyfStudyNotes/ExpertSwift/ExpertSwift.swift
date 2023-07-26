//
//  ExpertSwift.swift
//  StyfStudyNotes
//
//  Created by 申屠云飞 on 2023/7/25.
//

import Foundation

// 1 泛型支持多种类型
// 2 autoclosure解决参数传两个函数调用时，两个都执行
// 3 rethrows 解决需要多个函数抛出版本
// 4 @_transparent是更强的内联，甚至在-Onone级别
@inlinable
func iselse<V>(_ condition: Bool,
               _ valueTure: @autoclosure () throws -> V,
               _ valueFalse: @autoclosure () throws -> V) rethrows -> V {
    condition ? try valueTure() : try valueFalse()
}

//与其拥有像isValid这样的属性，不如在无法创建有效实例时，通过返回nil或抛出更具体的错误来使自定义类型的初始值设定项失败。这种显式失败模式允许您设置代码，以便编译器强制您检查错误。回报是：当你编写一个使用类型的函数时，你不必担心可能无效的半生不熟的实例。这种模式将数据验证和错误处理推送到软件堆栈的上层，并使下层在没有额外检查的情况下高效运行。
struct Email: RawRepresentable {
    var rawValue: String
    init?(rawValue: String) {
        guard rawValue.contains("@") else {
            return nil
        }
        self.rawValue = rawValue
    }
}
