//
//  FixturesResponseModel.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//
// SportFixturesResponseModels.swift

import Foundation

struct FootballFixturesResponse: Decodable {
    let result: [FootballEventResponse]

    init(result: [FootballEventResponse]) {
        self.result = result
    }
}

struct FootballEventResponse: Decodable {
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventFinalResult: String?
    let eventStatus: String?
    let eventDate: String?
    let eventTime: String?

    init(eventHomeTeam: String?, eventAwayTeam: String?, homeTeamLogo: String?, awayTeamLogo: String?, eventFinalResult: String?, eventStatus: String?, eventDate: String?, eventTime: String?) {
        self.eventHomeTeam = eventHomeTeam
        self.eventAwayTeam = eventAwayTeam
        self.homeTeamLogo = homeTeamLogo
        self.awayTeamLogo = awayTeamLogo
        self.eventFinalResult = eventFinalResult
        self.eventStatus = eventStatus
        self.eventDate = eventDate
        self.eventTime = eventTime
    }

    enum CodingKeys: String, CodingKey {
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventFinalResult = "event_final_result"
        case eventStatus = "event_status"
        case eventDate = "event_date"
        case eventTime = "event_time"
    }
}

struct BasketballFixturesResponse: Decodable {
    let result: [BasketballEventResponse]

    init(result: [BasketballEventResponse]) {
        self.result = result
    }
}

struct BasketballEventResponse: Decodable {
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let eventFinalResult: String?
    let eventStatus: String?
    let eventDate: String?
    let eventTime: String?

    init(eventHomeTeam: String?, eventAwayTeam: String?, homeTeamLogo: String?, awayTeamLogo: String?, eventFinalResult: String?, eventStatus: String?, eventDate: String?, eventTime: String?) {
        self.eventHomeTeam = eventHomeTeam
        self.eventAwayTeam = eventAwayTeam
        self.homeTeamLogo = homeTeamLogo
        self.awayTeamLogo = awayTeamLogo
        self.eventFinalResult = eventFinalResult
        self.eventStatus = eventStatus
        self.eventDate = eventDate
        self.eventTime = eventTime
    }

    enum CodingKeys: String, CodingKey {
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case homeTeamLogo = "event_home_team_logo"
        case awayTeamLogo = "event_away_team_logo"
        case eventFinalResult = "event_final_result"
        case eventStatus = "event_status"
        case eventDate = "event_date"
        case eventTime = "event_time"
    }
}

struct TennisFixturesResponse: Decodable {
    let result: [TennisEventResponse]

    init(result: [TennisEventResponse]) {
        self.result = result
    }
}

struct TennisEventResponse: Decodable {
    let firstPlayer: String?
    let secondPlayer: String?
    let firstPlayerLogo: String?
    let secondPlayerLogo: String?
    let eventFinalResult: String?
    let eventStatus: String?
    let eventDate: String?
    let eventTime: String?

    init(firstPlayer: String?, secondPlayer: String?, firstPlayerLogo: String?, secondPlayerLogo: String?, eventFinalResult: String?, eventStatus: String?, eventDate: String?, eventTime: String?) {
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondPlayer
        self.firstPlayerLogo = firstPlayerLogo
        self.secondPlayerLogo = secondPlayerLogo
        self.eventFinalResult = eventFinalResult
        self.eventStatus = eventStatus
        self.eventDate = eventDate
        self.eventTime = eventTime
    }

    enum CodingKeys: String, CodingKey {
        case firstPlayer = "event_first_player"
        case secondPlayer = "event_second_player"
        case firstPlayerLogo = "event_first_player_logo"
        case secondPlayerLogo = "event_second_player_logo"
        case eventFinalResult = "event_final_result"
        case eventStatus = "event_status"
        case eventDate = "event_date"
        case eventTime = "event_time"
    }
}

struct CricketFixturesResponse: Decodable {
    let result: [CricketEventResponse]

    init(result: [CricketEventResponse]) {
        self.result = result
    }
}

struct CricketEventResponse: Decodable {
    let eventHomeTeam: String?
    let eventAwayTeam: String?
    let homeTeamLogo: String?
    let awayTeamLogo: String?
    let homeFinalResult: String?
    let awayFinalResult: String?
    let eventStatus: String?
    let eventDate: String?
    let eventTime: String?

    init(eventHomeTeam: String?, eventAwayTeam: String?, homeTeamLogo: String?, awayTeamLogo: String?, homeFinalResult: String?, awayFinalResult: String?, eventStatus: String?, eventDate: String?, eventTime: String?) {
        self.eventHomeTeam = eventHomeTeam
        self.eventAwayTeam = eventAwayTeam
        self.homeTeamLogo = homeTeamLogo
        self.awayTeamLogo = awayTeamLogo
        self.homeFinalResult = homeFinalResult
        self.awayFinalResult = awayFinalResult
        self.eventStatus = eventStatus
        self.eventDate = eventDate
        self.eventTime = eventTime
    }

    enum CodingKeys: String, CodingKey {
        case eventHomeTeam = "event_home_team"
        case eventAwayTeam = "event_away_team"
        case homeTeamLogo = "event_home_team_logo"
        case awayTeamLogo = "event_away_team_logo"
        case homeFinalResult = "event_home_final_result"
        case awayFinalResult = "event_away_final_result"
        case eventStatus = "event_status"
        case eventDate = "event_date_start"
        case eventTime = "event_time"
    }
}

protocol FixturesResponse: Decodable {
    func toEvents() -> [Event]
}

extension FootballFixturesResponse: FixturesResponse {
    func toEvents() -> [Event] { result.map { $0.toEvent() } }
}

extension BasketballFixturesResponse: FixturesResponse {
    func toEvents() -> [Event] { result.map { $0.toEvent() } }
}

extension TennisFixturesResponse: FixturesResponse {
    func toEvents() -> [Event] { result.map { $0.toEvent() } }
}

extension CricketFixturesResponse: FixturesResponse {
    func toEvents() -> [Event] { result.map { $0.toEvent() } }
}
