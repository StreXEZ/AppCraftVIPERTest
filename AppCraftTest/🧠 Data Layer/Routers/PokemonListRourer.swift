//
//  PokemonListResponse.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import GKNetwork

enum PokemonListRouter {
    enum Remote {
        case getPokemons
        
        var method: HTTPMethod {
            switch self {
            case .getPokemons:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .getPokemons:
                return "\(AppConfiguration.serverApi)/pokemon?limit=100"
            }
        }
        
        var request: URLRequest? {
            switch self {
            case .getPokemons:
                
                return RemoteFactory.request(path: self.path, parameters: nil, headers: nil, method: self.method)
            }
        }
    }
}
