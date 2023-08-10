//
//  String+++.swift
//  StyfStudyNotes
//
//  Created by 申屠云飞 on 2023/8/10.
//

import Foundation


extension String.StringInterpolation {

    /// Prints `Optional` values by only interpolating it if the value is set. `nil` is used as a fallback value to provide a clear output.
    mutating func appendInterpolation<T: CustomStringConvertible>(_ value: T?) {
        appendInterpolation(value ?? "nil" as CustomStringConvertible)
    }
}
