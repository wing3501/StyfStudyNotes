//
//  Middleware.swift
//  TestSwiftUI
//
//  Created by 申屠云飞 on 2023/8/14.
//

import Foundation

public protocol Middleware<State, Action> {
    associatedtype State
    associatedtype Action
    func process(state: State, with action: Action) async -> Action?
}
