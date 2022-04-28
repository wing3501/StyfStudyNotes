//
//  PokemonViewModel.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/22.
//

import Foundation
import SwiftUI

struct PokemonViewModel: Identifiable,Codable {
    let pokemon: Pokemon
    let species: PokemonSpecies
    
    var id: Int { pokemon.id }
    
    init(_ pokemon: Pokemon,_ species: PokemonSpecies) {
        self.pokemon = pokemon
        self.species = species
    }
}
