//
//  PokemonDetailResponse.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation

class PokemonDetailModel {
    var height: Int
    var weight: Int
    var id: Int
    var isDefault: Bool
    var name: String
    var baseExperience: Int
    
    init(name: String = "", weight: Int = 0, id: Int = 0, isDefault: Bool = false, height: Int = 0, baseExperience: Int = 0) {
        self.height = height
        self.weight = weight
        self.id = id
        self.isDefault = isDefault
        self.baseExperience = baseExperience
        self.name = name
    }
}
