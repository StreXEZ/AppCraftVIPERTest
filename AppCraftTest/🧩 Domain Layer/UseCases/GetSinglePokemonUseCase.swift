//
//  GetSinglePokemonUseCase.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//

import Foundation
import GKUseCase

protocol GetSinglePokemonUseCaseInput: UseCaseInput {
    func get(url: String)
}

protocol GetSinglePokemonUseCaseOutput: UseCaseOutput {
    func error(error: Error)
    func loadPokemon(result: PokemonDetailModel)
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
    
    func get(url: String) {
        pokemonListRepository.getSinglePokemon(url: url) {(result) in
            switch result {
            case .success(let pokemon):
                self.output?.loadPokemon(result: pokemon)
            case .failure(let err):
                self.output?.error(error: err)
            }
        }
    }
}
