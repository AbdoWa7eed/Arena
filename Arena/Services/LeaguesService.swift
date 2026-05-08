//
//  LeaguesService.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation

protocol LeaguesServiceProtocol: AnyObject {
    func fetchLeagues(
        sport: Sport,
        completion: @escaping (Result<[League], Error>) -> Void
    )
}

final class LeaguesService: LeaguesServiceProtocol {
    
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchLeagues(
        sport: Sport,
        completion: @escaping (Result<[League], Error>) -> Void
    ) {
        
        let params: [String: Any] = [
            ApiParams.Key.met.rawValue: ApiParams.Met.leagues.rawValue
        ]
        
        apiClient.request(
            endpoint: sport.toEndpoint(),
            parameters: params
        ) { (result: Result<LeagueResponseModel, Error>) in
            
            switch result {
            case .success(let response):
                completion(.success(response.result.map { $0.toLeague() }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
