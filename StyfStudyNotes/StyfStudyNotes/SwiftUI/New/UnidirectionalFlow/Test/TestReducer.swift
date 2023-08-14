//
//  TestReducer.swift
//  TestSwiftUI
//
//  Created by 申屠云飞 on 2023/8/14.
//

import Foundation

struct TestReducer: Reducer {
    func reduce(oldState: TestState, with action: TestAction) -> TestState {
        var state = oldState
        switch action {
        case .start:
            state.msg = "开始了"
        case .increment(let index):
            state.array[index] = 1
            print("处理end----\(String(describing: Thread.current))")
        case .end:
            var isOver = true
            for val in state.array {
                if val == 0 {
                    isOver = false
                }
            }
            if isOver {
                state.msg = "结束了"
            }
        default:
            break
        }
        return state
    }
}
