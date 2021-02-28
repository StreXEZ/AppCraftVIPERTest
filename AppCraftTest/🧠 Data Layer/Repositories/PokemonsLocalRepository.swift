//
//  RatesListRepository.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import GKUseCase
import GKNetwork

typealias SavedPokemonsHandler = (Result<[PokemonDetailModel], Error>) -> Void

protocol PokemonsLocalRepositoryInterface: RepositoryInterface {
    func fetchSavedPokemons(completion: @escaping SavedPokemonsHandler)
    func savePokemon(pokemon: PokemonDetailModel, completion: ((Bool) -> Void)?)
    func deletePokemon(pokemon: PokemonDetailModel, completion: ((Bool) -> Void)?)
    func checkPokemon(pokemon: PokemonDetailModel, completion: ((Bool) ->Void)?)
}

class PokemonsLocalRepository: AppCraftTestRepository, PokemonsLocalRepositoryInterface {
    override var entityClass: AnyClass {
        return PokemonEntity.self
    }
    
    func fetchSavedPokemons(completion: @escaping SavedPokemonsHandler) {
        let request = SinglePokemonRouter.Local.getSaved.request
        self.select(request) { (result, err) in
            if let pokemons = result as? [PokemonDetailModel], err == nil {
                completion(.success(pokemons))
            } else {
                completion(.success([]))
            }
        }
        
    }
    
    func savePokemon(pokemon: PokemonDetailModel, completion: ((Bool) -> Void)?) {
        checkPokemon(pokemon: pokemon) { exist in
            if exist {
                completion?(false)
            } else {
                self.update(pokemon) { (result, _) in
                    if result != nil {
                        completion?(true)
                    } else {
                        completion?(false)
                    }
                }
            }
        }
    }
    
    func deletePokemon(pokemon: PokemonDetailModel, completion: ((Bool) -> Void)?) {
        let request = SinglePokemonRouter.Local.pokemon(id: pokemon.id).request
        self.delete(request) { (success, _) in
            if success {
                completion?(true)
            } else {
                completion?(false)
            }
        }
    }
    
    func checkPokemon(pokemon: PokemonDetailModel, completion: ((Bool) ->Void)?) {
        let request = SinglePokemonRouter.Local.pokemon(id: pokemon.id).request
        self.select(request) { (result, err) in
            if result?.count == 0 {
                completion?(false)
            } else {
                completion?(true)
            }
        }
    }
}
