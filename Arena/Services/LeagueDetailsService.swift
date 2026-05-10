//
//  LeagueDetailsService.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation
import Foundation

protocol LeagueDetailsServiceProtocol {
    func fetchEvents(_ league: League,
        completion: @escaping (Result<[Event], Error>) -> Void
    )
    
    func fetchTeams(_ league: League,
        completion: @escaping (Result<[Team], Error>) -> Void
    )
}

final class LeagueDetailsService: LeagueDetailsServiceProtocol {
    
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchEvents(_ league: League,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        let range = makeDateRange()
        let params: [String: Any] = [
            ApiParams.Key.met.rawValue: ApiParams.Met.fixtures.rawValue,
            ApiParams.Key.leagueId.rawValue: league.key,
            ApiParams.Key.from.rawValue: range.from,
            ApiParams.Key.to.rawValue: range.to
        ]

        switch league.sport {
        case .football:
            fetchEvents(FootballFixturesResponse.self, parameters: params, endpoint: league.sport.rawValue, completion: completion)
        case .basketball:
            fetchEvents(BasketballFixturesResponse.self, parameters: params, endpoint: league.sport.rawValue, completion: completion)
        case .tennis:
            fetchEvents(TennisFixturesResponse.self, parameters: params, endpoint: league.sport.rawValue, completion: completion)
        case .cricket:
            fetchEvents(CricketFixturesResponse.self, parameters: params, endpoint: league.sport.rawValue, completion: completion)
        }
    }
    
    func fetchTeams(
        _ league: League,
        completion: @escaping (Result<[Team], Error>) -> Void
    ) {
        let params: [String: Any] = [
            ApiParams.Key.met.rawValue: ApiParams.Met.teams.rawValue,
            ApiParams.Key.leagueId.rawValue: league.key,
        ]

        apiClient.request(
            endpoint: league.sport.rawValue,
            parameters: params
        ) { (result: Result<TeamsResponseModel, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.result.map { $0.toTeam(
                    leagueName: league.name,
                    countryName: league.country) }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchEvents<T: FixturesResponse>(
        _ type: T.Type,
        parameters: [String: Any],
        endpoint: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        apiClient.request(endpoint: endpoint, parameters: parameters) { (result: Result<T, Error>) in
            completion(result.map { $0.toEvents() })
        }
    }
    
    private func makeDateRange() -> (from: String, to: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = Date()
        let past = Calendar.current.date(byAdding: .day, value: -7, to: today)!
        let future = Calendar.current.date(byAdding: .day, value: 7, to: today)!
        
        return (
            formatter.string(from: past),
            formatter.string(from: future)
        )
    }
}
