//
//  CustomTabBarItem.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//

import Foundation
import UIKit

enum CustomTabBarItem: Int, CaseIterable {
    case all = 0
    case saved = 1
}

extension CustomTabBarItem: CustomTabBarItemPresentable {
    var image: UIImage? {
        switch self {
        case .all:
            return AppAssets.tbRemoteList
        case .saved:
            return AppAssets.tbLocalList
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .all:
            return AppAssets.tbRemoteListActive
        case .saved:
            return AppAssets.tbLocalListActive
        }
    }
}
