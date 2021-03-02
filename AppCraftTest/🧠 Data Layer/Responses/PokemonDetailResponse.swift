//
//  PokemonDetailResponse.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import GKNetwork

struct PokemonDetailResponse: Codable {
    let height: Int
    let weight: Int
    let id: Int
    let isDefault: Bool
    let name: String
    let baseExperience: Int
    
    enum CodingKeys: String, CodingKey {
        case height         = "height"
        case weight         = "weight"
        case id             = "id"
        case isDefault      = "is_default"
        case name           = "name"
        case baseExperience = "base_experience"
    }
}

extension PokemonDetailResponse: RemoteMappable {
    func mapResponseToDomain() -> AnyObject? {
        let model = PokemonDetailModel(name: name, weight: weight, id: id, isDefault: isDefault, height: height, baseExperience: baseExperience)
        return model as AnyObject
    }
}
