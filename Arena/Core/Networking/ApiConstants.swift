//
//  ApiConstants.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation


enum ApiConstants {
    
    static let baseUrl = "https://apiv2.allsportsapi.com"

    static let apiKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String, !key.isEmpty else {
            fatalError("API_KEY missing from Info.plist")
        }
        return key
    }()

    enum Endpoint: String {
        case football
        case basketball
        case tennis
        case cricket
    }
}
