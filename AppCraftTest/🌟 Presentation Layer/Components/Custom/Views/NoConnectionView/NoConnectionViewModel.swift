//
//  NoConnectionViewModel.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import Foundation

struct NoConnectionViewModel {
    
    typealias ActionHandler = (_ view: NoConnectionView, _ action: Action) -> Void
    
    enum Action {
        case tapRefresh
    }
    
    var didAction: ActionHandler = { _, _ in }
}
