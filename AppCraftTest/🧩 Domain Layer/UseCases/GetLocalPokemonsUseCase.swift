//
//  GetLocalPokemonsUseCase.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import GKUseCase

protocol GetLocalPokemonsUseCaseInput: UseCaseInput {
    func fetchSavedPokemons()
}

protocol GetLocalPokemonsUseCaseOutput: UseCaseOutput {
    func error(error: Error)
    func loadPokemons(result: [PokemonDetailModel])
}

class GetLocalPokemonsUseCase: UseCase, GetLocalPokemonsUseCaseInput {
    private var output: GetLocalPokemonsUseCaseOutput? {
        guard let output = self._output as? GetLocalPokemonsUseCaseOutput else {
            return nil
        }
        return output
    }
    
    private lazy var localRepository: PokemonsLocalRepositoryInterface = PokemonsLocalRepository()
    
    // MARK: - Initialization
    override public init() {
        super.init()
    }
    
    func fetchSavedPokemons() {
        self.localRepository.fetchSavedPokemons { (result) in
            switch result {
            case .success(let pokemons):
                self.output?.loadPokemons(result: pokemons)
            case .failure(let err):
                self.output?.error(error: err)
            }
        }
    }
}
