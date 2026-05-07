//
//  TeamDetails.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation


struct Player {
    let name: String
    let position: String
    let number: String
    let imageUrl: String
}

struct TeamDetailsModel {
    let teamName: String
    let logoUrl: String
    let coachName: String
    let leagueName: String
    let countryName: String
    let players: [Player]
}
