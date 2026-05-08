//
//  LeagueDetailsService.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation
import Foundation

protocol LeagueDetailsServiceProtocol {
    func fetchEvents(
        sport: Sport,
        leagueId: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    )
    
    func fetchTeams(
        sport: Sport,
        league: League,
        completion: @escaping (Result<[Team], Error>) -> Void
    )
}

final class LeagueDetailsService: LeagueDetailsServiceProtocol {
    
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchEvents(
        sport: Sport,
        leagueId: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        let range = makeDateRange()
        let params: [String: Any] = [
            ApiParams.Key.met.rawValue: ApiParams.Met.fixtures.rawValue,
            ApiParams.Key.leagueId.rawValue: leagueId,
            ApiParams.Key.from.rawValue: range.from,
            ApiParams.Key.to.rawValue: range.to
        ]

        switch sport {
        case .football:
            apiClient.request(endpoint: sport.toEndpoint(), parameters: params) { (result: Result<FootballFixturesResponse, Error>) in
                completion(result.map { $0.result.map { $0.toEvent() } })
            }
        case .basketball:
            apiClient.request(endpoint: sport.toEndpoint(), parameters: params) { (result: Result<BasketballFixturesResponse, Error>) in
                completion(result.map { $0.result.map { $0.toEvent() } })
            }
        case .tennis:
            apiClient.request(endpoint: sport.toEndpoint(), parameters: params) { (result: Result<TennisFixturesResponse, Error>) in
                completion(result.map { $0.result.map { $0.toEvent() } })
            }
        case .cricket:
            apiClient.request(endpoint: sport.toEndpoint(), parameters: params) { (result: Result<CricketFixturesResponse, Error>) in
                completion(result.map { $0.result.map { $0.toEvent() } })
            }
        }
    }
    
    func fetchTeams(
        sport: Sport,
        league: League,
        completion: @escaping (Result<[Team], Error>) -> Void
    ) {
        let params: [String: Any] = [
            ApiParams.Key.met.rawValue: ApiParams.Met.teams.rawValue,
            ApiParams.Key.leagueId.rawValue: league.key,
        ]

        apiClient.request(
            endpoint: sport.toEndpoint(),
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
