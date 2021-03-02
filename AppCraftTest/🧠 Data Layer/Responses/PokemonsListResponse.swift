//
//  PokemonesListResponse.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//
import GKNetwork
import Foundation

typealias PokemonsListResponse = [PokemonShortResponse]

extension PokemonsListResponse {
    
    func mapResponseToDomain() -> AnyObject? {
        
        var pokemonsResponse: [PokemonShortModel] = []
        
        for pokemon in self {
            if let pokemonModel = pokemon.mapResponseToDomain() as? PokemonShortModel {
                pokemonsResponse.append(pokemonModel)
            }
        }
        return pokemonsResponse as AnyObject
    }
}

class PokemonsResponse: Codable {
    let results: PokemonsListResponse?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

extension PokemonsResponse: RemoteMappable {
    func mapResponseToDomain() -> AnyObject? {
        guard let results = self.results else { return nil }
        let model = PokemonsListModel(result: results.map { $0.mapResponseToDomain() as? PokemonShortModel } as? [PokemonShortModel] ?? [])
        return model as AnyObject
    }
}
