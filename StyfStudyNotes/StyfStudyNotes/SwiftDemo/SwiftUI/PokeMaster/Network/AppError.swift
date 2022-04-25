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
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .passwordWrong: return "密码错误"
        case .fileNotFind: return "文件未找到"
        }
    }
}
