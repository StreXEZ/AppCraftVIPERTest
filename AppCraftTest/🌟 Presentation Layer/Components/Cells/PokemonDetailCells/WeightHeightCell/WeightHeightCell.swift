//
//  WeightHeightCell.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import UIKit
import GKRepresentable

class WeightHeightCell: TableCell {
    @IBOutlet weak var heightContainer: UIView!
    @IBOutlet weak var weightContainer: UIView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        return
    }
    
    override func setupView() {
        self.heightContainer.apply(.heightWeightViewStyle())
        self.weightContainer.apply(.heightWeightViewStyle())
    }
    
    override func updateViews() {
        guard let model = self.model as? WeightHeightCellModel else { return }
        self.heightLabel.text = "Height: \(model.height)"
        self.weightLabel.text = "Weight: \(model.weight)"
    }

}
