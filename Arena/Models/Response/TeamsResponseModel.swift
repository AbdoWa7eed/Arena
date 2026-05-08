//
//  TeamsResponseModel.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//

import Foundation

struct TeamsResponseModel: Decodable {
    let success: Int
    let result: [TeamItemResponse]
}

struct TeamItemResponse: Decodable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String?
    let players: [PlayerResponseModel]
    let coaches: [CoachResponseModel]

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
        case coaches
    }
}

struct PlayerResponseModel: Decodable {
    let playerName: String
    let playerType: String
    let playerNumber: String?
    let playerImage: String?

    enum CodingKeys: String, CodingKey {
        case playerName = "player_name"
        case playerType = "player_type"
        case playerNumber = "player_number"
        case playerImage = "player_image"
    }
}

struct CoachResponseModel: Decodable {
    let coachName: String?

    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
}
