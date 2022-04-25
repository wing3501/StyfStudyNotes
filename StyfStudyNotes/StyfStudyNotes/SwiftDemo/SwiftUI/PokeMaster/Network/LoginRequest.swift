//
//  LoginRequest.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Foundation
import Combine

struct LoginRequest {
    let email: String
    let password: String
    
    var publisher: AnyPublisher<User,AppError> {
        Future<User, AppError> { promise in
//            把新建的 Future Publisher 发送到后台队列，并延时 1.5 秒执行。这用来模拟 网络请求的延时状况。
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                if password == "123" {
                    let user = User(email: email,favoritePokemonIDs:[])
                    promise(.success(user))
                }else {
                    promise(.failure(.passwordWrong))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
