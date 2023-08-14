//
//  UseKeyPath.swift
//  TestSwiftUI
//
//  Created by 申屠云飞 on 2023/8/14.
//  https://sarunw.com/posts/what-is-keypath-in-swift/

import Foundation

class KeyPathTest {
    // 1
    struct User {
        let name: String
        let email: String
        let address: Address?
        let role: Role
    }

    // 2
    struct Address {
        let street: String
    }

    // 3
    enum Role {
        case admin
        case member
        case guest
        
        var permissions: [Permission] {
            switch self {
            case .admin:
                return [.create, .read, .update, .delete]
            case .member:
                return [.create, .read]
            case .guest:
                return [.read]
            }
        }
    }

    // 4
    enum Permission {
        case create
        case read
        case update
        case delete
    }

    // ✅ keypath表达式  \type name.path
    // 1
    let stringDebugDescription = \String.debugDescription
    // KeyPath

    // 2
    let userRole = \User.role
    // KeyPath

    // 3
    let firstIndexInteger = \[Int][0]
    // WritableKeyPath<[Int], Int>

    // 4
    let firstInteger = \Array<Int>.first
    // KeyPath<[Int], Int?>
    
    func test() {
        let user = User(name: "", email: "", address: Address(street: ""), role: .admin)
        let streetValue = user.address?.street
        // KeyPath version referencing the same value.
        let streetKeyPath = \User.address?.street
        
        // ✅ 三种只读keypath
        // KeyPath  针对值类型、引用类型
        // ParialKeyPath
        // AnyKeyPath

        // 两种读写keypath
        // WritableKeyPath 值类型 struct enum
        // ReferenceWritableKeyPath 引用类型
        
        // ✅ 使用keypath访问
        let userRoleKeyPath = \User.role
        let role = user[keyPath: userRoleKeyPath]
        // user[keyPath: userRoleKeyPath] = .guest //虽然使用的是WritableKeyPath，但是结构体依然需要是var才能修改
        
        // ✅ 运行时错误
        let fourthIndexInteger = \[Int][3]
        let integers = [0, 1, 2]
        print(integers[keyPath: fourthIndexInteger])// 运行时错误
        
        let user1 = User(
            name: "Sarunw",
            email: "sarunw@example.com",
            address: nil,
            role: .admin)

        let forceStreetAddress = \User.address!.street
        print(user1[keyPath: forceStreetAddress])
        
        // ✅ 表示整个实例
        var foo = "Foo"
        let stringIdentity = \String.self
        foo[keyPath: stringIdentity] = "Bar"
        print(foo) // Bar
        
        let userIdentity = \User.self
        // WritableKeyPath<User, User>
        
        var user2 = User(name: "", email: "", address: Address(street: ""), role: .admin)
        user2[keyPath: userIdentity] = User(name: "", email: "", address: Address(street: ""), role: .admin)
        print(user) 
    }
}

