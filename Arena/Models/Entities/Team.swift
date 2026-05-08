//
//  Team.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

struct Team {
    let key: String
    let name: String
    let logoUrl: String
    let coachName: String?
    let leagueName: String?
    let countryName: String?
    let players: [Player]
}

struct Player {
    let name: String
    let position: String?
    let number: String?
    let imageUrl: String
}
