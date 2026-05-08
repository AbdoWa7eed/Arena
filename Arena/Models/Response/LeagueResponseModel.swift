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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .leagueKey) {
            leagueKey = String(intValue)
        } else {
            leagueKey = try container.decode(String.self, forKey: .leagueKey)
        }
        
        leagueName = try container.decode(String.self, forKey: .leagueName)
        countryName = try? container.decode(String.self, forKey: .countryName)
        leagueLogo = try? container.decode(String.self, forKey: .leagueLogo)
    }
}
