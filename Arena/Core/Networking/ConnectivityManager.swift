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
    private(set) var isHardwareConnected: Bool = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isHardwareConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }

    func checkRealConnection(completion: @escaping (Bool) -> Void) {
        guard isHardwareConnected else {
            DispatchQueue.main.async { completion(false) }
            return
        }

        guard let url = URL(string: "https://captive.apple.com/hotspot-detect.html") else {
            DispatchQueue.main.async { completion(false) }
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        request.timeoutInterval = 3.0
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(false)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
        task.resume()
    }
}
