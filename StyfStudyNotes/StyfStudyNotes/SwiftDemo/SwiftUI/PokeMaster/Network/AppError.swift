//
//  AppError.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Foundation

enum AppError: Error,Identifiable {
    var id: String { localizedDescription }
    case passwordWrong
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .passwordWrong: return "密码错误"
        }
    }
}
