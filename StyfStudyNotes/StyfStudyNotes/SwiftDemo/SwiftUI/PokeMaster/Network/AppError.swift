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
    case fileNotFind
    case networkingFailed(error: Error)
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .passwordWrong: return "密码错误"
        case .fileNotFind: return "文件未找到"
        case .networkingFailed(let error): return error.localizedDescription
        }
    }
}
