//
//  SinglePokemonRouter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//

import Foundation
import GKNetwork
import GKCoreData
import CoreData

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
    
    enum Local {
        case getSaved
        case pokemon(name: String)
        
        var entityClass: AnyClass {
            return PokemonEntity.self
        }
        
        var request: NSFetchRequest<NSManagedObject> {
            switch  self {
            case .getSaved:
                return LocalFactory.request(self.entityClass, predicate: nil, sortDescriptors: nil)
            case let .pokemon(name):
                let predicate = NSPredicate(format: "name=%@", "\(name)")
                return LocalFactory.request(self.entityClass, predicate: predicate, sortDescriptors: nil)
            }
        }
    }
}
