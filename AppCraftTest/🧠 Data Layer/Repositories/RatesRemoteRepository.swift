//
//  RatesRemoteRepository.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import GKUseCase
import GKNetwork

typealias PokemonRemoteListHandler = (Result<PokemonsListResponse, Error>) -> Void

protocol PokemonRemoteRepositoryInterface: RepositoryInterface {
    func getPokemons() -> 
}
