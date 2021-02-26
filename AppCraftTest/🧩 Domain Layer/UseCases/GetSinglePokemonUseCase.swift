//
//  GetSinglePokemonUseCase.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//

import Foundation
import GKUseCase

protocol GetSinglePokemonUseCaseInput: UseCaseInput {
    func get(url: String, viewModel: RemoteDetailViewModel)
}

protocol GetSinglePokemonUseCaseOutput: UseCaseOutput {
    func error(useCase: GetSinglePokemonUseCase, error: Error)
    func loadPokemon(useCase: GetSinglePokemonUseCase, result: PokemonDetailModel)
}

class GetSinglePokemonUseCase: UseCase, GetSinglePokemonUseCaseInput {
    
    var output: GetSinglePokemonUseCaseOutput? {
        guard let output = self._output as? GetSinglePokemonUseCaseOutput else { return nil }
        return output
    }
    
    private let pokemonListRepository: PokemonRemoteRepositoryInterface
    
    override init() {
        self.pokemonListRepository = PokemonRemoteRepository()
    }
    
    func get(url: String, viewModel: RemoteDetailViewModel) {
        pokemonListRepository.getSinglePokemon(url: url) {(result) in
            switch result {
            case .success(let pokemon):
                viewModel.pokemon = pokemon
                self.output?.loadPokemon(useCase: self, result: pokemon)
            case .failure(let err):
                print("ERROR")
                self.output?.error(useCase: self, error: err)
            }
        }
    }
}
