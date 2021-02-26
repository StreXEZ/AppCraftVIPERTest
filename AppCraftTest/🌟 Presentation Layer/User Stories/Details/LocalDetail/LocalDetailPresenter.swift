//
//  LocalDetailPresenter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol LocalDetailPresenterInput: ViperPresenterInput { }

class LocalDetailPresenter: ViperPresenter, LocalDetailPresenterInput, LocalDetailViewOutput {
    
    // MARK: - Props
    fileprivate var view: LocalDetailViewInput? {
        guard let view = self._view as? LocalDetailViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: LocalDetailRouterInput? {
        guard let router = self._router as? LocalDetailRouterInput else {
            return nil
        }
        return router
    }
    
    var viewModel: LocalDetailViewModel
    
    // MARK: - Initialization
    override init() {
        self.viewModel = LocalDetailViewModel()
    }
    
    // MARK: - LocalDetailPresenterInput
    
    // MARK: - LocalDetailViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
    }
        
    // MARK: - Module functions
}
