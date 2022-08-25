//
//  SaveEnumInUserDefaults.swift
//  在userdefaults中保存枚举
//  https://sarunw.com/posts/how-to-save-enum-in-userdefaults-using-swift/
//  https://sarunw.com/posts/how-to-save-enum-associated-value-in-userdefaults-using-swift/
//  Created by styf on 2022/8/25.
//

import SwiftUI

struct SaveEnumInUserDefaults: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                //saveEnumWithRawValue()
                //saveEnumWithAssociatedValue()
                test()
            }
    }
    
    enum MyColor {
        case red
        case green
        case yellow
    }

    enum MyColor1: Int {
        case red
        case green
        case yellow
    }
    
    func saveEnumWithRawValue() -> Void {
//        UserDefaults.standard.setValue(MyColor.red, forKey: "myColor")//❌
        
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(MyColor1.red.rawValue, forKey: "myColor")
        
        let rawValue = userDefaults.integer(forKey: "frequency")
        print(rawValue)
        let color = MyColor1(rawValue: rawValue)
        print(color)
    }
    
    
    enum Role {
        case guest
        case member(String?)
    }
    // 实现Codable协议的枚举，有两种方式写入和读取UserDefaults：Data,Dictionary
    enum Role1: Codable {
        case guest
        case member(String?)
    }
    
    func saveEnumWithAssociatedValue() -> Void {
        // 1 Data
        let userDefaults = UserDefaults.standard
                
        // Write
        if let data = try? JSONEncoder().encode(Role1.member("styf")) {
            userDefaults.set(
                data,
                forKey: "role")
        }

        // Read
        if let savedData = userDefaults.data(forKey: "role") {
            let role = try? JSONDecoder().decode(Role1.self, from: savedData)
            print(role)
        }
        //--------------------
        // 2 Dictionary
        
        // Write
        if let data = try? JSONEncoder().encode(Role1.member("styf")),
           let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        {
            userDefaults.set(
                dict,
                forKey: "role")
        }

        // Read
        if let rawDictionary = userDefaults.dictionary(forKey: "role"),
           let dictData = try? JSONSerialization.data(withJSONObject: rawDictionary)
        {
            let role = try? JSONDecoder().decode(Role1.self, from: dictData)
        }
    }
    
    
    func test() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value: Role1.member("123"), forKey: "styf")
        let value = userDefaults.value(forKey: "styf", with: Role1.self)
        print(value)
    }
}

struct SaveEnumInUserDefaults_Previews: PreviewProvider {
    static var previews: some View {
        SaveEnumInUserDefaults()
    }
}
