//
//  ConnectionManager.swift
//  AppCraftTest
//
//  Created by Khusnullin Denis on 01.03.2021.
//

import Foundation
import Reachability

protocol ConnectionManagerDelegate: AnyObject {
    func connectionDidChange(isConnected: Bool)
}

class ConnectionManager {
    static let shared = ConnectionManager()
    private var reachability = try? Reachability()

    init() { }
    
    public func isConnected() -> Bool {
        return self.reachability?.connection != Reachability.Connection.unavailable
    }

}
