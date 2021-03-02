//
//  EmptyListCell.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import GKRepresentable

class EmptyListCell: TableCell {
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var contentVw: UIView!
    
    override func setupView() {
        self.contentVw.apply(.customInfoCellStyle())
        self.messageLabel.apply(.thinMessageStyle())
    }
    
    override func updateViews() {
        self.messageLabel.text = AppLocalization.InfoMessages.emptyList.localized
    }
}
