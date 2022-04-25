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
        
        var showEnglishName = true
        var sorting = Sorting.id
        var showFavoriteOnly = false
    }
}

