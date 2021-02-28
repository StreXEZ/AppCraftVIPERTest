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

class SavedListPresenter: ViperPresenter, SavedListPresenterInput, SavedListViewOutput {
    
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
    
    // MARK: - SavedListPresenterInput
    
    // MARK: - SavedListViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.localUseCase.fetchSavedPokemons()
    }
        
    // MARK: - Module functions
}
extension SavedListPresenter {
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
        view?.show(deleteAlert(callback: { [weak self] in
            self?.localUseCase.deletePokemon(pokemon: pokeToRemove)
        }), animated: true)
    }
    
    private func deleteAlert(callback: @escaping () -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: "Вы уверены?", message: "Если вы удалите покемона, то его данные сотрутся с вашего устройства", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { action in
            callback()
        }
        let dismissAction = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(deleteAction)
        alertController.addAction(dismissAction)
        return alertController
    }
}

extension SavedListPresenter: PokemonDetailsUseCaseOutput {
    func loadPokemons(result: [PokemonDetailModel]) {
        viewModel.pokemons = result
        view?.reloadTable(with: createRows())
    }
    
    func createRows() -> [TableCellModel] {
        var rows: [TableCellModel] = []
        viewModel.pokemons?.forEach { item in
            rows.append(PokemonTableCellModel(name: item.name, url: ""))
        }
        print(rows.count)
        return rows
    }
    
    func provideDelete() {
        self.refreshData()
    }
    
    func provideSave() { }
    
    func pokemonExistance(doesExist: Bool) { }
    
    func error(error: Error) { }
    
}
