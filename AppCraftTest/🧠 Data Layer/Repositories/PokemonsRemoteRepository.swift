//
//  RatesRemoteRepository.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import GKUseCase
import GKNetwork
import Reachability

typealias PokemonRemoteListHandler = (Result<PokemonsListModel, Error>) -> Void
typealias SinglePokemonHandler = (Result<PokemonDetailModel, Error>) -> Void

protocol PokemonRemoteRepositoryInterface: RepositoryInterface {
    func getPokemons(completion: @escaping PokemonRemoteListHandler)
    func getSinglePokemon(url: String ,completion: @escaping SinglePokemonHandler)
}

class PokemonRemoteRepository: AppCraftTestRepository, PokemonRemoteRepositoryInterface {
    func getPokemons(completion: @escaping PokemonRemoteListHandler) {
        guard (try? Reachability().connection != Reachability.Connection.unavailable) ?? false else {
            completion(.failure(APIError.noConnection))
            return
        }
        guard let request = PokemonListRouter.Remote.getPokemons.request else {
            completion(.failure(APIError.cannotCreateRequest))
            return
        }
        self.execute(request, response: PokemonsListResponse.self) { (result, _, error) in
            if let mappedResult = result as? PokemonsListModel, error == nil {
                completion(.success(mappedResult))
            } else {
                completion(.failure(APIError.cannotConvertData))
            }
        }
    }
    
    func getSinglePokemon(url: String, completion: @escaping SinglePokemonHandler) {
        guard (try? Reachability().connection != Reachability.Connection.unavailable) ?? false else {
            completion(.failure(APIError.noConnection))
            return
        }
        guard let request = SinglePokemonRouter.Remote.getPokemon(url: url).request else {
            completion(.failure(APIError.cannotCreateRequest))
            return
        }
        self.execute(request, response: PokemonDetailResponse.self) { (result, _, error) in
            if let mappedResult = result as? PokemonDetailModel, error == nil {
                completion(.success(mappedResult))
            } else {
                completion(.failure(APIError.cannotConvertData))
            }
        }
    }
}
