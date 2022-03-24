//
//  PropertyWrapperViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/5/17.
//  Swift中通过 @propertyWrapper 让你的代码变的更简洁:https://www.jianshu.com/p/ff4c048f0cf4

import UIKit

@propertyWrapper /// 先告诉编译器 下面这个UserDefault是一个属性包裹器
struct UserDefault<T> {
    ///这里的属性key 和 defaultValue 还有init方法都是实际业务中的业务代码
    ///我们不需要过多关注
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
///  wrappedValue是@propertyWrapper必须要实现的属性
/// 当操作我们要包裹的属性时  其具体set get方法实际上走的都是wrappedValue 的set get 方法。
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

///封装一个UserDefault配置文件
struct UserDefaultsConfig {
///告诉编译器 我要包裹的是hadShownGuideView这个值。
///实际写法就是在UserDefault包裹器的初始化方法前加了个@
/// hadShownGuideView 属性的一些key和默认值已经在 UserDefault包裹器的构造方法中实现
    @UserDefault("had_shown_guide_view", defaultValue: false)
    static var hadShownGuideView: Bool
///保存用户名称
    @UserDefault("username", defaultValue: "unknown")
    static var username: String
}

class PropertyWrapperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        ///具体的业务代码。
        UserDefaultsConfig.hadShownGuideView = false
        print(UserDefaultsConfig.hadShownGuideView) // false
        UserDefaultsConfig.hadShownGuideView = true
        print(UserDefaultsConfig.hadShownGuideView) // true
    }
}
