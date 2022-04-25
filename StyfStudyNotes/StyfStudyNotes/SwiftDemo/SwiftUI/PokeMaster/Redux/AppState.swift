//
//  AppState.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Combine

struct AppState {
    var settings = Settings()
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id, name, color, favorite
        }
        enum AccountBehavior: CaseIterable {
            case register, login
        }
        
        var accountBehavior = AccountBehavior.login
        var email = ""
        var password = ""
        var verifyPassword = ""
        
        @UserDefaultsStorage(key: .showEnglishName, defaultValue: false)
        var showEnglishName: Bool
        
        var sorting = Sorting.id
        var showFavoriteOnly = false
        
//        在这个架构中，我们规定一个特例，那就是对于 “纯副作用”，我们可以考虑通过属 性的 didSet 来执行这个副作用，而跳过严格的 Command 流程。像是将 loginUser 写入磁盘或者从磁盘读出这样的任务，就非常符合这个情景。
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?
        var loginRequesting = false
        var loginError: AppError?
    }
}
