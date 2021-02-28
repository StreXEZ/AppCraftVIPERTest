//
//  RemoteDetailPresenter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol RemoteDetailPresenterInput: ViperPresenterInput {
    
}

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
    private let remoteUseCase: GetSinglePokemonUseCaseInput
    private let localUseCase: PokemonDetailsUseCaseInput
    
    // MARK: - Initialization
    init(url: String) {
        self.viewModel = RemoteDetailViewModel(url: url)
        self.remoteUseCase = GetSinglePokemonUseCase()
        self.localUseCase = PokemonDetailsUseCase()
        super.init()
        beginLoading()
        remoteUseCase.subscribe(with: self)
        localUseCase.subscribe(with: self)
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
    
    override func reloadData() {
        
    }
    
    // MARK: - RemoteDetailPresenterInput
    
    // MARK: - RemoteDetailViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.remoteUseCase.get(url: viewModel.url ?? "")
        finishLoading(with: nil)
    }
        
    // MARK: - Module functions
}

extension RemoteDetailPresenter: GetSinglePokemonUseCaseOutput {
    func error(error: Error) {
        print(error)
    }
    
    func loadPokemon(result: PokemonDetailModel) {
        self.viewModel.pokemon = result
        self.localUseCase.checkPokemon(pokemon: result)
    }
    
    func interactWithLocalDB() {
        guard let saved = viewModel.saved, let pokemon = viewModel.pokemon else { return }
        if saved {
            localUseCase.deletePokemon(pokemon: pokemon)
        } else {
            localUseCase.savePokemon(pokemon: pokemon)
        }
    }
    
}

extension RemoteDetailPresenter: PokemonDetailsUseCaseOutput {
    func pokemonExistance(doesExist: Bool) {
        self.viewModel.saved = doesExist
        view?.localPokemonState(isPokeSaved: doesExist)
    }
    
    func provideDelete() {
        guard let pokemon = self.viewModel.pokemon else { return }
        self.localUseCase.checkPokemon(pokemon: pokemon)
    }
    
    func provideSave() {
        guard let pokemon = self.viewModel.pokemon else { return }
        self.localUseCase.checkPokemon(pokemon: pokemon)
    }
    
    func loadPokemons(result: [PokemonDetailModel]) { }
}
