//
//  TestMiddleware.swift
//  TestSwiftUI
//
//  Created by 申屠云飞 on 2023/8/14.
//

import Foundation

struct TestMiddleware: Middleware {
    typealias State = TestState
    typealias Action = TestAction
    
    var index = 0
    
    func process(state: TestState, with action: TestAction) async -> TestAction? {
        switch action {
        case .start:
            print("处理start--\(index)--\(String(describing: Thread.current))")
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            return .increment(index)
        case .increment( _):
            return .end
        default:
            break
        }
        return nil
    }
}
