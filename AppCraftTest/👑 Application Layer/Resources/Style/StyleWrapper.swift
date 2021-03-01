//
//  StyleWrapper.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import UIKit

typealias Style<Element> = (Element) -> Void

enum StyleWrapper<Element> {
    case wrap(style: Style<Element>)
}

// MARK: - UIView
extension StyleWrapper where Element: UIView {
    
    static func backgroundViewStyle() -> StyleWrapper {
        return .wrap { view in
            view.backgroundColor = .red
        }
    }
    
    static func backgroundClearStyle() -> StyleWrapper {
        return .wrap { view in
            view.backgroundColor = .clear
        }
    }
    static func heightWeightViewStyle() -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = 10
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    static func pokemonCellStyle() -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = 10
            view.backgroundColor = UIColor(hex: "F0F0F0")
        }
    }
    
    static func customInfoCellStyle() -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = 15
            view.backgroundColor = UIColor(hex: "E8E8E8")
        }
    }
}

// MARK: - UIImageView
extension StyleWrapper where Element: UIImageView {
    
    static func generalFitStyle() -> StyleWrapper {
        return .wrap { imageView in
            imageView.contentMode = .scaleAspectFit
            imageView.layer.masksToBounds = true
        }
    }
    
    static func generalFillStyle() -> StyleWrapper {
        return .wrap { imageView in
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
        }
    }
    
}

// MARK: - UILabel
extension StyleWrapper where Element: UILabel {
    static func headerTitleStyle() -> StyleWrapper {
        return .wrap { label in
            label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            label.numberOfLines = 0
        }
    }
    
    static func header2TitleStyle() -> StyleWrapper {
        return .wrap { label in
            label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            label.numberOfLines = 0
        }
    }
}

// MARK: - UITabBar
extension StyleWrapper where Element: UITabBar {
    static var tabBarDefault: StyleWrapper {
        return .wrap { tabBar in
            tabBar.isTranslucent = false
//            tabBar.barTintColor = .white
//            tabBar.unselectedItemTintColor = .white
            tabBar.tintColor = .black
//            tabBar.backgroundImage = UIImage()
//            tabBar.shadowImage = UIImage()
        }
    }
}
