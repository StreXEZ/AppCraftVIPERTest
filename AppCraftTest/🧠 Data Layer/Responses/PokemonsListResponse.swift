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
        let model = PokemonsListResponse(results: results)
        return model as AnyObject
    }
}
