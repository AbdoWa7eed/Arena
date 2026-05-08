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
    
    init(view: TeamDetailsViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.teamData = self.getDummyData()
            self.view?.hideLoading()
            self.view?.showData()
        }
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
    
    private func getDummyData() -> Team {
        
        return Team(
            key: "42",
            name: "Arsenal",
            logoUrl: "https://media.api-sports.io/football/teams/42.png",
            coachName: "Mikel Arteta",
            leagueName: "Premier League",
            countryName: "England",
            players: [
                Player(name: "Bukayo Saka", position: "Forward", number: "7", imageUrl: ""),
                Player(name: "Martin Ødegaard", position: "Midfielder", number: "8", imageUrl: ""),
                Player(name: "William Saliba", position: "Defender", number: "2", imageUrl: "")
            ]
        )
    }
}
