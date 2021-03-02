//
//  AllListPresenter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper
import GKRepresentable

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
    private let localUseCase: PokemonDetailsUseCaseInput = PokemonDetailsUseCase()
    private let singlePokemonUseCase: GetSinglePokemonUseCaseInput = GetSinglePokemonUseCase()
    private let viewModel: AllListViewModel
    private let limit = 100
    
    // MARK: - Initialization
    override init() {
        self.viewModel = AllListViewModel()
        self.useCase = GetPokemonsUseCase()
        super.init()
        self.useCase.subscribe(with: self)
        self.localUseCase.subscribe(with: self)
        self.singlePokemonUseCase.subscribe(with: self)
    }
    
    // MARK: - AllListViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.useCase.getPokemons(limit: limit)
    }
    
    func refreshData() {
        self.useCase.getPokemons(limit: limit)
    }
    
    func showDetails(for url: String) {
        self.router?.showDetailPokemon(url: url)
    }
    
    func savePokemon(from url: String) {
        self.singlePokemonUseCase.get(url: url)
    }
    
    func makeSections() {
        let mainSection = TableSectionModel()
        
        self.viewModel.pokemons.result.forEach { item in
            mainSection.rows.append(PokemonTableCellModel(name: item.name, url: item.url))
        }
        
        self.view?.updateSections(with: [mainSection])
    }
}

// MARK: - GetPokemonsUseCaseOutput
extension AllListPresenter: GetPokemonsUseCaseOutput {
    func error(useCase: GetPokemonsUseCase, error: Error) {
        guard let error = error as? APIError, error == APIError.noConnection else { return }
        self.view?.noConnection()
    }
    
    func loadList(useCase: GetPokemonsUseCase, result: PokemonsListModel) {
        self.viewModel.pokemons = result
        self.makeSections()
    }
}

// MARK: - GetSinglePokemonUseCaseOutput
extension AllListPresenter: GetSinglePokemonUseCaseOutput {
    func error(usecase: GetSinglePokemonUseCase, error: Error) {
        print(error)
    }
    
    func loadPokemon(usecase: GetSinglePokemonUseCase, result: PokemonDetailModel) {
        self.localUseCase.savePokemon(pokemon: result)
    }
}

// MARK: - PokemonDetailsUseCaseOutput
extension AllListPresenter: PokemonDetailsUseCaseOutput {
    func error(error: Error) {
        print(error)
    }
    
    func pokemonExistance(doesExist: Bool) {
        if doesExist {
            self.view?.show(title: AppLocalization.Alerts.alreadySavedTitle.localized, message: AppLocalization.Alerts.alreadtSavedBody.localized, animated: true)
        }
    }

    func provideSave() {
        print("Saved")
    }
    
    func provideDelete() { }
}
