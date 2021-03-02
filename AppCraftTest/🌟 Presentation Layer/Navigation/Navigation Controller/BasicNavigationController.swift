//
//  BasicNavigationController.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import UIKit

class BasicNavigationController: UINavigationController {
    
    class func create(with rootController: UIViewController) -> BasicNavigationController {
        let nc = BasicNavigationController(rootViewController: rootController)
        return nc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setupUI() {
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = .black
        
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = false
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return AppTheme.statusBarStyle
    }
    
}
