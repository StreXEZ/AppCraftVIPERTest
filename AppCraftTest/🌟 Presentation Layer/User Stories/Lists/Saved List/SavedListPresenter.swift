//
//  SavedListPresenter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper
import GKRepresentable

protocol SavedListPresenterInput: ViperPresenterInput { }

class SavedListPresenter: ViperPresenter, SavedListPresenterInput {
    
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
    private let localUseCase: PokemonDetailsUseCaseInput
    private let fetchPokesUseCase: GetLocalPokemonsUseCaseInput
    
    // MARK: - Initialization
    override init() {
        self.viewModel = SavedListViewModel()
        self.localUseCase = PokemonDetailsUseCase()
        self.fetchPokesUseCase = GetLocalPokemonsUseCase()
        super.init()
        self.localUseCase.subscribe(with: self)
        self.fetchPokesUseCase.subscribe(with: self)
    }
    
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.fetchPokesUseCase.fetchSavedPokemons()
    }
    
    func createRows() -> [TableCellModel] {
        var rows: [TableCellModel] = []
        
        if viewModel.pokemons?.count == 0 {
            rows.append(EmptyListCellModel())
            return rows
        }
        
        viewModel.pokemons?.forEach { item in
            rows.append(PokemonTableCellModel(name: item.name, url: ""))
        }
        return rows
    }
}

// MARK: - SavedListViewOutput
extension SavedListPresenter: SavedListViewOutput {
    func refreshData() {
        self.fetchPokesUseCase.fetchSavedPokemons()
    }
    
    func showDetails(by name: String) {
        guard let pokeToShow = viewModel.pokemons?.first(where: { (poke) -> Bool in
            poke.name == name
        }) else { return }
        self.router?.showDetailPokemon(pokemon: pokeToShow, output: self)
    }
    
    func deletePokemon(by name: String) {
        guard let pokeToRemove = viewModel.pokemons?.first(where: { (poke) -> Bool in
            poke.name == name
        }) else { return }
        view?.show(CustomAlerts.deleteAlert(callback: { [weak self] in
            self?.localUseCase.deletePokemon(pokemon: pokeToRemove)
        }), animated: true)
    }
}

extension SavedListPresenter: LocalDetailOutput {
    func didDeletePoke() {
        self.fetchPokesUseCase.fetchSavedPokemons()
    }
}

// MARK: - PokemonDetailsUseCaseOutput
extension SavedListPresenter: PokemonDetailsUseCaseOutput, GetLocalPokemonsUseCaseOutput {
    func loadPokemons(result: [PokemonDetailModel]) {
        viewModel.pokemons = result
            view?.reloadTable(with: createRows())
    }
    
    func provideDelete() {
        self.refreshData()
    }
    
    func provideSave() { }
    
    func pokemonExistance(doesExist: Bool) { }
    
    func error(error: Error) { }
    
}
