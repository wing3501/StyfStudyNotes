//
//  UsingOptionSet.swift
//
//
//  Created by styf on 2023/1/4.
//  OptionSet in Swift explained with code examples  https://www.avanderlee.com/swift/optionset-swift/
//  如何创建和使用OptionSet

import Foundation


// ✅ 如何创建OptionSet，实现协议
struct MyUploadOptions: OptionSet {
    let rawValue: UInt

    static let waitsForConnectivity    = MyUploadOptions(rawValue: 1 << 0)
    static let allowCellular  = MyUploadOptions(rawValue: 1 << 1)
    static let multipathTCPAllowed   = MyUploadOptions(rawValue: 1 << 2)

    static let standard: MyUploadOptions = [.waitsForConnectivity, .allowCellular]
    static let all: MyUploadOptions = [.waitsForConnectivity, .allowCellular, .multipathTCPAllowed]
}

// ✅ 使用OptionSet 
struct MyUploader {
    private let urlSession: URLSession

    init(options: MyUploadOptions) {
        let configuration = URLSessionConfiguration.default

        if options.contains(.multipathTCPAllowed) {
            configuration.multipathServiceType = .handover
        }

        configuration.allowsCellularAccess = options.contains(.allowCellular)
        configuration.waitsForConnectivity = options.contains(.waitsForConnectivity)

        urlSession = URLSession(configuration: configuration)
    }
}
