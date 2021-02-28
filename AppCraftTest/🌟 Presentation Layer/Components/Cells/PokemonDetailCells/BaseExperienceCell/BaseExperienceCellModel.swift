//
//  BaseExperienceCellModel.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import GKRepresentable

class BaseExperienceCellModel: TableCellModel {
    override var cellIdentifier: String {
        return BaseExperienceCell.identifier
    }
    
    var baseExp: Int
    
    init(baseExp: Int) {
        self.baseExp = baseExp
    }
}
