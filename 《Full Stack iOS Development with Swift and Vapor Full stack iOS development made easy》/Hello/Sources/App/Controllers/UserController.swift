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
        
        users.get("json", use: allUsers)
        users.get("jsonRes", use: allUsersJson)
        users.get("model", use: allUsersModel)
        users.get("model1", use: allUsersAddrModel)
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
    // 返回json
    func allUsers(request: Request) throws -> [[String:String]] {
        return [["name":"User1"], ["name":"User2"]]
    }
    
    func allUsersJson(request: Request) throws -> Response {
        let users = [["name":"User1", "age":32], ["name":"User2", "age":56]]
        let data = try JSONSerialization.data(withJSONObject: users, options: .prettyPrinted)
        return Response(status: .ok, body: Response.Body(data: data))
    }
    
    func allUsersModel(request: Request) throws -> [User] {
        let users = [User(name: "User1", age: 32), User(name: "User2", age: 32)]
        return users
    }
    
    func allUsersAddrModel(request: Request) throws -> [AUser] {
        let address = Address(street: "Road 8 Rohini sec 8" , state: "Delhi", zip: "110085")
        let users = [AUser(name: "User1", age: 32, address: address)]
        return users
    }
}
