//
//  EmptyListCellModel.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import GKRepresentable

class EmptyListCellModel: TableCellModel {
    
    override var cellIdentifier: String {
        return EmptyListCell.identifier
    }
    
    var title: String
    init(title: String) {
        self.title = title
    }
}
