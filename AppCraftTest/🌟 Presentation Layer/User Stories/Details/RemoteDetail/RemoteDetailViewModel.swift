//
//  RemoteDetailViewModel.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

class RemoteDetailViewModel: ViperViewModel {
    var url: String?
    var pokemon: PokemonDetailModel?
    
    init(url: String) {
        self.url = url
    }
}
