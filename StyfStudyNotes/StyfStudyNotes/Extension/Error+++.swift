//
//  Error+++.swift
//  StyfStudyNotes
//
//  Created by 申屠云飞 on 2023/4/28.
//

import Foundation

extension Error {
    /// 一些可以判断网络不稳定的请求错误code，不稳定不代表连接丢失
    /// A collection of error codes that related to network connection failures.
    public var NSURLErrorConnectionFailureCodes: [Int] {
        [
            NSURLErrorBackgroundSessionInUseByAnotherProcess, /// Error Code: `-996`
            NSURLErrorCannotFindHost, /// Error Code: ` -1003`
            NSURLErrorCannotConnectToHost, /// Error Code: ` -1004`
            NSURLErrorNetworkConnectionLost, /// Error Code: ` -1005`
            NSURLErrorNotConnectedToInternet, /// Error Code: ` -1009`
            NSURLErrorSecureConnectionFailed /// Error Code: ` -1200`
        ]
    }
    
    /// Indicates an error which is caused by various connection related issue or an unaccepted status code.
    /// See: `NSURLErrorConnectionFailureCodes`
    var isOtherConnectionError: Bool {
        NSURLErrorConnectionFailureCodes.contains(_code)
    }
}
