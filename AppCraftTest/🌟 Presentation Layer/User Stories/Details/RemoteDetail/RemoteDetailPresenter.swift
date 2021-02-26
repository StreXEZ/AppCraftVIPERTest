//
//  RemoteDetailPresenter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol RemoteDetailPresenterInput: ViperPresenterInput { }

class RemoteDetailPresenter: ViperPresenter, RemoteDetailPresenterInput, RemoteDetailViewOutput {
    
    // MARK: - Props
    fileprivate var view: RemoteDetailViewInput? {
        guard let view = self._view as? RemoteDetailViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: RemoteDetailRouterInput? {
        guard let router = self._router as? RemoteDetailRouterInput else {
            return nil
        }
        return router
    }
    
    private let viewModel: RemoteDetailViewModel
    private let remoteUseCase: GetSinglePokemonUseCase
    
    // MARK: - Initialization
    init(url: String) {
        self.viewModel = RemoteDetailViewModel(url: url)
        self.remoteUseCase = GetSinglePokemonUseCase()
        super.init()
        remoteUseCase.subscribe(with: self)
    }
    
    // MARK: - RemoteDetailPresenterInput
    
    // MARK: - RemoteDetailViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.remoteUseCase.get(url: viewModel.url ?? "", viewModel: self.viewModel)
    }
        
    // MARK: - Module functions
}

extension RemoteDetailPresenter: GetSinglePokemonUseCaseOutput {
    func error(useCase: GetSinglePokemonUseCase, error: Error) {
        print(error)
    }
    
    func loadPokemon(useCase: GetSinglePokemonUseCase, result: PokemonDetailModel) {
        
    }
}
