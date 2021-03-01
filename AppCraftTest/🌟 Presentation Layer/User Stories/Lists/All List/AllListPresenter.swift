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
    private lazy var localUseCase: PokemonDetailsUseCaseInput = PokemonDetailsUseCase()
    private lazy var singlePokemonUseCase: GetSinglePokemonUseCaseInput = GetSinglePokemonUseCase()
    private let viewModel: AllListViewModel
    
    // MARK: - Initialization
    override init() {
        self.viewModel = AllListViewModel()
        self.useCase = GetPokemonsUseCase()
        super.init()
        self.useCase.subscribe(with: self)
        self.localUseCase.subscribe(with: self)
        singlePokemonUseCase.subscribe(with: self)
    }
    
    // MARK: - AllListViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.useCase.get(viewModel: self.viewModel)
    }
    
    func refreshData() {
        useCase.get(viewModel: self.viewModel)
    }
    
    func showDetails(for url: String) {
        router?.showDetailPokemon(url: url)
    }
    
    func savePokemon(from url: String) {
        self.singlePokemonUseCase.get(url: url)
    }
    
    func createRows() -> [TableCellModel] {
        var rows: [TableCellModel] = []
        self.viewModel.pokemons?.result.forEach { item in
            rows.append(PokemonTableCellModel(name: item.name, url: item.url))
        }
        return rows
    }
}

extension AllListPresenter: GetPokemonsUseCaseOutput {
    func error(useCase: GetPokemonsUseCase, error: Error) {
        print(error.localizedDescription)
    }
    
    func loadList(useCase: GetPokemonsUseCase, result: PokemonsListModel) {
        view?.reloadTable(with: createRows())
    }
}

extension AllListPresenter: GetSinglePokemonUseCaseOutput {
    func error(error: Error) {
        print(error)
    }
    
    func loadPokemon(result: PokemonDetailModel) {
        self.localUseCase.savePokemon(pokemon: result)
    }
}

extension AllListPresenter: PokemonDetailsUseCaseOutput {
    func pokemonExistance(doesExist: Bool) {
        if doesExist {
            view?.show(title: AppLocalization.Alerts.alreadySavedTitle.localized, message: AppLocalization.Alerts.alreadtSavedBody.localized, animated: true)
        }
    }

    func provideSave() {
        print("Saved")
    }
    
    func loadPokemons(result: [PokemonDetailModel]) { }
    
    func provideDelete() { }
}
