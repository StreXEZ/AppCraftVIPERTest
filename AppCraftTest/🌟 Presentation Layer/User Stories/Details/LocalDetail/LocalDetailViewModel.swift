//
//  LocalDetailViewModel.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

class LocalDetailViewModel: ViperViewModel {
    var pokemon: PokemonDetailModel
    
    init(pokemon: PokemonDetailModel) {
        self.pokemon = pokemon
    }
}
