//
//  PokemonTableCell.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//

import GKViper
import GKRepresentable

class PokemonTableCell: TableCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var contentVw: UIView!
    
    override func setupView() {
        self.contentVw.apply(.pokemonCellStyle())
    }
    
    override func updateViews() {
        guard let model = self.model as? PokemonTableCellModel else { return }
        self.nameLabel.text = model.name
    }
}
