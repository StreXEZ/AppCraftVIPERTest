//
//  PokemonDetailsUseCase.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//

import Foundation
import GKUseCase

protocol PokemonDetailsUseCaseInput: UseCaseInput {
    func deletePokemon(pokemon: PokemonDetailModel)
    func savePokemon(pokemon: PokemonDetailModel)
    func checkPokemon(pokemon: PokemonDetailModel)
}

protocol PokemonDetailsUseCaseOutput: UseCaseOutput {
    func error(error: Error)
    func pokemonExistance(doesExist: Bool)
    func provideDelete()
    func provideSave()
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
    
    func deletePokemon(pokemon: PokemonDetailModel) {
        self.localRepository.deletePokemon(pokemon: pokemon) { success in
            if success {
                self.output?.provideDelete()
            } else {
                self.output?.error(error: CoreDataError.dbInteractionError)
            }
        }
    }
    
    func savePokemon(pokemon: PokemonDetailModel) {
        self.localRepository.checkPokemon(pokemon: pokemon) { exist in
            if !exist {
                
                self.localRepository.savePokemon(pokemon: pokemon) { success in
                    if success {
                        self.output?.provideSave()
                    } else {
                        self.output?.error(error: CoreDataError.dbInteractionError)
                    }
                }
                
            } else {
                self.output?.pokemonExistance(doesExist: true)
            }
        }
    }
    
    func checkPokemon(pokemon: PokemonDetailModel) {
        self.localRepository.checkPokemon(pokemon: pokemon) { exist in
            self.output?.pokemonExistance(doesExist: exist)
        }
    }
}
