//
//  PokemonViewModel.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/22.
//

import Foundation
import SwiftUI

struct PokemonViewModel: Identifiable {
    let pokemon: Pokemon
    let species: PokemonSpecies
    
    var id: Int { pokemon.id }
    let color: Color = .yellow
    
    static var all: [PokemonViewModel] {
        var array: [PokemonViewModel] = []
//        for _ in 1...30 {
//            array.append(PokemonViewModel())
//        }
        return array
    }
    
    
    
    init(_ pokemon: Pokemon,_ species: PokemonSpecies) {
        self.pokemon = pokemon
        self.species = species
    }
}
