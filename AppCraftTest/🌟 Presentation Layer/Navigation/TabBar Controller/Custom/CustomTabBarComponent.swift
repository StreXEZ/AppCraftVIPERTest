//
//  CustomTabBarComponent.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import UIKit
import ESTabBarController_swift

class CustomTabBarComponent {
    static func createList(selectedItem: CustomTabBarItem) -> [CustomTabBarComponent] {
        let items = CustomTabBarItem.allCases.sorted(by: { $0.rawValue < $1.rawValue })
        return items.map({ CustomTabBarComponent(type: $0, selected: items.firstIndex(of: selectedItem) ?? 0) })
    }
    
    public let navigationController: UINavigationController
    public let type: CustomTabBarItem
    
    public var tag: Int {
        self.type.rawValue
    }
    
    private let itemView: ESTabBarItemContentView
    private let contentItemView: CustomTabBarPresentable
    private let tabbarItem: UITabBarItem
    
    init(type: CustomTabBarItem, selected: Int) {
        self.type = type
        
        let itemView = ESTabBarItemContentView()
        let contentView = CustomTabBarItemView.loadNib()
        contentView.setup(type)
        contentView.addTo(parent: itemView)
        self.contentItemView = contentView
        self.itemView = itemView
        
        self.tabbarItem = ESTabBarItem(self.itemView, tag: type.rawValue)
        
        let rootViewController: UIViewController
        switch type {
        case .all:
            let vc = AllListAssembly.create()
            _ = AllListAssembly.configure(with: vc)
            rootViewController = vc
        case .saved:
            let vc = SavedListAssembly.create()
            _ = SavedListAssembly.configure(with: vc)
            rootViewController = vc
        }
        
        self.navigationController = BasicNavigationController(rootViewController: rootViewController)
        self.navigationController.tabBarItem = self.tabbarItem
        
        self.didSelectItem(self.tag == selected)
    }
}

// MARK: - CustomTabBarPresentable
extension CustomTabBarComponent: CustomTabBarPresentable {
    
    func didSelectItem(_ isSelected: Bool) {
        self.contentItemView.didSelectItem(isSelected)
    }
    
}
