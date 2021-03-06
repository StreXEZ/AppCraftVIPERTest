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
            view.layer.borderColor = AppTheme.accentBorderViewColor.cgColor
        }
    }
    
    static func pokemonCellStyle() -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = 10
            view.backgroundColor = AppTheme.defaultCellColor
        }
    }
    
    static func customInfoCellStyle() -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = 15
            view.backgroundColor = AppTheme.infoCellColor
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
    
    static func thinMessageStyle() -> StyleWrapper {
        return .wrap { label in
            label.numberOfLines = 0
            label.textColor = .darkGray
            label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        }
    }
}

// MARK: - UITabBar
extension StyleWrapper where Element: UITabBar {
    static var tabBarDefault: StyleWrapper {
        return .wrap { tabBar in
            tabBar.isTranslucent = false
            tabBar.tintColor = .black
        }
    }
}

// MARK: - Button
extension StyleWrapper where Element: UIButton {
    static func refreshButton() -> StyleWrapper {
        return .wrap { button in
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 15
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        }
    }
}
