//
//  LocalDetailRouter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol LocalDetailRouterInput: ViperRouterInput { }

class LocalDetailRouter: ViperRouter, LocalDetailRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: LocalDetailViewController? {
        guard let mainController = self._mainController as? LocalDetailViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - LocalDetailRouterInput
    
    // MARK: - Module functions
}
