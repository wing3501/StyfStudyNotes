//
//  PokemonViewModel.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/22.
//

import Foundation
import SwiftUI

struct PokemonViewModel: Identifiable, Codable {
    let pokemon: Pokemon
    var id: Int { pokemon.id }
    let color: Color = .yellow
    
    static var all: [PokemonViewModel] {
        var array: [PokemonViewModel] = []
        for _ in 1...30 {
            array.append(PokemonViewModel())
        }
        return array
    }
    
    init() {
        pokemon = Pokemon(id: 0)
    }
    
    init(from decoder: Decoder) throws {
        pokemon = Pokemon(id: 0)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
}
