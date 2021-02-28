//
//  NoConnectionView.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import UIKit

class NoConnectionView: UIView {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        self.loadFromNibIfEmbeddedInDifferentNib()
    }
    
    
    func setupComponents(title: String, buttonText: String) {
//        refreshButton.backgroundColor = .systemBlue
//        refreshButton.layer.cornerRadius = 5
        textLabel.text = title
        refreshButton.setTitle(buttonText, for: .normal)
    }
}
