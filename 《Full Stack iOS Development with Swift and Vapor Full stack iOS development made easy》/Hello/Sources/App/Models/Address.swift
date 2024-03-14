//
//  Address.swift
//
//
//  Created by 申屠云飞 on 2024/3/14.
//

import Vapor

struct Address: Content {
    let street : String
    let state : String
    let zip : String
}
