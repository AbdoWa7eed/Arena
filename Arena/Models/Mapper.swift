//
//  Mapper.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation

extension LeagueItemResponse {
    
    func toLeague() -> League {
        League(
            key: leagueKey,
            name: leagueName,
            country: countryName ?? "Unknown",
            imageUrl: leagueLogo ?? ""
        )
    }
}


extension EventResponseModel {
    
    func toEvent() -> Event {
        
        let home = SimpleTeam(
            name: homeTeam ?? "",
            logoUrl: homeLogo ?? ""
        )
        
        let away = SimpleTeam(
            name: awayTeam ?? "",
            logoUrl: awayLogo ?? ""
        )
        
        let scores = finalResult?
            .split(separator: "-")
            .map { $0.trimmingCharacters(in: .whitespaces) }
        
        return Event(
            homeTeam: home,
            awayTeam: away,
            homeScore: Int(scores?.first ?? ""),
            awayScore: Int(scores?.last ?? ""),
            status: status ?? "",
            date: date ?? "",
            time: time ?? ""
        )
    }
}

extension Sport {
    func toEndpoint() -> ApiConstants.Endpoint {
        switch self {
        case .football: return .football
        case .basketball: return .basketball
        case .tennis: return .tennis
        case .cricket: return .cricket
        }
    }
}

extension TeamItemResponse {
    func toTeam(leagueName: String = "" , countryName: String = "") -> Team {
        Team(
            key: String(teamKey),
            name: teamName,
            logoUrl: teamLogo ?? "",
            coachName: coaches.first?.coachName ?? "",
            leagueName: leagueName,
            countryName: countryName,
            players: players.map { $0.toPlayer() }
        )
    }
}

extension PlayerResponseModel {
    func toPlayer() -> Player {
        Player(
            name: playerName,
            position: playerType,
            number: playerNumber ?? "",
            imageUrl: playerImage ?? ""
        )
    }
}
