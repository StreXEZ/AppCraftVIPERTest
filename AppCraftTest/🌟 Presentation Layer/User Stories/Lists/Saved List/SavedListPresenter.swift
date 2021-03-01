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
    
    // MARK: - Initialization
    override init() {
        self.viewModel = SavedListViewModel()
        self.localUseCase = PokemonDetailsUseCase()
        super.init()
        self.localUseCase.subscribe(with: self)
    }
    
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.localUseCase.fetchSavedPokemons()
    }
    
    func createRows() -> [TableCellModel] {
        var rows: [TableCellModel] = []
        
        if viewModel.pokemons?.count == 0 {
            rows.append(EmptyListCellModel(title: "Вы пока не добавили покемонов в этот список"))
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
        self.localUseCase.fetchSavedPokemons()
    }
    
    func showDetails(by name: String) {
        guard let pokeToShow = viewModel.pokemons?.first(where: { (poke) -> Bool in
            poke.name == name
        }) else { return }
        self.router?.showDetailPokemon(pokemon: pokeToShow)
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

// MARK: - PokemonDetailsUseCaseOutput
extension SavedListPresenter: PokemonDetailsUseCaseOutput {
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
