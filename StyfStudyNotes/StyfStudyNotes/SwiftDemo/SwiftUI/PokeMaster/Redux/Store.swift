//
//  Store.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Combine

class Store: ObservableObject {
    @Published var appState = AppState()
}
