//
//  PokemonCellModel.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//

import UIKit
import GKRepresentable

class PokemonTableCellModel: TableCellModel {
    override var cellIdentifier: String {
        return PokemonTableCell.identifier
    }
    var name: String?
    var url: String?
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
