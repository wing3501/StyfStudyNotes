//
//  CustomUserError.swift
//
//
//  Created by 申屠云飞 on 2024/3/14.
//

import Vapor

enum CustomUserError {
    case userNotLoggedIn
    case invalidEmail(String)
}

// 若要配置特定错误的原因或 HTTP 响应状态，它应符合 AbortError
extension CustomUserError: AbortError {
    var reason: String {
        switch self {
        case .userNotLoggedIn:
            return "User not logged in."
        case .invalidEmail(let email):
            return "Email address not valid: \(email)."
        }
    }
    
    var status: HTTPStatus {
        switch self {
        case .userNotLoggedIn:
            return .unauthorized
        case .invalidEmail:
            return .badRequest
        }
    }
}

// 可调试错误
// 对于自定义的错误日志记录，我们需要使错误符合 DebuggableError。符合 DebuggableError 的自定义错误应为结构，以便它可以在需要时存储源和堆栈跟踪信息。

struct CustomUserError1: DebuggableError {
    enum Value {
        case userNotLoggedIn
        case invalidEmail(String)
    }
    var identifier: String {
        switch self.value {
        case .userNotLoggedIn:
            return "userNotLoggedIn"
        case .invalidEmail:
            return "invalidEmail"
        }
    }
    var reason: String {
        switch self.value {
        case .userNotLoggedIn:
            return "User not logged in."
        case .invalidEmail(let email):
            return "Email address not valid: \(email)."
        }
    }
    
    var value: Value
    var source: ErrorSource?
    
    init(
        _ value: Value,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        column: UInt = #column
    ) {
        self.value = value
        self.source = .init(
            file: file,
            function: function,
            line: line,
            column: column
        )
    }
    
//    默认情况下，Abort 在初始化时捕获当前堆栈跟踪。若要使用自定义错误类型实现此目的，它们需要符合 DebuggableError 并存储 StackTrace.capture()
    var stackTrace: StackTrace? //过期了？
}
