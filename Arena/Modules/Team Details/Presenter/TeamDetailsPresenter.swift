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
    private var teamData: TeamDetailsModel?
    
    init(view: TeamDetailsViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.teamData = self.getDummyData(withPlayers: false)
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
    
    func getTeam() -> TeamDetailsModel? {
        return teamData
    }
    
    func getPlayer(at index: Int) -> Player {
        return teamData!.players[index]
    }
    
    func hasPlayers() -> Bool {
        return !(teamData?.players.isEmpty ?? true)
    }
    
    private func getDummyData(withPlayers: Bool) -> TeamDetailsModel {
        let players = withPlayers ? [
            Player(name: "Michele Di Gregorio", position: "Goalkeeper", number: "16",
                   imageUrl: "https://resources.premierleague.com/premierleague/photos/players/250x250/p200785.png"),
            Player(name: "Danilo", position: "Defender", number: "6",
                   imageUrl: "https://resources.premierleague.com/premierleague/photos/players/250x250/p161868.png"),
            Player(name: "Manuel Locatelli", position: "Midfielder", number: "5",
                   imageUrl: "https://resources.premierleague.com/premierleague/photos/players/250x250/p184029.png"),
            Player(name: "Dušan Vlahović", position: "Forward", number: "9",
                   imageUrl: "https://resources.premierleague.com/premierleague/photos/players/250x250/p461358.png")
        ] : []
        
        return TeamDetailsModel(
            teamName: "Juventus FC",
            logoUrl: "https://upload.wikimedia.org/wikipedia/commons/d/da/Juventus_Logo.png",
            coachName: "Thiago Motta",
            leagueName: "SERIE A",
            countryName: "ITALY",
            players: players
        )
    }
}
