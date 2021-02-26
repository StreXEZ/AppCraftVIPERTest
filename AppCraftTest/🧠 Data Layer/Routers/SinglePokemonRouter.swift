//
//  SinglePokemonRouter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//

import Foundation
import GKNetwork

enum SinglePokemonRouter {
    enum Remote {
        case getPokemon(url: String)
        
        var method: HTTPMethod {
            switch self {
            case .getPokemon:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case let .getPokemon(url):
                return url
            }
        }
        
        var request: URLRequest? {
            switch self {
            case .getPokemon:
                
                return RemoteFactory.request(path: self.path, parameters: nil, headers: nil, method: self.method)
            }
        }
    }
}
