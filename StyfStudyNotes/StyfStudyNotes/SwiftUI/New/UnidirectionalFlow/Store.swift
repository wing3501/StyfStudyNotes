//
//  Store.swift
//  TestSwiftUI
//
//  Created by 申屠云飞 on 2023/8/14.
//  https://github.com/mecid/swift-unidirectional-flow

import Observation

@Observable @dynamicMemberLookup public final class Store<State, Action> {
    private (set) var state: State
    private let reducer: any Reducer<State, Action>
    private let middlewares: any Collection<any Middleware<State, Action>>
    
    init(state: State, reducer: any Reducer<State, Action>, middlewares: any Collection<any Middleware<State, Action>>) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    public subscript<T>(dynamicMember keyPath: KeyPath<State, T>) -> T {
        state[keyPath: keyPath]
    }
    
    func send(_ action: Action) async {
        state = reducer.reduce(oldState: state, with: action)
        
        await withTaskGroup(of: Optional<Action>.self) { group in
            middlewares.forEach { middleware in
                group.addTask {
                    await middleware.process(state: self.state, with: action)
                }
            }
            
            for await case let nextAction? in group {
                await send(nextAction)
            }
        }
    }
}
