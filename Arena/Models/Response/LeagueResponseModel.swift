//
//  LeagueResponseModel.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation

struct LeagueResponseModel: Decodable {
    
    let success: Int
    let result: [LeagueItemResponse]
}

struct LeagueItemResponse: Decodable {
    
    let leagueKey: String
    let leagueName: String
    let countryName: String?
    let leagueLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
    }
}
