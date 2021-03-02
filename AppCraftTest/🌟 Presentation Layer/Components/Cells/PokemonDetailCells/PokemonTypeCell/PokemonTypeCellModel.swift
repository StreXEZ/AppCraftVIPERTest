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
    
    var isDefault: Bool
    
    init(isDefault: Bool) {
        self.isDefault = isDefault
    }
}
