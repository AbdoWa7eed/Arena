//
//  LeagueDetailsSection.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation


enum LeagueDetailsSection: Int, CaseIterable {
    case upcomingEvents = 0
    case latestEvents   = 1
    case teams          = 2

    var title: String {
        switch self {
        case .upcomingEvents: return "Upcoming Events"
        case .latestEvents:   return "Latest Events"
        case .teams:          return "Teams"
        }
    }
}
