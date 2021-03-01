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
        print("SETUPING")
    }
    
    override func updateViews() {
        guard let model = self.model as? EmptyListCellModel else { return }
        self.messageLabel.text = model.title
        print("UPDATING")
    }
}
