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

    var shouldFail = false
    var result: Result<Any, Error>?

    func request<T: Decodable>(
        endpoint: String,
        parameters: Parameters,
        completion: @escaping (Result<T, Error>) -> Void
    ) {

        if shouldFail {
            completion(.failure(NSError(domain: "network", code: 500)))
            return
        }

        guard let result = result else { return }

        switch result {
        case .success(let value):
            completion(.success(value as! T))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
