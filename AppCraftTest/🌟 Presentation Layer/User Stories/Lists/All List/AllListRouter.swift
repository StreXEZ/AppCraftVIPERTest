//
//  AllListRouter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol AllListRouterInput: ViperRouterInput { }

class AllListRouter: ViperRouter, AllListRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: AllListViewController? {
        guard let mainController = self._mainController as? AllListViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - AllListRouterInput
    
    // MARK: - Module functions
}
