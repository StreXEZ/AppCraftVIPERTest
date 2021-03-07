//
//  GetPokemonsUseCase.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import GKUseCase

protocol GetPokemonsUseCaseInput: UseCaseInput {
    func getPokemons(limit: Int)
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
    private let localPokemonsRepository: PokemonsLocalRepositoryInterface
    
    override init() {
        self.pokemonListRepository = PokemonRemoteRepository()
        self.localPokemonsRepository = PokemonsLocalRepository()
    }
    
    func getPokemons(limit: Int) {
        var pokemonsResult: [PokemonShortModel] = []
        pokemonListRepository.getPokemons(limit: limit) { (result) in
            switch result {
            case .success(let pokemons):
                self.localPokemonsRepository.fetchSavedPokemons { result in
                    switch result {
                    case .success(let pokes):
                        pokemons.result.forEach { pokemon in
                            if pokes.contains(where: { model -> Bool in
                                model.name == pokemon.name
                            }) {
                                pokemonsResult.append(PokemonShortModel(name: pokemon.name, url: pokemon.url, isSaved: true))
                            } else {
                                pokemonsResult.append(pokemon)
                            }
                        }
                        self.output?.loadList(useCase: self, result: PokemonsListModel(result: pokemonsResult))
                        break
                    case .failure(let err):
                        break
                    }
                }
            case .failure(let err):
                self.output?.error(useCase: self, error: err)
            }
        }
    }
}
