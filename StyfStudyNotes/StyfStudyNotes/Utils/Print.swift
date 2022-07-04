//
//  Print.swift
//  MyFetchApp
//
//  Created by styf on 2022/6/13.
//

import Foundation


private class PrintHelper {
    var df: DateFormatter
    static let shared = PrintHelper()
    init() {
        df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    var now: String {
        return df.string(from: Date())
    }
}

func NSLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
//    #if DEBUG
    let fileName = (file as NSString).lastPathComponent.split(separator: ".").first!
    print("\(PrintHelper.shared.now) \(fileName):\(lineNumber) \(function) - \(message)")
//    #endif
}

