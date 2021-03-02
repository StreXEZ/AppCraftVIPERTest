//
//  WeightHeightCell.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import UIKit
import GKRepresentable

class WeightHeightCell: TableCell {
    @IBOutlet private weak var heightContainer: UIView!
    @IBOutlet private weak var weightContainer: UIView!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        return
    }
    
    override func setupView() {
        self.heightContainer.apply(.heightWeightViewStyle())
        self.weightContainer.apply(.heightWeightViewStyle())
    }
    
    override func updateViews() {
        guard let model = self.model as? WeightHeightCellModel else { return }
        self.heightLabel.text = AppLocalization.PokemonDetails.height.localized + String(model.height)
        self.weightLabel.text = AppLocalization.PokemonDetails.weight.localized + String(model.weight)
    }

}
