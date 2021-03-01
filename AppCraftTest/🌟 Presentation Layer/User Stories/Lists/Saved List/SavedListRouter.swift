//
//  SavedListRouter.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKViper

protocol SavedListRouterInput: ViperRouterInput {
    func showDetailPokemon(pokemon: PokemonDetailModel,  output: LocalDetailOutput)
}

class SavedListRouter: ViperRouter, SavedListRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: SavedListViewController? {
        guard let mainController = self._mainController as? SavedListViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - SavedListRouterInput
    func showDetailPokemon(pokemon: PokemonDetailModel, output: LocalDetailOutput) {
        let vc = LocalDetailAssembly.create()
        let _ = LocalDetailAssembly.configure(with: vc, pokemon: pokemon, output: output)
        self.push(to: vc, animated: true)
    }
    
    // MARK: - Module functions
}
