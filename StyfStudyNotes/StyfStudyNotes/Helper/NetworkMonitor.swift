//
//  NetworkMonitor.swift
//  StyfStudyNotes
//
//  Created by 申屠云飞 on 2023/4/28.
//

import Foundation
import Network
import CoreTelephony





final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    
    private(set) var isConnected = false
    /// 蜂窝和热点都被认为是昂贵的
    private(set) var isExpensive = false
    
    /// 网络介质 `other`, `wifi`, `cellular`, `wiredEthernet`, or `loopback`
    private(set) var currentConnectionType: NWInterface.InterfaceType?
    
    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
    
    private init() {
        monitor = NWPathMonitor()
        
        
    }
    
    func getNetworkType() -> String {
        let networkInfo = CTTelephonyNetworkInfo()
        
        // 获取当前所有的服务接入技术
        if let radioAccessTechnology = networkInfo.serviceCurrentRadioAccessTechnology {
            for (_, accessTechnology) in radioAccessTechnology {
                switch accessTechnology {
                case CTRadioAccessTechnologyNRNSA, CTRadioAccessTechnologyNR:
                    return "5G" // 5G 网络
                case CTRadioAccessTechnologyLTE:
                    return "4G" // 4G 网络
                default:
                    return "Other" // 其他网络类型
                }
            }
        }
        
        return "No Network"
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.isExpensive = path.isExpensive
            
            // Identifies the current connection type from the
            // list of potential network link types
            self?.currentConnectionType = NWInterface.InterfaceType.allCases.filter { path.usesInterfaceType($0) }.first
            NotificationCenter.default.post(name: .connectivityStatus, object: nil)
        }
        monitor.start(queue: queue)
        
        
       
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

extension NWInterface.InterfaceType: CaseIterable {
    public static var allCases: [NWInterface.InterfaceType] = [
        .other,
        .wifi,
        .cellular,
        .loopback,
        .wiredEthernet
    ]
}

extension Notification.Name {
    static let connectivityStatus = Notification.Name(rawValue: "connectivityStatusChanged")
}
