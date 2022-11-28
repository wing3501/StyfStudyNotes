//
//  DynamicMemberLookupController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/3/17.
//  Swift @dynamicMemberLookup和@dynamicCallable   https://www.jianshu.com/p/6a19668dd4c4
//  Dynamic Member Lookup combined with key paths in Swift
//  https://www.avanderlee.com/swift/dynamic-member-lookup/
//  @dynamicMemberLookup 让类和结构体，支持动态成员查找

// @dynamicCallable in Swift explained with code examples
//  https://www.avanderlee.com/swift/dynamiccallable/

import UIKit

@dynamicCallable
@dynamicMemberLookup
class JSONObject {
    var value: [String: Any] = [:]
    required init(_ value: [String: Any] = [:]) {
        self.value = value
    }
    subscript<T>(dynamicMember member: String) ->T? where T: Any {
        get {
            value[member] as? T
        }
        set {
            value[member] = newValue
        }
    }
    
    static var new: Self { Self() }
    func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Any>) -> Self {
        for item in args {
            value[item.0] = item.1
        }
        return self
    }
}

@dynamicMemberLookup
class MathObject {
    var params: [String: Any] = [:]
    subscript(dynamicMember member: String) -> (Int) -> (Int) {
        get {
            params[member] as! ((Int)->(Int))
        }
        set {
            params[member] = newValue
        }
    }
    
    subscript(dynamicMember member: String) -> (Double,Double) -> (Double) {
        get {
            params[member] as! ((Double,Double)->(Double))
        }
        set {
            params[member] = newValue
        }
    }
}

@dynamicMemberLookup
struct NotificationWrapper {
    let notification: Notification

    subscript(dynamicMember string: String) -> String {
        return notification.userInfo?[string] as? String ?? ""
    }
}
// ❌ 允许我们访问userInfo字符串的值，但是访问age时就会返回空字符串
//let notificationWrapper = NotificationWrapper(notification: Notification(name: Notification.Name(rawValue: "user_did_login"), object: nil, userInfo: ["name": "Antoine van der Lee", "age": 28]))
//print(notificationWrapper.name)

// 结合KeyPath使用
struct Blog {
    let title: String
    let url: URL
}

@dynamicMemberLookup
struct Blogger {
    let name: String
    let blog: Blog

    subscript<T>(dynamicMember keyPath: KeyPath<Blog, T>) -> T {
        return blog[keyPath: keyPath]
    }
}
// 一个@dynamicCallable例子
@dynamicMemberLookup
@dynamicCallable
final class NamesCache {
    private var names: [String] = []
    
    // 结合@dynamicMemberLookup使用
    subscript<T>(dynamicMember keyPath: KeyPath<[String], T>) -> T {
        return names[keyPath: keyPath] // 对NamesCache的count、description方法的调用都落到了names上
    }

    @discardableResult  // 支持了cache(contains: "Antoine")的调用
    func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, String>) -> Bool {
        for (key, value) in args {
            if key == "contains" {
                return names.contains(value)
            } else if key == "store" {
                names.append(value)
                return true
            }
        }
        return false
    }
    // 不是所有其他语言都有关键词参数，所以也提供了数组参数  cache("store", "Antoine")
    @discardableResult
    func dynamicallyCall(withArguments args: [String]) -> Bool {
        let pairs = stride(from: 0, to: args.endIndex, by: 2).map { argumentIndex in
            let lhsArgument = args[argumentIndex]
            let rhsArgument = argumentIndex < args.index(before: args.endIndex) ? args[argumentIndex.advanced(by: 1)] : nil
            return (lhsArgument, rhsArgument)
        }

        for (key, value) in pairs {
            guard let value else { continue }

            if key == "contains" {
                return names.contains(value)
            } else if key == "store" {
                names.append(value)
                return true
            }
        }
        return false
    }
}

class DynamicMemberLookupController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        var json = JSONObject()
        json.a = 1
        json.b = "hello"
        let a: Int? = json.a
        let b: String? = json.b
        print(a,b)
        
        json = JSONObject.new(name: "Tom",age: 18)
        let name: String? = json.name
        let age: Int? = json.age
        print(name,age)
        
        let math = MathObject()
        math.add = {$0 + $1}
        math.negate = {-$0}
        print(math.add(1.0,2.0))
        print(math.negate(1))
        
        let blog = Blog(title: "标题", url: URL(string: "https://baidu.com")!)
        let bloger = Blogger(name: "标题1", blog: blog)
        let title = bloger.title
        let url = bloger.url
        // 动态调用contains、store
        let cache = NamesCache()
        cache(contains: "Antoine") // Prints: false
        cache(store: "Antoine") // Prints: true
        cache(contains: "Antoine") // Prints: true
        
        cache("store", "Antoine") // Prints: true
        // 结合@dynamicMemberLookup使用
        cache(contains: "Maaike") // Prints: false
        cache(store: "Maaike") // Prints: true
        cache(contains: "Maaike") // Prints: true

        cache.count // Prints: 1
        cache.description // Prints: ["Maaike"]
    }
    

   
}
