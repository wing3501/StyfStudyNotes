//
//  KeyChainHelper.swift
//  StyfStudyNotes
//
//  Created by 申屠云飞 on 2023/4/3.
//  https://juejin.cn/post/7195486949526732857

import Foundation

final class KeyChainHelper {
    static let standard = KeyChainHelper()
    private init(){}
    
    func save<T>(_ item: T, service: String, account: String) where T : Codable {
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
            
        } catch {
            assertionFailure("Fail to encode item for keychain: (error)")
        }
    }
    
    func save(_ data: Data, service: String, account: String) {
        
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword, // 代表保存的数据是一个通用的密码项
            kSecAttrService: service, // 当kSecClass被设置为kSecClassGenericPassword的时候，kSecAttrService和kSecAttrAccount这两个键是必须要有的。这两个键所对应的值将作为所保存数据的关键key，换句话说，我们将使用他们从keyChain中读取所保存的值。
            kSecAttrAccount: account,
        ] as CFDictionary
        
//        对于kSecAttrService和kSecAttrAccount所对应的值的定义并没有什么难的。推荐使用字符串。例如：如果我们想存储Facebook的accesToken，我们需要将kSecAttrService设置成”access-token“,将kSecAttrAccount设置成”facebook“
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            // Item already exist, thus update it.
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary

            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            // Update existing item
            SecItemUpdate(query, attributesToUpdate)
        }
        
        if status != errSecSuccess {
            // Print out the error
            print("Error: (status)")
        }
    }
    
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
        
        // Read item data from keychain
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
    func read(service: String, account: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true // 代表的是我们希望query返回对应项的数据
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    func delete(service: String, account: String) {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
}
