//
//  NoConnectionView.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import UIKit

class NoConnectionView: UIView {
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var refreshButton: UIButton!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        self.loadFromNibIfEmbeddedInDifferentNib()
    }
    
    private var model: NoConnectionViewModel?
    
    public func setup(model: NoConnectionViewModel) {
        self.model = model
        self.setupComponents()
    }

    func setupComponents() {
        self.textLabel.text = AppLocalization.InfoMessages.noConnection.localized
        self.refreshButton.setTitle(AppLocalization.General.refresh.localized, for: .normal)
        self.refreshButton.apply(.refreshButton())
        self.textLabel.apply(.header2TitleStyle())
        self.refreshButton.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
    }
    
    deinit {
        print("DINITED")
    }
    
    @objc
    private func tapButton(_ button: UIButton) {
        self.model?.didAction(self, .tapRefresh)
    }
}
