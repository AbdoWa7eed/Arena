//
//  ApiClient.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation
import Alamofire

final class ApiClient {
            
    func request<T: Decodable>(
        endpoint: ApiConstants.Endpoint,
        parameters: Parameters = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        guard ConnectivityManager.shared.isConnected else {
            completion(.failure(NetworkError.noInternet))
            return
        }
        
        let url = "\(ApiConstants.baseUrl)/\(endpoint.rawValue)"
        
        var parameters = parameters
        parameters[ApiParams.Key.apiKey.rawValue] = ApiConstants.apiKey
        
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error):
                    completion(.failure(
                        error.isResponseSerializationError
                        ? NetworkError.decodingError
                        : error
                    ))
                }
            }
    }
}
