//
//  RemoteDetailRouter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol RemoteDetailRouterInput: ViperRouterInput { }

class RemoteDetailRouter: ViperRouter, RemoteDetailRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: RemoteDetailViewController? {
        guard let mainController = self._mainController as? RemoteDetailViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - RemoteDetailRouterInput
    
    // MARK: - Module functions
}
