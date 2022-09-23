//
//  MemoryManagementInCombine.swift
//
//
//  Created by styf on 2022/9/23.
//  Combine中的内存管理问题
//  Memory management in Combine  https://tanaschita.com/20220912-memory-management-in-combine/

import SwiftUI
import Combine

struct MemoryManagementInCombine: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    
    
    class example1 {
        var lastUpdated = Date()
        var cancellable: AnyCancellable?
        
        func startTimer() {
            cancellable = Timer.publish(every: 1, on: .current, in: .common)
                .autoconnect()
            // ❌ 两种方式都产生了循环引用
//                .assign(to: \.lastUpdated, on: self)
            
//                .sink(receiveValue: { date in
//                    self.lastUpdated = date
//                })
            
            // ✅ 1 [weak self]解决
                .sink(receiveValue: { [weak self] date in
                    self?.lastUpdated = date
                })
        }
        
        func stopTimer() {
            cancellable = nil
        }
        
        
        
    }
}

// MARK: - ✅ 2 解决assign(to:on:)的循环引用问题
// 使用 .assignWeak(to: \.lastUpdated, on: self)
//public extension Publisher where Self.Failure == Never {
//    func assignWeak<T: AnyObject>(to keyPath: ReferenceWritableKeyPath<T, Self.Output>, on object: T) -> AnyCancellable {
//        sink { [weak object] (value) in
//            object?[keyPath: keyPath] = value
//        }
//    }
//}

// MARK: - ✅ 3 使用@Published   Combine基于lastUpdated的生命周期自动管理订阅，但是因为没有持有Cancellable，丧失了手动取消订阅的能力
//@Published private(set) var lastUpdated = Date()
//
//func startTimer() {
//    Timer.publish(every: 1, on: .main, in: .default)
//        .autoconnect()
//        .assign(to: &$lastUpdated)
//}

struct MemoryManagementInCombine_Previews: PreviewProvider {
    static var previews: some View {
        MemoryManagementInCombine()
    }
}
