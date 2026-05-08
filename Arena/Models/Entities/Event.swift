//
//  Event.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation
struct SimpleTeam {
    let name: String
    let logoUrl: String
}

struct Event {
    let homeTeam: SimpleTeam
    let awayTeam: SimpleTeam
    let homeScore: Int?
    let awayScore: Int?
    let status:String
    let date: String
    let time: String
}
