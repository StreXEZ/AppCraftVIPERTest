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
    
    private var model: NoConnectionViewModel?
    
    public func setup(model: NoConnectionViewModel) {
        self.model = model
        setupComponents()
    }

    func setupComponents() {
        textLabel.text = AppLocalization.InfoMessages.noConnection.localized
        refreshButton.setTitle(AppLocalization.General.refresh.localized, for: .normal)
        refreshButton.apply(.refreshButton())
        refreshButton.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
    }
    
    deinit {
        print("DINITED")
    }
    
    @objc
    private func tapButton(_ button: UIButton) {
        model?.didAction(self, .tapRefresh)
    }
}
