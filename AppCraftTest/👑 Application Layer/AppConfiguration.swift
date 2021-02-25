//
//  AppConfiguration.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import Foundation

enum AppConfiguration {
    
    static var databaseContainerName: String {
        return "AppCraftTest"
    }
    
    static var serverUrl: String {
        let url = "https://pokeapi.co/"
        if url.isEmpty {
            fatalError("[AppConfiguration] - Set your server url in AppConfiguration")
        }
        return url
    }
    
    static var serverApi: String {
        return AppConfiguration.serverUrl + "api/"
    }
    
}
