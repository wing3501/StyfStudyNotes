//
//  UserDefaults+++.swift
//  
//
//  Created by styf on 2022/8/25.
//

import Foundation

extension UserDefaults {
    
    // 增加对枚举等类型的支持
    func set<T>(value tValue: T, forKey key: String) -> Bool where T: Encodable {
        if let data = try? JSONEncoder().encode(tValue) {
            self.set(data, forKey: key)
            return true
        }
        return false
    }
    
    func value<T>(forKey defaultName: String,with type: T.Type) -> T? where T: Decodable {
        if let savedData = self.data(forKey: defaultName) {
            return try? JSONDecoder().decode(type, from: savedData)
        }
        return nil
    }
}


