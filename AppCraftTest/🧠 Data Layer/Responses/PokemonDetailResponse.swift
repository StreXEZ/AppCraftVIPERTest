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
    let is_default: Bool
    let name: String
    let base_experience: Int
}

extension PokemonDetailResponse: RemoteMappable {
    func mapResponseToDomain() -> AnyObject? {
        let model = PokemonDetailModel(height: height, weight: weight, id: id, is_default: is_default, name: name, base_experience: base_experience)
        return model as AnyObject
    }
}
