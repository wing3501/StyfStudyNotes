//
//  UserDefaultsStorage.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Foundation

enum UserDefaultsKey: String {
    case showEnglishName
}

var userDefaultsCache: [UserDefaultsKey: Any] = [:]

@propertyWrapper
struct UserDefaultsStorage<T> {
    
    let key: UserDefaultsKey
    let defaultValue: T
    
    init(key: UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
            userDefaultsCache[key] = newValue
        }
        get {
            if let value = userDefaultsCache[key] {
                return value as! T
            }
            if let value = UserDefaults.standard.value(forKey:key.rawValue) {
                return value as! T
            }
            userDefaultsCache[key] = defaultValue
            return defaultValue
        }
    }
}

