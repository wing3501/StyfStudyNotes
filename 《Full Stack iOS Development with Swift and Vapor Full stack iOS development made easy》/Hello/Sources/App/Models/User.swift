//
//  User.swift
//
//
//  Created by 申屠云飞 on 2024/3/14.
//

import Vapor

struct User: Content {
    let name: String
    let age: Int
}

struct AUser: Content {
    let name: String
    let age: Int
    let address : Address
}
