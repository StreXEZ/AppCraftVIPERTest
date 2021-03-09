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
    @IBOutlet private weak var favouriteButton: UIButton!
    
    override func setupView() {
        self.contentVw.apply(.pokemonCellStyle())
        self.favouriteButton.setTitle("", for: .normal)
        self.favouriteButton.tintColor = AppTheme.mainAssetColor
        self.setupActions()
    }
    
    override func updateViews() {
        guard let model = self.model as? PokemonTableCellModel else { return }
        self.nameLabel.text = model.name
        self.favouriteButton.setImage(model.isSaved ? AppAssets.favourite : AppAssets.notFavourite, for: .normal)
    }
    
    func setupActions() {
        self.favouriteButton.addTarget(self, action: #selector(self.favouriteButtonTapped), for: .touchUpInside)
        
    }
    
    @objc
    private func favouriteButtonTapped() {
        guard let model = self.model as? PokemonTableCellModel else { return }
        model.actionCallback?()
        self.updateViews()
    }
}
