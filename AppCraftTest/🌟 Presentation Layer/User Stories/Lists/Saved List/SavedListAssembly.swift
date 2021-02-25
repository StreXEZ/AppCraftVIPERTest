//
//  SavedListAssembly.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

enum SavedListAssembly {
    
    // Create and return controller
    static func create() -> SavedListViewController {
        return SavedListViewController(nibName: SavedListViewController.identifier, bundle: nil)
    }
    
    // Create and link modules with controller, return presenter input
    static func configure(with reference: SavedListViewController) -> SavedListPresenterInput {
        let presenter = SavedListPresenter()
        
        let router = SavedListRouter()
        router._mainController = reference
        
        presenter._view = reference
        presenter._router = router
        
        reference._output = presenter
        
        return presenter
    }
    
}
