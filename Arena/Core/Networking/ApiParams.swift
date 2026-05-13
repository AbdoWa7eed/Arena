//
//  ApiParams.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation
enum ApiParams {
    
    enum Met: String {
        case leagues = "Leagues"
        case teams = "Teams"
        case fixtures = "Fixtures"
    }
    
    enum Key: String {
        case met = "met"
        case apiKey = "APIkey"
        case from = "from"
        case to = "to"
        case leagueId = "leagueId"
    }
}
