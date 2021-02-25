//
//  GetPokemonsUseCase.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import GKUseCase

protocol GetPokemonsUseCaseInput: UseCaseInput {
    func get(viewModel: AllListViewModel)
}

protocol GetPokemonsUseCaseOutput: UseCaseOutput {
    func error(useCase: GetPokemonsUseCase, error: Error)
    func loadList(useCase: GetPokemonsUseCase, result: PokemonsListModel)
}

class GetPokemonsUseCase: UseCase, GetPokemonsUseCaseInput {
    var output: GetPokemonsUseCaseOutput? {
        guard let output = self._output as? GetPokemonsUseCaseOutput else { return nil }
        return output
    }
    
    private let pokemonListRepository: PokemonRemoteRepositoryInterface
    
    override init() {
        self.pokemonListRepository = PokemonRemoteRepository()
    }
    
    func get(viewModel: AllListViewModel) {
        pokemonListRepository.getPokemons { (result) in
            switch result {
            case .success(let pokemons):
                self.output?.loadList(useCase: self, result: pokemons)
            case .failure(let err):
                self.output?.error(useCase: self, error: err)
            }
        }
    }
}
