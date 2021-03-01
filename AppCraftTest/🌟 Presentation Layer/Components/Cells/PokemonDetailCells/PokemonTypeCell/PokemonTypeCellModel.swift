//
//  PokemonTypeCellModel.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import GKRepresentable

class PokemonTypeCellModel: TableCellModel {
    override var cellIdentifier: String {
        return PokemonTypeCell.identifier
    }
    
    var type: String
    
    init(isDefault: Bool) {
        self.type = isDefault ? "Default" : "Non-Default"
    }
}
