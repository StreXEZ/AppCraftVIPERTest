//
//  AllListAssembly.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

enum AllListAssembly {
    
    // Create and return controller
    static func create() -> AllListViewController {
        return AllListViewController(nibName: AllListViewController.identifier, bundle: nil)
    }
    
    // Create and link modules with controller, return presenter input
    static func configure(with reference: AllListViewController) -> AllListPresenterInput {
        let presenter = AllListPresenter()
        
        let router = AllListRouter()
        router._mainController = reference
        
        presenter._view = reference
        presenter._router = router
        
        reference._output = presenter
        
        return presenter
    }
    
}
