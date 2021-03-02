//
//  PokemonShortResponse.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import GKNetwork

struct PokemonShortResponse: Codable {
    let name: String?
    let url: String?
    
    enum CondingKeys: String, CodingKey {
        case name   = "name"
        case url    = "url"
    }
}

extension PokemonShortResponse: RemoteMappable {
    func mapResponseToDomain() -> AnyObject? {
        guard let name = self.name else { return nil }
        guard let url = self.url else { return nil }
        
        let model = PokemonShortModel(name: name, url: url)
        
        return model as AnyObject
    }
}
