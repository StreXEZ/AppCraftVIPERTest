//
//  StyleWrapper+UITabBar.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import UIKit

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
