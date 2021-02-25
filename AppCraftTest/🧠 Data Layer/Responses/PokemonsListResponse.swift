//
//  PokemonesListResponse.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//
import GKNetwork
import Foundation

struct PokemonsListResponse: Codable {
    let results: [PokemonShortResponse]
}

extension PokemonsListResponse: RemoteMappable {
    func mapResponseToDomain() -> AnyObject? {
        let model = PokemonsListModel(result: results.map { $0.mapResponseToDomain() as? PokemonShortModel } as? [PokemonShortModel] ?? [])
        return model as AnyObject
    }
}
