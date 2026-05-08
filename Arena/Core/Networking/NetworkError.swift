//
//  NetworkError.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation

enum NetworkError: Error {
    
    case noInternet
    case invalidResponse
    case decodingError
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No internet connection."
            
        case .invalidResponse:
            return "Invalid server response."
            
        case .decodingError:
            return "Failed to decode server response."
            
        case .serverError(let message):
            return message
        }
    }
}
