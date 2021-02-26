//
//  RemoteDetailAssembly.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

enum RemoteDetailAssembly {
    
    // Create and return controller
    static func create() -> RemoteDetailViewController {
        return RemoteDetailViewController(nibName: RemoteDetailViewController.identifier, bundle: nil)
    }
    
    // Create and link modules with controller, return presenter input
    static func configure(with reference: RemoteDetailViewController, url: String) -> RemoteDetailPresenterInput {
        let presenter = RemoteDetailPresenter(url: url)
        
        let router = RemoteDetailRouter()
        router._mainController = reference
        
        presenter._view = reference
        presenter._router = router
        
        reference._output = presenter
        
        return presenter
    }
    
}
