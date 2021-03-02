//
//  AppLocalization.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 25.02.2021.
//  Copyright © 2021 AppCraft. All rights reserved.
//

import Foundation

enum AppLocalization {
    
    enum General: String, Localizable {
        case ok         = "OK"
        case save       = "SAVE"
        case cancel     = "CANCEL"
        case close      = "CLOSE"
        case attention  = "ATTENSION"
        case unknown    = "UNKNOWN"
        case loading    = "LOADING"
        case refresh    = "REFRESH"
        case tryAgain   = "TRY_AGAIN"
        case yes        = "YES"
        case noo        = "NO"
        case error      = "ERROR"
        case warning    = "WARNING"
        case cont       = "CONTINUE"
        case search     = "SEARCH"
        case next       = "NEXT"
        case delete     = "DELETE"
    }
    
    enum Titles: String, Localizable {
        case remoteList     = "RemoteListTitle"
        case localList      = "LocalListTitle"
        case pokemonDetails = "PokemonDetailsTitle"
    }
    
    enum Alerts: String, Localizable {
        case deleteAlertTitle   = "DeleteAlertTitle"
        case deleteAlertBody    = "DeleteAlertBody"
        
        case alreadySavedTitle  = "AlreadtSavedTitle"
        case alreadtSavedBody   = "AlreadtSavedBody"
    }
    
    enum PokemonDetails: String, Localizable {
        case typeLabel       = "PokemonTypeLabel"
        case def             = "PokemonDefaultType"
        case nondef          = "PokemonNonDefaultType"
        case baseExperience = "PokemonBaseExperience"
        case height          = "PokemonHeight"
        case weight          = "PokemonWeight"
    }
    
    enum InfoMessages: String, Localizable {
        case emptyList      = "EmptyListMessage"
        case noConnection   = "NoConnectionMessage"
    }
    
    enum Theme: String, Localizable {
        case light  = "APP_THEME_LIGHT"
        case dark   = "APP_THEME_DARK"
    }
    
    enum Language: String, Localizable {
        case english    = "APP_LANG_ENG"
        case russian    = "APP_LANG_RUS"
    }
    
    enum Initial: String, Localizable {
        case title  = "INITIAL_TITLE"
    }
    
}
