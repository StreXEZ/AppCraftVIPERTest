//
//  AppAssets.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import UIKit

enum AppAssets {
    static var appIcon: UIImage? {
        return UIImage(named: "AppIcon")
    }
    static var wipLogo: UIImage? {
        return UIImage(named: "AppWip")
    }
    static var tbRemoteList: UIImage? {
        return UIImage(systemName: "book")
    }
    static var tbRemoteListActive: UIImage? {
        return UIImage(systemName: "book.fill")
    }
    static var tbLocalList: UIImage? {
        return UIImage(systemName: "star")
    }
    static var tbLocalListActive: UIImage? {
        return UIImage(systemName: "star.fill")
    }
}
