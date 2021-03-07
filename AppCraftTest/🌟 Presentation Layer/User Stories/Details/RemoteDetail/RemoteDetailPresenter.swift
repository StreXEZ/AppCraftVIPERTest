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

protocol RemoteDetailOutput {
    func didInteractWithDB(didChangeState: Bool)
}

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
    
    private let output: RemoteDetailOutput
    private let viewModel: RemoteDetailViewModel
    private let remoteUseCase: GetSinglePokemonUseCaseInput
    private let localUseCase: PokemonDetailsUseCaseInput
    
    // MARK: - Initialization
    init(url: String, state: Bool, output: RemoteDetailOutput) {
        self.viewModel = RemoteDetailViewModel(url: url, initialState: state)
        self.remoteUseCase = GetSinglePokemonUseCase()
        self.localUseCase = PokemonDetailsUseCase()
        
        self.output = output
        
        super.init()
        self.beginLoading()
        
        self.remoteUseCase.subscribe(with: self)
        self.localUseCase.subscribe(with: self)
    }
    
    deinit {
        self.output.didInteractWithDB(didChangeState: viewModel.initialSavedState != viewModel.saved)
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
        self.finishLoading(with: nil)
    }
    
    
    func makeSection() {
        let mainSection = TableSectionModel()
        mainSection.rows.append(PokemonNameCellModel(name: viewModel.pokemon?.name ?? ""))
        mainSection.rows.append(PokemonTypeCellModel(isDefault: viewModel.pokemon?.isDefault ?? false))
        mainSection.rows.append(BaseExperienceCellModel(baseExp: viewModel.pokemon?.baseExperience ?? 0))
        mainSection.rows.append(WeightHeightCellModel(height: viewModel.pokemon?.height ?? 0, weight: viewModel.pokemon?.weight ?? 0))
        self.view?.updateSections(with: [mainSection])
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
        self.localUseCase.checkPokemon(pokemon: result.name)
        self.makeSection()
    }
}

extension RemoteDetailPresenter: RemoteDetailViewOutput {
    func interactWithLocalDB() {
        guard let saved = viewModel.saved, let pokemon = viewModel.pokemon else { return }
        if saved {
            self.view?.show(CustomAlerts.deleteAlert { [weak self] in
                self?.localUseCase.deletePokemon(pokemon: pokemon.name)
            }, animated: true)
        } else {
            self.localUseCase.savePokemon(pokemon: pokemon)
        }
    }
}

// MARK: - PokemonDetailsUseCaseOutput
extension RemoteDetailPresenter: PokemonDetailsUseCaseOutput {
    func provideDelete(for name: String) {
        guard let pokemon = self.viewModel.pokemon else { return }
        self.localUseCase.checkPokemon(pokemon: pokemon.name)
    }
    
    func provideSave(for name: String) {
        guard let pokemon = self.viewModel.pokemon else { return }
        self.localUseCase.checkPokemon(pokemon: pokemon.name)
    }
    
    func error(error: Error) {
        print(error)
    }
    
    func pokemonExistance(doesExist: Bool) {
        self.viewModel.saved = doesExist
        self.view?.localPokemonState(isPokeSaved: doesExist)
    }
}
