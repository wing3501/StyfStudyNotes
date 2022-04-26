//
//  EmailCheckingRequest.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/26.
//

import Foundation
import Combine

struct EmailCheckingRequest {
    let email: String
    
    var publisher: AnyPublisher<Bool,Never> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                if email.lowercased() == "174481103@qq.com" {
                    promise(.success(true))
                }else {
                    promise(.success(false))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
