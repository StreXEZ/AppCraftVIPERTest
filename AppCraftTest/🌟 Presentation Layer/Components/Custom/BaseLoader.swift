//
//  BaseLoader.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 28.02.2021.
//

import Foundation
import SVProgressHUD
import GKViper
import UIKit

class BaseLoader {
    
    private let outerRadius: CGFloat = 32
    private let outerColor: UIColor = UIColor.lightGray
    
    private let ringRadius: CGFloat = 12
    private let ringThickness: CGFloat = 3
    private let ringColor: UIColor = UIColor.green
    
    init() {
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultStyle(.custom)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.setRingRadius(self.ringRadius)
            SVProgressHUD.setRingThickness(self.ringThickness)
            SVProgressHUD.setRingNoTextRadius(self.ringRadius)
            SVProgressHUD.setMinimumSize(CGSize(width: self.outerRadius * 2, height: self.outerRadius * 2))
            SVProgressHUD.setCornerRadius(self.outerRadius)
            SVProgressHUD.setForegroundColor(self.ringColor)
            SVProgressHUD.setBackgroundColor(self.outerColor)
        }
    }
    
    func show() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    func show(title: String?) {
        DispatchQueue.main.async {
            SVProgressHUD.setCornerRadius(self.outerRadius / 2)
            SVProgressHUD.show(withStatus: title)
        }
    }
    
    func showSuccess(title: String?, duration: TimeInterval = 2) {
        DispatchQueue.main.async {
            SVProgressHUD.setCornerRadius(self.outerRadius / 2)
            SVProgressHUD.setMinimumDismissTimeInterval(duration)
            SVProgressHUD.setMaximumDismissTimeInterval(duration)
            SVProgressHUD.setDefaultMaskType(.none)
            SVProgressHUD.showSuccess(withStatus: title)
        }
    }
}
