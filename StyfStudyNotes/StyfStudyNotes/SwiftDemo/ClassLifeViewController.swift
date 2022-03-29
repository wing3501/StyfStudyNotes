//
//  ClassLifeViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/3/28.
//  Swift 中的 ARC 机制: 从基础到进阶
//  https://mp.weixin.qq.com/s?__biz=MzI2NTAxMzg2MA==&mid=2247493663&idx=1&sn=1ec1ec2c646ab006289083cb0ed82ff6&scene=21#wechat_redirect

import UIKit

class Traveler {
    var name: String
    var account: Account?
    init(_ name: String) {
        self.name = name
    }
}
class Account {
    weak var traveler: Traveler?
    var points: Int
    func printSummary() {
        if let traveler = traveler {
            print("\(traveler.name) has \(points) points")
        }
    }
    init(_ traveler: Traveler,_ points: Int) {
        self.traveler = traveler
        self.points = points
    }
}

class ClassLifeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let traveler = Traveler("jack")
        let account = Account(traveler, 1000)
        traveler.account = account
        account.printSummary()
        
        //使用 withExtendedLifetime(), 在调用 printSummary() 时主动保证 traveler 的生命周期
        //（注：在 Objective-C ARC 中你可以使用 __attribute__((objc_precise_lifetime)) 或者 NS_VALID_UNTIL_END_OF_SCOPE 来标注变量以达到类似的效果）
        withExtendedLifetime(traveler) {
            account.printSummary()
        }
    }
}
