//
//  EmptyListCell.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import GKRepresentable

class EmptyListCell: TableCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var contentVw: UIView!
    
    override func setupView() {
        self.contentVw.apply(.customInfoCellStyle())
        
        
        self.messageLabel.numberOfLines = 0
        self.messageLabel.textColor = .darkGray
    }
    
    override func updateViews() {
        self.messageLabel.text = AppLocalization.InfoMessages.emptyList.localized
    }
}
