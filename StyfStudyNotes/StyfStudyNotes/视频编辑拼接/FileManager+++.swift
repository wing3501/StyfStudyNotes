//
//  FileManager+++.swift
//  
//
//  Created by styf on 2022/10/26.
//

import Foundation

extension FileManager {
    func removeItemIfExisted(_ url:URL) -> Void {
        if FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.removeItem(atPath: url.path)
        }
    }
}
