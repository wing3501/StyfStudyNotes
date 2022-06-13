//
//  SaveKeyDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/6/13.
//

import UIKit

@objc(SaveKeyDemo)
class SaveKeyDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
        print("--------\(SaveKeyDemo.getSaveKey())")
    }
    
    static let ENCRYPTKEY: UInt8 = 0xAA
    
    static func getSaveKey() -> String {
        let key = [(ENCRYPTKEY ^ Character("s").asciiValue!),
                   (ENCRYPTKEY ^ Character("t").asciiValue!)]
        var result: [UInt8] = []
        for item in key {
            result.append(item ^ ENCRYPTKEY)
        }
        result.append(0)
        let ptr: UnsafePointer<UInt8> = withUnsafePointer(to: &result[0]) { $0 }
        let str: String = String(cString: ptr)
        return str
    }
}
