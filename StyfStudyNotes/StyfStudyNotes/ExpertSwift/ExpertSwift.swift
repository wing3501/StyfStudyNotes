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
