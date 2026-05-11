//
//  ConnectivityManager.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation
import Network

final class ConnectivityManager {

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private(set) var isConnected: Bool = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
