//
//  ApiClient.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation
import Alamofire

final class ApiClient {
    
    private let connectivity: ConnectivityManager
    
    init(connectivity: ConnectivityManager) {
        self.connectivity = connectivity
    }
            
    func request<T: Decodable>(
        endpoint: ApiConstants.Endpoint,
        parameters: Parameters = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        guard connectivity.isConnected else {
            completion(.failure(NetworkError.noInternet))
            return
        }
        
        let url = "\(ApiConstants.baseUrl)/\(endpoint.rawValue)"
        
        var parameters = parameters
        parameters[ApiParams.Key.apiKey.rawValue] = ApiConstants.apiKey
        
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                
                print("Request URL:")
                print(response.request?.url?.absoluteString ?? "Invalid URL")
                
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                    
                case .failure(let error):
                    print(error)
                    completion(.failure(
                        error.isResponseSerializationError
                        ? NetworkError.decodingError
                        : error
                    ))
                }
            }
    }
}
