//
//  InitialPresenter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol InitialPresenterInput: ViperPresenterInput { }

class InitialPresenter: ViperPresenter, InitialPresenterInput, InitialViewOutput {
    
    // MARK: - Props
    fileprivate var view: InitialViewInput? {
        guard let view = self._view as? InitialViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: InitialRouterInput? {
        guard let router = self._router as? InitialRouterInput else {
            return nil
        }
        return router
    }
    
    var viewModel: InitialViewModel
    
    // MARK: - Initialization
    override init() {
        self.viewModel = InitialViewModel()
    }
    
    // MARK: - InitialPresenterInput
    
    // MARK: - InitialViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
    }
    
    func viewWillAppear() {
        self.router?.presentMain()
    }
    
    // MARK: - Module functions
}
