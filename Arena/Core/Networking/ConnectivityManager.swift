//
//  ConnectivityManager.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation
import Network

final class ConnectivityManager {
    
    static let shared = ConnectivityManager()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private(set) var isConnected: Bool = false
    
    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        
        monitor.start(queue: queue)
    }
}
