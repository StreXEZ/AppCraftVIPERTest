//
//  InitialRouter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol InitialRouterInput: ViperRouterInput {
    func presentMain()
}

class InitialRouter: ViperRouter, InitialRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: InitialViewController? {
        guard let mainController = self._mainController as? InitialViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - InitialRouterInput
    
    func presentMain() {
        let vc = CustomTabBarController(firstSelected: 1)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    // MARK: - Module functions
}
