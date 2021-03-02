//
//  PokemonTypeCell.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import GKRepresentable

class PokemonTypeCell: TableCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    
    override func setupView() {
        self.titleLabel.apply(.header2TitleStyle())
        self.titleLabel.text = AppLocalization.PokemonDetails.typeLabel.localized
    }
    
    override func updateViews() {
        guard let model = model as? PokemonTypeCellModel else { return }
        self.typeLabel.text = model.isDefault ? AppLocalization.PokemonDetails.def.localized : AppLocalization.PokemonDetails.nondef.localized
    }
}
