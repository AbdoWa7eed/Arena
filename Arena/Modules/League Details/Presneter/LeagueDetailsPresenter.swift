//
//  LeagueDetailsPresenter.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

import Foundation

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {

    private weak var view: LeagueDetailsViewProtocol?
    private let league: League

    private var upcomingEvents: [Event] = []
    private var latestEvents: [Event]   = []
    private var teams: [Team]           = []

    init(view: LeagueDetailsViewProtocol, league: League) {
        self.view   = view
        self.league = league
    }

    func viewDidLoad() {
        fetchData()
    }

    func numberOfItems(in section: LeagueDetailsSection) -> Int {
        switch section {
        case .upcomingEvents: return upcomingEvents.count
        case .latestEvents:   return latestEvents.count
        case .teams:          return teams.count
        }
    }

    func getUpcomingEvent(at index: Int) -> Event { upcomingEvents[index] }
    func getLatestEvent(at index: Int)   -> Event { latestEvents[index]   }
    func getTeam(at index: Int)          -> Team  { teams[index]          }

    func didSelectItem(in section: LeagueDetailsSection, at index: Int) {
        switch section {
        case .teams:
            let team = getTeam(at: index)
            // TODO: navigate to team details
            print("Team tapped: \(team.name)")
        default :
            print("No navigation")
        }
    }


    private func fetchData() {
        view?.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            
            self.upcomingEvents = self.getDummyUpcomingEvents()
            self.latestEvents = self.getDummyLatestEvents()
            self.teams = self.getDummyTeams()
            
            self.view?.hideLoading()
            
            if self.upcomingEvents.isEmpty && self.latestEvents.isEmpty && self.teams.isEmpty {
                self.view?.showEmpty()
            } else {
                self.view?.showData()
            }
        }
    }

    private func getDummyUpcomingEvents() -> [Event] {
        return [
            Event(homeTeam: Team(name: "Arsenal", logoUrl: "https://media.api-sports.io/football/teams/42.png"),
                  awayTeam: Team(name: "Chelsea", logoUrl: "https://media.api-sports.io/football/teams/49.png"),
                  homeScore: nil, awayScore: nil, status: "Scheduled", date: "10 May 2026", time: "17:30"),
            
            Event(homeTeam: Team(name: "Liverpool", logoUrl: "https://media.api-sports.io/football/teams/40.png"),
                  awayTeam: Team(name: "Man City", logoUrl: "https://media.api-sports.io/football/teams/50.png"),
                  homeScore: nil, awayScore: nil, status: "Scheduled", date: "17 May 2026", time: "20:00"),
            
            Event(homeTeam: Team(name: "Tottenham", logoUrl: "https://media.api-sports.io/football/teams/47.png"),
                  awayTeam: Team(name: "Man United", logoUrl: "https://media.api-sports.io/football/teams/33.png"),
                  homeScore: nil, awayScore: nil, status: "Scheduled", date: "24 May 2026", time: "15:00")
        ]
    }

    private func getDummyLatestEvents() -> [Event] {
        return [
            Event(homeTeam: Team(name: "Chelsea", logoUrl: "https://media.api-sports.io/football/teams/49.png"),
                  awayTeam: Team(name: "Arsenal", logoUrl: "https://media.api-sports.io/football/teams/42.png"),
                  homeScore: 2, awayScore: 1, status: "Finished", date: "03 May 2026", time: "18:00"),
            
            Event(homeTeam: Team(name: "Man City", logoUrl: "https://media.api-sports.io/football/teams/50.png"),
                  awayTeam: Team(name: "Liverpool", logoUrl: "https://media.api-sports.io/football/teams/40.png"),
                  homeScore: 3, awayScore: 3, status: "Finished", date: "26 Apr 2026", time: "17:30"),
            
            Event(homeTeam: Team(name: "Man United", logoUrl: "https://media.api-sports.io/football/teams/33.png"),
                  awayTeam: Team(name: "Tottenham", logoUrl: "https://media.api-sports.io/football/teams/47.png"),
                  homeScore: 0, awayScore: 2, status: "Finished", date: "19 Apr 2026", time: "15:00")
        ]
    }

    private func getDummyTeams() -> [Team] {[
        Team(name: "Arsenal",    logoUrl: "https://media.api-sports.io/football/teams/42.png"),
        Team(name: "Chelsea",    logoUrl: "https://media.api-sports.io/football/teams/49.png"),
        Team(name: "Liverpool",  logoUrl: "https://media.api-sports.io/football/teams/40.png"),
        Team(name: "Man City",   logoUrl: "https://media.api-sports.io/football/teams/50.png"),
        Team(name: "Tottenham",  logoUrl: "https://media.api-sports.io/football/teams/47.png"),
        Team(name: "Man United", logoUrl: "https://media.api-sports.io/football/teams/33.png")
    ]}
}
