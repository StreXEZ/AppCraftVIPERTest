//
//  RemoteDetailPresenter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper
import GKRepresentable

protocol RemoteDetailPresenterInput: ViperPresenterInput { }

class RemoteDetailPresenter: ViperPresenter, RemoteDetailPresenterInput {
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
    
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.remoteUseCase.get(url: viewModel.url ?? "")
        finishLoading(with: nil)
    }
    
    
    func createRows() {
        let rows = [PokemonNameCellModel(name: viewModel.pokemon?.name ?? "Name"),
                    PokemonTypeCellModel(isDefault: viewModel.pokemon?.is_default ?? false),
                    BaseExperienceCellModel(baseExp: viewModel.pokemon?.base_experience ?? 0),
                    WeightHeightCellModel(height: viewModel.pokemon?.height ?? 0, weight: viewModel.pokemon?.weight ?? 0),]
        view?.updateInfo(with: rows)
    }
}

// MARK: - GetSinglePokemonUseCaseOutput
extension RemoteDetailPresenter: GetSinglePokemonUseCaseOutput {
    func error(usecase: GetSinglePokemonUseCase, error: Error) {
        guard let error = error as? APIError, error == APIError.noConnection else { return }
        self.router?.goBack(animated: true)
    }
    
    func loadPokemon(usecase: GetSinglePokemonUseCase, result: PokemonDetailModel) {
        self.viewModel.pokemon = result
        self.localUseCase.checkPokemon(pokemon: result)
        self.createRows()
    }
}

extension RemoteDetailPresenter: RemoteDetailViewOutput {
    func interactWithLocalDB() {
        guard let saved = viewModel.saved, let pokemon = viewModel.pokemon else { return }
        if saved {
            view?.show(CustomAlerts.deleteAlert { [weak self] in
                self?.localUseCase.deletePokemon(pokemon: pokemon)
            },animated: true)
        } else {
            localUseCase.savePokemon(pokemon: pokemon)
        }
    }
}

// MARK: - PokemonDetailsUseCaseOutput
extension RemoteDetailPresenter: PokemonDetailsUseCaseOutput {
    func error(error: Error) {
        print(error)
    }
    
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
