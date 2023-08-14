//
//  Reducer.swift
//  TestSwiftUI
//
//  Created by 申屠云飞 on 2023/8/14.
//

import Foundation

public protocol Reducer<State, Action> {
    associatedtype State
    associatedtype Action
    
    /// The function returning a new state by taking an old state and an action.
    func reduce(oldState: State, with action: Action) -> State
}

/// A type conforming to the `Reducer` protocol that doesn't apply any mutation to the old state.
public struct IdentityReducer<State, Action>: Reducer {
    public func reduce(oldState: State, with action: Action) -> State {
        oldState
    }
}
