//
//  DynamicMemberLookupController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/3/17.
//  Swift @dynamicMemberLookup和@dynamicCallable   https://www.jianshu.com/p/6a19668dd4c4
//

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
    }
    

   
}
