//
//  ExpressibleByStringLiteral+++.swift
//  StyfStudyNotes
//
//  Created by 申屠云飞 on 2023/8/10.
//

import Foundation

/// https://www.avanderlee.com/swift/expressible-literals/
extension ExpressibleByUnicodeScalarLiteral where Self: ExpressibleByStringLiteral, Self.StringLiteralType == String {
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}

extension ExpressibleByExtendedGraphemeClusterLiteral where Self: ExpressibleByStringLiteral, Self.StringLiteralType == String {
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
}
