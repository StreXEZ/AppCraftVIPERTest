//
//  PokemonNameCellModel.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import GKRepresentable

class PokemonNameCellModel: TableCellModel {
    override var cellIdentifier: String {
        return PokemonNameCell.identifier
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
