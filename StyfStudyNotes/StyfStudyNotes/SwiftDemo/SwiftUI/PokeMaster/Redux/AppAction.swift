//
//  AppAction.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Foundation

enum AppAction {
    case login(email: String, password: String)
    case accountBehaviorDone(result: Result<User, AppError>)
    case logOff
}
