//
//  URL+++.swift
//  StyfStudyNotes
//
//  Created by 申屠云飞 on 2023/8/10.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    /// 字面量初始化
    /// 使用 let url: URL = "https://www.avanderlee.com"
    public init(stringLiteral value: String) {
        self.init(string: "\(value)")!
    }
}


