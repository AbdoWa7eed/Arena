//
//  NetworkError.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation
import Alamofire

enum NetworkError: LocalizedError {

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
            return "No data found for this league"
        case .serverError(let message):
            return message
        }
    }
    
    static func map(_ error: AFError, data: Data?, statusCode: Int?) -> NetworkError {
        if error.isResponseSerializationError {
            return .decodingError
        }

        if let urlError = error.underlyingError as? URLError,
           urlError.code == .notConnectedToInternet || urlError.code == .networkConnectionLost {
            return .noInternet
        }

        if let data = data,
           let message = try? JSONDecoder().decode([String: String].self, from: data)["message"] {
            return .serverError(message)
        }

        return .serverError("An Unknwon Error Occurred")
    }
}
