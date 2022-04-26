//
//  LoadPokemonRequest.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/26.
//

import Foundation
import Combine

let appDecoder = JSONDecoder()

struct LoadPokemonRequest {
    let id: Int
    
    static var all: AnyPublisher<[PokemonViewModel], AppError> {
        (1...30).map {
            LoadPokemonRequest(id: $0).publisher
        }.zipAll
    }
    
//    在 LoadPokemonRequest 添加一个计算属性，它将 pokemonPublisher 和 speciesPublisher 组合起来，提供 获取 PokemonViewModel 的 Publisher
    var publisher: AnyPublisher<PokemonViewModel, AppError> {
        pokemonPublisher(id)
            .flatMap { pokemon in
                speciesPublisher(pokemon)
            }
            .map { (pokemon,species) in
                PokemonViewModel(pokemon, species)
            }
            .mapError { error in
                AppError.networkingFailed(error: error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func pokemonPublisher(_ id: Int) -> AnyPublisher<Pokemon,Error> {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!)
            .map { $0.data }
            .decode(type: Pokemon.self, decoder: appDecoder)
            .eraseToAnyPublisher()
    }
    
    func speciesPublisher(_ pokemon: Pokemon) -> AnyPublisher<(Pokemon, PokemonSpecies), Error> {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: pokemon.species.url ?? "")!)
            .map {$0.data}
            .decode(type: PokemonSpecies.self, decoder: appDecoder)
            .map { (pokemon, $0) }
            .eraseToAnyPublisher()
    }
}
