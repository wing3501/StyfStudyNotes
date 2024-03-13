//
//  UserController.swift
//
//
//  Created by 申屠云飞 on 2024/3/13.
//

import Vapor

// 在控制器中，我们将定义不同的路由处理程序
// 最好让控制器负责注册他们控制的路由。Vapor 提供了协议 RouteCollection 来实现这一点。

struct UserController: RouteCollection {
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        //users Group
        let users = routes.grouped("users")
        //Routes
        users.get(use: getAllUsers)
        
        // /user/userId 访问特定用户 ID 的路由
        users.group(":userId") { user in
            user.get(use: show)
        }
    }
    
    func getAllUsers(request: Request) throws -> String {
        return "All Users"
    }
    
    func show(request: Request) throws -> String {
        guard let userId = request.parameters.get("userId") as String? else {
            throw Abort(.badRequest)
        }
        return "Show user for user id = \(userId)"
    }
}
