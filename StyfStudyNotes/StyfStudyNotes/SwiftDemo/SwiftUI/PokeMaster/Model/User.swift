//
//  User.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Foundation

struct User: Codable {
    var email: String
    
    var favoritePokemonIDs: Set<Int>
    
    func isFavoritePokemon(id: Int) -> Bool {
        favoritePokemonIDs.contains(id)
    }
    
    
}
