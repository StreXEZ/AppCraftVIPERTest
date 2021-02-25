//
//  AppDelegate.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.setup(application)
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.setup(window)
        
        return true
    }

    // MARK: - Application configuration
    private func setup(_ application: UIApplication) {
        
    }
    
    // MARK: - Window configuration
    private func setup(_ window: UIWindow) {
        let vc = InitialAssembly.create()
        _ = InitialAssembly.configure(with: vc)

        self.window = window
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }

}
