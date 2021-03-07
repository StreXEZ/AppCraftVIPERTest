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
    private let savedPokemonsUseCase: GetLocalPokemonsUseCaseInput = GetLocalPokemonsUseCase()
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
        self.savedPokemonsUseCase.subscribe(with: self)
    }
    
    // MARK: - AllListViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.useCase.getPokemons(limit: limit)
    }
    
    func refreshData() {
        self.useCase.getPokemons(limit: limit)
    }
    
    func showDetails(for url: String, state: Bool) {
        self.router?.showDetailPokemon(url: url, state: state, output: self)
    }
    
    func savePokemon(from url: String) {
        self.beginLoading()
        self.singlePokemonUseCase.get(url: url)
    }
    
    func deletePokemon(by name: String) {
        self.view?.show(CustomAlerts.deleteAlert { [weak self] in
            guard let self = self else { return }
            self.localUseCase.deletePokemon(pokemon: name)
            self.beginLoading()
        }, animated: true)
    }
    
    func makeSections() {
        let mainSection = TableSectionModel()
        
        self.viewModel.pokemons.result.forEach { item in
            let model = PokemonTableCellModel(name: item.name, url: item.url, isSaved: item.isSaved ?? false)
            model.actionCallback = { [weak self, weak model] in
                guard let self = self else { return }
                if model?.isSaved ?? false {
                    self.deletePokemon(by: item.name)
                } else {
                    self.savePokemon(from: item.url)
                }
            }
            mainSection.rows.append(model)
        }
        self.finishLoading(with: nil)
        self.view?.updateSections(with: [mainSection])
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
}

// MARK: - GetPokemonsUseCaseOutput
extension AllListPresenter: GetPokemonsUseCaseOutput {
    func error(useCase: GetPokemonsUseCase, error: Error) {
        guard let error = error as? APIError, error == APIError.noConnection else { return }
        self.view?.noConnection()
    }
    
    func loadList(useCase: GetPokemonsUseCase, result: PokemonsListModel) {
        self.viewModel.pokemons = result
        self.savedPokemonsUseCase.fetchSavedPokemons()
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
    func provideDelete(for name: String) {
        guard let id = self.viewModel.pokemons.result.firstIndex(where: { poke -> Bool in
            poke.name == name
        }) else { return }
        self.viewModel.pokemons.result[id].isSaved = false
        makeSections()
    }
    
    func provideSave(for name: String) {
        guard let id = self.viewModel.pokemons.result.firstIndex(where: { poke -> Bool in
            poke.name == name
        }) else { return }
        self.viewModel.pokemons.result[id].isSaved = true
        makeSections()
    }
    
    func error(error: Error) {
        self.refreshData()
    }
    
    func pokemonExistance(doesExist: Bool) {
        if doesExist {
            self.view?.show(title: AppLocalization.Alerts.alreadySavedTitle.localized, message: AppLocalization.Alerts.alreadtSavedBody.localized, animated: true)
        }
    }
}

extension AllListPresenter: GetLocalPokemonsUseCaseOutput {
    func loadPokemons(result: [PokemonDetailModel]) {
        self.finishLoading(with: nil)
    }
}

// MARK: - CallBack from Details Page
extension AllListPresenter: RemoteDetailOutput {
    func didInteractWithDB(didChangeState: Bool) {
        if didChangeState {
            self.beginLoading()
            self.refreshData()
        }
    }
}
