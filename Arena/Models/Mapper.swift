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

private func parseScores(from result: String?) -> (home: Int?, away: Int?) {
    guard let result = result, result != "-", result.contains("-") else {
        return (nil, nil)
    }
    let parts = result.split(separator: "-").map { $0.trimmingCharacters(in: .whitespaces) }
    return (Int(parts.first ?? ""), Int(parts.last ?? ""))
}

extension FootballEventResponse {
    func toEvent() -> Event {
        let scores = parseScores(from: eventFinalResult)
        return Event(
            homeTeam: SimpleTeam(name: eventHomeTeam ?? "", logoUrl: homeTeamLogo ?? ""),
            awayTeam: SimpleTeam(name: eventAwayTeam ?? "", logoUrl: awayTeamLogo ?? ""),
            homeScore: scores.home,
            awayScore: scores.away,
            status: eventStatus ?? "",
            date: eventDate ?? "",
            time: eventTime ?? ""
        )
    }
}

extension BasketballEventResponse {
    func toEvent() -> Event {
        let scores = parseScores(from: eventFinalResult)
        return Event(
            homeTeam: SimpleTeam(name: eventHomeTeam ?? "", logoUrl: homeTeamLogo ?? ""),
            awayTeam: SimpleTeam(name: eventAwayTeam ?? "", logoUrl: awayTeamLogo ?? ""),
            homeScore: scores.home,
            awayScore: scores.away,
            status: eventStatus ?? "",
            date: eventDate ?? "",
            time: eventTime ?? ""
        )
    }
}

extension TennisEventResponse {
    func toEvent() -> Event {
        let scores = parseScores(from: eventFinalResult)
        return Event(
            homeTeam: SimpleTeam(name: firstPlayer ?? "", logoUrl: firstPlayerLogo ?? ""),
            awayTeam: SimpleTeam(name: secondPlayer ?? "", logoUrl: secondPlayerLogo ?? ""),
            homeScore: scores.home,
            awayScore: scores.away,
            status: eventStatus ?? "",
            date: eventDate ?? "",
            time: eventTime ?? ""
        )
    }
}

extension CricketEventResponse {
    func toEvent() -> Event {
        let homeScore = Int(homeFinalResult?.split(separator: "/").first ?? "")
        let awayScore = Int(awayFinalResult?.split(separator: "/").first ?? "")
        return Event(
            homeTeam: SimpleTeam(name: eventHomeTeam ?? "", logoUrl: homeTeamLogo ?? ""),
            awayTeam: SimpleTeam(name: eventAwayTeam ?? "", logoUrl: awayTeamLogo ?? ""),
            homeScore: homeScore,
            awayScore: awayScore,
            status: eventStatus ?? "",
            date: eventDate ?? "",
            time: eventTime ?? ""
        )
    }
}


extension TeamItemResponse {

    func toTeam(leagueName: String? = nil, countryName: String? = nil) -> Team {

        return Team(
            key: teamKey,
            name: teamName,
            logoUrl: teamLogo ?? "",
            coachName: coaches?.first?.coachName,
            leagueName: leagueName,
            countryName: countryName,
            players: players?.map { $0.toPlayer() } ?? []
        )
    }
}

extension PlayerResponseModel {

    func toPlayer() -> Player {
        Player(
            name: playerName,
            position: playerType,
            number: playerNumber,
            imageUrl: playerImage ?? ""
        )
    }
}
