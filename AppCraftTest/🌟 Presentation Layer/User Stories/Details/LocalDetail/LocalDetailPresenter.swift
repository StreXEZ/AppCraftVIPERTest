//
//  LocalDetailPresenter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol LocalDetailPresenterInput: ViperPresenterInput {
    
}

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
    private let localUseCase: PokemonDetailsUseCaseInput
    
    // MARK: - Initialization
    init(pokemon: PokemonDetailModel) {
        self.viewModel = LocalDetailViewModel(pokemon: pokemon)
        localUseCase = PokemonDetailsUseCase()
        super.init()
        localUseCase.subscribe(with: self)
        self.beginLoading()
    }
    
    // MARK: - LocalDetailPresenterInput
    
    // MARK: - LocalDetailViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.createRows()
        self.finishLoading(with: nil)
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
    
    func createRows() {
        let rows = [
            PokemonNameCellModel(name: viewModel.pokemon.name),
            PokemonTypeCellModel(isDefault: viewModel.pokemon.is_default),
            BaseExperienceCellModel(baseExp: viewModel.pokemon.base_experience),
            WeightHeightCellModel(height: viewModel.pokemon.height, weight: viewModel.pokemon.weight)]
        view?.updateInfo(with: rows)
        
    }
        
    // MARK: - Module functions
}

extension LocalDetailPresenter {
    func deletePokemon() {
        view?.show(CustomAlerts.deleteAlert { [weak self] in
            guard let self = self else { return }
            self.localUseCase.deletePokemon(pokemon: self.viewModel.pokemon)
        }, animated: true)
    }
}

extension LocalDetailPresenter: PokemonDetailsUseCaseOutput {
    
    func provideDelete() {
        self.router?.goBack(animated: true)
    }
    
    func provideSave() { }
    
    func loadPokemons(result: [PokemonDetailModel]) { }
    
    func pokemonExistance(doesExist: Bool) { }
    
    func error(error: Error) { }
}
