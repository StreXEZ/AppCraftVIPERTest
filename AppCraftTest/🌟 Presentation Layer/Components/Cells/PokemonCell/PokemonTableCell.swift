//
//  PokemonTableCell.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 26.02.2021.
//

import GKViper
import GKRepresentable

class PokemonTableCell: TableCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func setupView() {
        
    }
    
    override func updateViews() {
        guard let model = self.model as? PokemonTableCellModel else { return }
        self.nameLabel.text = model.name
    }
}
