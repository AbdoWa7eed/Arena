//
//  TeamDetailsPresenter.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation
import Foundation

class TeamDetailsPresenter: TeamDetailsPresenterProtocol {
    
    private weak var view: TeamDetailsViewProtocol?
    private var teamData: Team?
    
    init(view: TeamDetailsViewProtocol, team: Team) {
        self.teamData = team
        self.view = view
    }
    
    func viewDidLoad() {
        self.view?.showData()
    }
    
    func numberOfItems(in section: TeamDetailsSection) -> Int {
        guard let teamData = teamData else { return 0 }
        switch section {
        case .hero:  return 1
        case .squad: return teamData.players.isEmpty ? 1 : teamData.players.count
        }
    }
    
    func getTeam() -> Team? {
        return teamData
    }
    
    func getPlayer(at index: Int) -> Player {
        return teamData!.players[index]
    }
    
    func hasPlayers() -> Bool {
        return !(teamData?.players.isEmpty ?? true)
    }
    
}
