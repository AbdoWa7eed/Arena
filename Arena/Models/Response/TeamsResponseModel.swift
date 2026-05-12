//
//  TeamsResponseModel.swift
//  Arena
//
//  Created by Abdelrahman on 08/05/2026.
//
//


import Foundation

struct TeamsResponseModel: Decodable {
    let success: Int
    let result: [TeamItemResponse]

    init(success: Int = 0, result: [TeamItemResponse]) {
        self.success = success
        self.result = result
    }
}

struct TeamItemResponse: Decodable {
    let teamKey: String
    let teamName: String
    let teamLogo: String?
    let players: [PlayerResponseModel]?
    let coaches: [CoachResponseModel]?

    init(teamKey: Int, teamName: String, teamLogo: String?, players: [PlayerResponseModel]? = nil, coaches: [CoachResponseModel]? = nil) {
        self.teamKey = String(teamKey)
        self.teamName = teamName
        self.teamLogo = teamLogo
        self.players = players
        self.coaches = coaches
    }

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
        case coaches
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let intKey = try? container.decode(Int.self, forKey: .teamKey) {
            teamKey = String(intKey)
        } else {
            teamKey = try container.decode(String.self, forKey: .teamKey)
        }

        teamName = try container.decode(String.self, forKey: .teamName)
        teamLogo = try? container.decode(String.self, forKey: .teamLogo)
        players = try? container.decode([PlayerResponseModel].self, forKey: .players)
        coaches = try? container.decode([CoachResponseModel].self, forKey: .coaches)
    }
}

struct PlayerResponseModel: Decodable {
    let playerName: String
    let playerType: String?
    let playerNumber: String?
    let playerImage: String?

    init(playerName: String, playerType: String? = nil, playerNumber: String? = nil, playerImage: String? = nil) {
        self.playerName = playerName
        self.playerType = playerType
        self.playerNumber = playerNumber
        self.playerImage = playerImage
    }

    enum CodingKeys: String, CodingKey {
        case playerName = "player_name"
        case playerType = "player_type"
        case playerNumber = "player_number"
        case playerImage = "player_image"
    }
}

struct CoachResponseModel: Decodable {
    let coachName: String?

    init(coachName: String? = nil) {
        self.coachName = coachName
    }

    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
}
