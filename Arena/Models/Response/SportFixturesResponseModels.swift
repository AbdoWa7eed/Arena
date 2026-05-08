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
