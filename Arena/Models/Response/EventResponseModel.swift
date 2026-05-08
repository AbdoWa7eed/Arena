//
//  FixturesResponseModel.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation

struct FixturesResponseModel: Decodable {
    let success: Int
    let result: [EventResponseModel]
}

struct EventResponseModel: Decodable {
    
    let homeTeam: String?
    let awayTeam: String?
    let homeLogo: String?
    let awayLogo: String?
    
    let finalResult: String?
    
    let status: String?
    let date: String?
    let time: String?
    
    enum CodingKeys: String, CodingKey {
        case homeTeam = "event_home_team"
        case awayTeam = "event_away_team"
        case homeLogo = "event_home_team_logo"
        case awayLogo = "event_away_team_logo"
        case finalResult = "event_final_result"
        case status = "event_status"
        case date = "event_date"
        case time = "event_time"
    }
}
