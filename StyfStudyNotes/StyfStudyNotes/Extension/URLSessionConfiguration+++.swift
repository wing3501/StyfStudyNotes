//
//  URLSessionConfiguration+++.swift
//  StyfStudyNotes
//
//  Created by 申屠云飞 on 2023/4/28.
//  https://www.avanderlee.com/swift/optimizing-network-reachability/

import Foundation
 
extension URLSessionConfiguration {
    
    /// 设置连接等待，可以优化短暂网络异常恢复情况，比如电梯
    /// 比起请求前做可达性判断，设置连接等待更好
    static func setupWaitForConnectivity() {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60 // 1 minute
        configuration.timeoutIntervalForResource = 60 * 60 // 1 hour
    }
    
    /// 设置只允许发出wifi请求
    static func restrictOnlyWifi() {
        let configuration = URLSessionConfiguration.default

        /// Set to `false` to only allow WiFi/Ethernet.
        configuration.allowsCellularAccess = false

        /// Set to `false` to prevent your app from using network interfaces that the system considers expensive.
        configuration.allowsExpensiveNetworkAccess = false

        /// Indicates whether connections may use the network when the user has specified Low Data Mode.
        configuration.allowsConstrainedNetworkAccess = true
    }
}
