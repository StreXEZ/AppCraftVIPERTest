//
//  Localizable.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import Foundation

protocol Localizable: RawRepresentable { }

extension Localizable {
    
    var key: String {
        return self.rawValue as? String ?? ""
    }
    
    var localized: String {
        let lang: String = AppLocalizationManager.current.type.localizationKey
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj"), let bundle = Bundle(path: path) {
            return NSLocalizedString(self.key, tableName: nil, bundle: bundle, value: "", comment: "")
        } else {
            return NSLocalizedString(self.key, comment: "")
        }
    }
    
    var loc: String {
        return self.localized
    }
    
}


extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var loc: String {
        return self.localized
    }
}
