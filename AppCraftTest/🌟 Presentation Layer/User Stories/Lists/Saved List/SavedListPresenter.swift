//
//  SavedListPresenter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol SavedListPresenterInput: ViperPresenterInput { }

class SavedListPresenter: ViperPresenter, SavedListPresenterInput, SavedListViewOutput {
    
    // MARK: - Props
    fileprivate var view: SavedListViewInput? {
        guard let view = self._view as? SavedListViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: SavedListRouterInput? {
        guard let router = self._router as? SavedListRouterInput else {
            return nil
        }
        return router
    }
    
    var viewModel: SavedListViewModel
    
    // MARK: - Initialization
    override init() {
        self.viewModel = SavedListViewModel()
    }
    
    // MARK: - SavedListPresenterInput
    
    // MARK: - SavedListViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
    }
        
    // MARK: - Module functions
}
