//
//  LeagueDetailsPresenterProtocol.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation


protocol LeagueDetailsPresenterProtocol {
    func viewDidLoad()
    func numberOfItems(in section: LeagueDetailsSection) -> Int
    func getUpcomingEvent(at index: Int) -> Event
    func getLatestEvent(at index: Int) -> Event
    func getTeam(at index: Int) -> Team
    func didSelectItem(in section: LeagueDetailsSection, at index: Int)
}
