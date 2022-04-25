//
//  AppCommand.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Foundation
import Combine

protocol AppCommand {
    //参数 Store 则提供了一个执行后续操作的上下文，让我们可以在副作用执行完毕时，继续 发送新的 Action 来更改 app 状态
    func execute(in store: Store)
}

var anyCancellableSet = Set<AnyCancellable>()

struct LoginAppCommand: AppCommand {
    let email: String
    let password: String
    var anyCancellable: AnyCancellable?
    
    func execute(in store: Store) {
        LoginRequest(email: email, password: password)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
//                    在这里，我们需要通过向 store 发送 Action 来显示错 误。
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
            }, receiveValue: { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
            })
            .store(in: &anyCancellableSet)
    }
}

