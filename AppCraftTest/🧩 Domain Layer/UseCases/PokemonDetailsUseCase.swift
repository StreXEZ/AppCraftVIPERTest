//
//  PokemonDetailsUseCase.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//

import Foundation
import GKUseCase

protocol PokemonDetailsUseCaseInput: UseCaseInput {
    func deletePokemon(pokemon: String)
    func savePokemon(pokemon: PokemonDetailModel)
    func checkPokemon(pokemon: String)
}

protocol PokemonDetailsUseCaseOutput: UseCaseOutput {
    func error(error: Error)
    func pokemonExistance(doesExist: Bool)
    func provideDelete(for name: String)
    func provideSave(for name: String)
}

class PokemonDetailsUseCase: UseCase, PokemonDetailsUseCaseInput {
    private var output: PokemonDetailsUseCaseOutput? {
        guard let output = self._output as? PokemonDetailsUseCaseOutput else {
            return nil
        }
        return output
    }
    
    private lazy var localRepository: PokemonsLocalRepositoryInterface = PokemonsLocalRepository()
    
    // MARK: - Initialization
    override public init() {
        super.init()
    }
    
    func deletePokemon(pokemon: String) {
        self.localRepository.deletePokemon(pokemon: pokemon) { success in
            if success {
                self.output?.provideDelete(for: pokemon)
            } else {
                self.output?.error(error: CoreDataError.dbInteractionError)
            }
        }
    }
    
    func savePokemon(pokemon: PokemonDetailModel) {
        self.localRepository.checkPokemon(pokemon: pokemon.name) { exist in
            if !exist {
                self.localRepository.savePokemon(pokemon: pokemon) { success in
                    if success {
                        self.output?.provideSave(for: pokemon.name)
                    } else {
                        self.output?.error(error: CoreDataError.dbInteractionError)
                    }
                }
                
            } else {
                self.output?.pokemonExistance(doesExist: true)
            }
        }
    }
    
    func checkPokemon(pokemon: String) {
        self.localRepository.checkPokemon(pokemon: pokemon) { exist in
            self.output?.pokemonExistance(doesExist: exist)
        }
    }
}
