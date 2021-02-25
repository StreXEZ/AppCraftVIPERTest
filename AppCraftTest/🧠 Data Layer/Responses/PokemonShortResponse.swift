//
//  PokemonShortResponse.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import GKNetwork

struct PokemonShortResponse: Codable {
    let name: String
    let url: String
}

extension PokemonShortResponse: RemoteMappable {
    func mapResponseToDomain() -> AnyObject? {
        let model = PokemonShortModel(name: self.name, url: self.url)
        return model as AnyObject
    }
}
