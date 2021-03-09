//
//  AppTheme.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import GKExtensions

enum AppTheme {
    
    // MARK: - Status bar style
    public static var statusBarStyle: UIStatusBarStyle {
        switch AppThemeManager.current.type {
        case .light:
            return .default
        case .dark:
            return .lightContent
        }
    }
    
    // MARK: - Window background color
    /// Light: #F0F0F0, Dark: #383838
    public static var backgroundMain: UIColor {
        switch AppThemeManager.current.type {
        case .light:
            return UIColor(hex: "F0F0F0", alpha: 1.0)
        case .dark:
            return UIColor(hex: "383838", alpha: 1.0)
        }
    }

    // MARK: - Text colors
    /// Light: #000000, Dark: #FFFFFF
    public static var textMain: UIColor {
        switch AppThemeManager.current.type {
        case .light:
            return UIColor(hex: "000000", alpha: 1.0)
        case .dark:
            return UIColor(hex: "FFFFFF", alpha: 1.0)
        }
    }
    
    // MARK: - Components colors
    /// Dark Grey
    public static var accentBorderViewColor: UIColor {
        switch AppThemeManager.current.type {
        default:
                return UIColor.darkGray
        }
    }
    
    public static var mainAssetColor: UIColor {
        return UIColor.black
    }
    
    public static var clearColor: UIColor {
        return UIColor.clear
    }
    
    public static var lightGrayColor: UIColor {
        return UIColor.lightGray
    }
    
    public static var greenStatisticsColor: UIColor {
        return UIColor.green
    }
    // MARK: - Cell content colors
    /// hex: F0F0F0, alpha: 1
    public static var defaultCellColor: UIColor {
        switch AppThemeManager.current.type {
        default:
                return UIColor(hex: "F0F0F0", alpha: 1.0)
        }
    }
    
    /// hex: E8E8E8, alpha: 1
    public static var infoCellColor: UIColor {
        switch AppThemeManager.current.type {
        default:
            return UIColor(hex: "E8E8E8", alpha: 1.0)
        }
    }
}
