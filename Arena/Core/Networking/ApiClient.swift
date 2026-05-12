//
//  ApiClient.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation
import Alamofire

protocol ApiClientProtocol {
    func request<T: Decodable>(
        endpoint: String,
        parameters: Parameters,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

final class ApiClient : ApiClientProtocol{
    
    private let connectivity: ConnectivityManager
    
    init(connectivity: ConnectivityManager) {
        self.connectivity = connectivity
    }
            
    func request<T: Decodable>(
        endpoint: String,
        parameters: Parameters = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = "\(ApiConstants.baseUrl)/\(endpoint)"

        var parameters = parameters
        parameters[ApiParams.Key.apiKey.rawValue] = ApiConstants.apiKey

        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(NetworkError.map(
                        error,
                        data: response.data,
                        statusCode: response.response?.statusCode
                    )))
                }
            }
    }
}
