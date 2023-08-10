//
//  Sequence+++.swift
//  StyfStudyNotes
//
//  Created by 申屠云飞 on 2023/8/10.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    
    /// 去重
    /// https://www.avanderlee.com/swift/unique-values-removing-duplicates-array/
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
