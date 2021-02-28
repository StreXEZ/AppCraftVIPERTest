//
//  WeightHeightCellModel.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import Foundation
import GKRepresentable

class WeightHeightCellModel: TableCellModel {
    override var cellIdentifier: String {
        return WeightHeightCell.identifier
    }
    var height: Int
    var weight: Int
    
    init(height: Int, weight: Int) {
        self.height = height
        self.weight = weight
    }
}
