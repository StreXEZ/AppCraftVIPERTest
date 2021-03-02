//
//  PokemonNameCell.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import GKRepresentable

class PokemonNameCell: TableCell {
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func setupView() {
        self.nameLabel.apply(.headerTitleStyle())
    }
    
    override func updateViews() {
        guard let model = self.model as? PokemonNameCellModel else { return }
        nameLabel.text = model.name
    }
}
