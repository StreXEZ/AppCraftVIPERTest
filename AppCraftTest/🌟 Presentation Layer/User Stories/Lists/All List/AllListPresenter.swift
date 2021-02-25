//
//  AllListPresenter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol AllListPresenterInput: ViperPresenterInput { }

class AllListPresenter: ViperPresenter, AllListPresenterInput, AllListViewOutput {
    
    // MARK: - Props
    fileprivate var view: AllListViewInput? {
        guard let view = self._view as? AllListViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: AllListRouterInput? {
        guard let router = self._router as? AllListRouterInput else {
            return nil
        }
        return router
    }
    
    private let useCase: GetPokemonsUseCaseInput
    private let viewModel: AllListViewModel
    
    // MARK: - Initialization
    override init() {
        self.viewModel = AllListViewModel()
        self.useCase = GetPokemonsUseCase()
        super.init()
        self.useCase.subscribe(with: self)
        self.useCase.get(viewModel: self.viewModel)
    }
    
    // MARK: - AllListPresenterInput
    
    // MARK: - AllListViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
    }
        
    // MARK: - Module functions
}

extension AllListPresenter: GetPokemonsUseCaseOutput {
    func error(useCase: GetPokemonsUseCase, error: Error) {
        print(error.localizedDescription)
    }
    
    func loadList(useCase: GetPokemonsUseCase, result: PokemonsListModel) {
        print(result)
    }
}
