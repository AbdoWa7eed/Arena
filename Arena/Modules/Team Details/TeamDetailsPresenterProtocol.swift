//
//  TeamDetailsPresenterProtocol.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

protocol TeamDetailsPresenterProtocol {
    func viewDidLoad()
    func numberOfItems(in section: TeamDetailsSection) -> Int
    func getTeam() -> Team?
    func getPlayer(at index: Int) -> Player
    func hasPlayers() -> Bool
}
