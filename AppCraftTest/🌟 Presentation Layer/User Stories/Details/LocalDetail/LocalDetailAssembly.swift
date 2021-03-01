//
//  LocalDetailAssembly.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

enum LocalDetailAssembly {
    
    // Create and return controller
    static func create() -> LocalDetailViewController {
        return LocalDetailViewController(nibName: LocalDetailViewController.identifier, bundle: nil)
    }
    
    // Create and link modules with controller, return presenter input
    static func configure(with reference: LocalDetailViewController, pokemon: PokemonDetailModel) -> LocalDetailPresenterInput {
        let presenter = LocalDetailPresenter(pokemon: pokemon)
        
        let router = LocalDetailRouter()
        router._mainController = reference
        
        presenter._view = reference
        presenter._router = router
        
        reference._output = presenter
        
        return presenter
    }
    
}
