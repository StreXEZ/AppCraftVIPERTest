//
//  LocalDetailPresenter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper
import GKRepresentable

protocol LocalDetailPresenterInput: ViperPresenterInput { }

protocol LocalDetailOutput {
    func didDeletePoke()
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
    
    private let output: LocalDetailOutput
    private var viewModel: LocalDetailViewModel
    private let localUseCase: PokemonDetailsUseCaseInput
    
    // MARK: - Initialization
    init(pokemon: PokemonDetailModel, output: LocalDetailOutput) {
        self.viewModel = LocalDetailViewModel(pokemon: pokemon)
        self.localUseCase = PokemonDetailsUseCase()
        self.output = output
        super.init()
        self.localUseCase.subscribe(with: self)
    }
    
    // MARK: - LocalDetailPresenterInput
    
    // MARK: - LocalDetailViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        self.makeSection()
    }
    
    func makeSection() {
        let mainSection = TableSectionModel()
        mainSection.rows.append(PokemonNameCellModel(name: viewModel.pokemon.name))
        mainSection.rows.append(PokemonTypeCellModel(isDefault: viewModel.pokemon.isDefault))
        mainSection.rows.append(BaseExperienceCellModel(baseExp: viewModel.pokemon.baseExperience))
        mainSection.rows.append(WeightHeightCellModel(height: viewModel.pokemon.height, weight: viewModel.pokemon.weight))
        self.view?.updateSections(with: [mainSection])
    }
        
    // MARK: - Module functions
}

extension LocalDetailPresenter {
    func deletePokemon() {
        self.view?.show(CustomAlerts.deleteAlert { [weak self] in
            guard let self = self else { return }
            self.localUseCase.deletePokemon(pokemon: self.viewModel.pokemon)
        }, animated: true)
    }
}

extension LocalDetailPresenter: PokemonDetailsUseCaseOutput {
    
    func provideDelete() {
        self.router?.goBack(animated: true)
        self.output.didDeletePoke()
    }
    
    func error(error: Error) {
        print(error)
    }
    
    func provideSave() { }
    
    func pokemonExistance(doesExist: Bool) { }
    

}
