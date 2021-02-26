//
//  PokemonDetailResponse.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation

class PokemonDetailModel  {
    var height: Int
    var weight: Int
    var id: Int
    var is_default: Bool
    var name: String
    var base_experience: Int
    
    init(name: String = "", weight: Int = 0, id: Int = 0, is_default: Bool = false, height: Int = 0, base_experience: Int = 0) {
        self.height = height
        self.weight = weight
        self.id = id
        self.is_default = is_default
        self.base_experience = base_experience
        self.name = name
    }
}
