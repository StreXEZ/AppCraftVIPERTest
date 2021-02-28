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
        beginLoading()
        remoteUseCase.subscribe(with: self)
    }
    
    override func beginLoading() {
        DispatchQueue.main.async {
            BaseLoader().show()
        }
    }
    
    override func finishLoading(with error: Error?) {
        DispatchQueue.main.async {
            BaseLoader().hide()
        }
    }
    
    // MARK: - RemoteDetailPresenterInput
    
    // MARK: - RemoteDetailViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.remoteUseCase.get(url: viewModel.url ?? "")
    }
        
    // MARK: - Module functions
}

extension RemoteDetailPresenter: GetSinglePokemonUseCaseOutput {
    func error(error: Error) {
        print(error)
    }
    
    func loadPokemon(result: PokemonDetailModel) {
        print(result.name)
        finishLoading(with: nil)
    }
}
