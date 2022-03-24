//
//  DynamicStructViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/3/21.
// A站 的 Swift 实践 —— 下篇
// https://mp.weixin.qq.com/s/EIPHLdxBMb5MiRDDfxzJtA

import UIKit


// MARK: 为Swift类型提供动态派发的能力
struct structWithDynamic {
    public var str: String
    public func show(_ str: String) -> String {
        print("Say \(str)")
        return str
    }
    internal func showDynamic(_ obj: AnyObject, str: String) -> String {
        print("showDynamic")
        return show(str)
    }
}

class MyObject { // 这个 Class 不用继承自 NSObject。当然，继承自 NSObject 也没问题。
    @objc dynamic func sayHello() { // 关键字 `@objc` 和 `dynamic` 不可以省略。
        print("Hello!")
    }
}

class DynamicStructViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        
        let obj = MyObject()
        obj.sayHello()
    }
    
    func test() {
        let structValue = structWithDynamic(str: "Hi!")
        // 为 structValue 添加Objc运行时方法
        let block: @convention(block)(AnyObject, String) -> String = structValue.showDynamic
        let imp = imp_implementationWithBlock(unsafeBitCast(block, to: AnyObject.self))
        let dycls: AnyClass = object_getClass(structValue)!
        class_addMethod(dycls, NSSelectorFromString("objcShow:"), imp, "@24@0:8@16")
        // 使用Objc动态派发
        _ = (structValue as AnyObject).perform(NSSelectorFromString("objcShow:"), with: String("Bye!"))!
    }
}
