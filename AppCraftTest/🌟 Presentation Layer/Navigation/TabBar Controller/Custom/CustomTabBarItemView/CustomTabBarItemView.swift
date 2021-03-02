//
//  CustomTabBarItemView.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import UIKit

class CustomTabBarItemView: UIView {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!

    override func awakeAfter(using coder: NSCoder) -> Any? {
        return self.loadFromNibIfEmbeddedInDifferentNib()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func addTo(parent view: UIView?, size: CGSize = CGSize(width: 30.0, height: 30.0)) {
        guard let view = view else { return }
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.heightAnchor.constraint(equalToConstant: size.height),
            self.widthAnchor.constraint(equalToConstant: size.width)
        ])
    }
    
    public func setup(_ itemType: CustomTabBarItemPresentable) {
        self.itemType = itemType
        self.imageView.image = itemType.image
    }
    
    private var size = CGSize(width: 30.0, height: 30.0)
    private var itemType: CustomTabBarItemPresentable?
}

extension  CustomTabBarItemView: CustomTabBarPresentable {
    func didSelectItem(_ isSelected: Bool) {
        guard let type = self.itemType else { return }
        self.imageView.image = isSelected ? type.selectedImage: type.image
    }
}
