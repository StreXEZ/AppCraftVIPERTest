//
//  AllListRouter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol AllListRouterInput: ViperRouterInput {
    func showDetailPokemon(url: String)
}

class AllListRouter: ViperRouter, AllListRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: AllListViewController? {
        guard let mainController = self._mainController as? AllListViewController else {
            return nil
        }
        return mainController
    }
    
    func showDetailPokemon(url: String) {
        let vc = RemoteDetailAssembly.create()
        let _ = RemoteDetailAssembly.configure(with: vc, url: url)
        self.push(to: vc, animated: true)
    }
}
