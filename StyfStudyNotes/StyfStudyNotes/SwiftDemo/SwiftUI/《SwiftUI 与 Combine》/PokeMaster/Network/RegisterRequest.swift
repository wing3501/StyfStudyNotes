//
//  RegisterRequest.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/27.
//

import Foundation
import Combine

struct RegisterRequest {
    let email: String
    let password: String
    
    var publisher: AnyPublisher<User,AppError> {
        Future<User, AppError> { promise in
//            把新建的 Future Publisher 发送到后台队列，并延时 1.5 秒执行。这用来模拟 网络请求的延时状况。
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                let user = User(email: email,favoritePokemonIDs:[])
                promise(.success(user))
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
