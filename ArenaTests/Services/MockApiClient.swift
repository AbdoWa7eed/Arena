//
//  MockApiClient.swift
//  ArenaTests
//
//  Created by Abdelrahman on 12/05/2026.
//

import Foundation
import Alamofire
@testable import Arena

final class MockApiClient: ApiClientProtocol {
    var result: Result<Any, Error>?
    var capturedEndpoint: String?
    var capturedParameters: Parameters?

    func request<T: Decodable>(
        endpoint: String,
        parameters: Parameters,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        capturedEndpoint = endpoint
        capturedParameters = parameters
        
        if let result = result {
            switch result {
            case .success(let value):
                completion(.success(value as! T))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
