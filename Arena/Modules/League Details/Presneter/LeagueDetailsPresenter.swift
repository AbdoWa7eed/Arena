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
    private var teams: [Team] = []

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
            view?.navigateToTeamDetails(team)
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
            Event(homeTeam: SimpleTeam(name: "Arsenal", logoUrl: "https://media.api-sports.io/football/teams/42.png"),
                  awayTeam: SimpleTeam(name: "Chelsea", logoUrl: "https://media.api-sports.io/football/teams/49.png"),
                  homeScore: nil, awayScore: nil, status: "Scheduled", date: "10 May 2026", time: "17:30"),
            
            Event(homeTeam: SimpleTeam(name: "Liverpool", logoUrl: "https://media.api-sports.io/football/teams/40.png"),
                  awayTeam: SimpleTeam(name: "Man City", logoUrl: "https://media.api-sports.io/football/teams/50.png"),
                  homeScore: nil, awayScore: nil, status: "Scheduled", date: "17 May 2026", time: "20:00"),
            
            Event(homeTeam: SimpleTeam(name: "Tottenham", logoUrl: "https://media.api-sports.io/football/teams/47.png"),
                  awayTeam: SimpleTeam(name: "Man United", logoUrl: "https://media.api-sports.io/football/teams/33.png"),
                  homeScore: nil, awayScore: nil, status: "Scheduled", date: "24 May 2026", time: "15:00")
        ]
    }

    private func getDummyLatestEvents() -> [Event] {
        return [
            Event(homeTeam: SimpleTeam(name: "Chelsea", logoUrl: "https://media.api-sports.io/football/teams/49.png"),
                  awayTeam: SimpleTeam(name: "Arsenal", logoUrl: "https://media.api-sports.io/football/teams/42.png"),
                  homeScore: 2, awayScore: 1, status: "Finished", date: "03 May 2026", time: "18:00"),
            
            Event(homeTeam: SimpleTeam(name: "Man City", logoUrl: "https://media.api-sports.io/football/teams/50.png"),
                  awayTeam: SimpleTeam(name: "Liverpool", logoUrl: "https://media.api-sports.io/football/teams/40.png"),
                  homeScore: 3, awayScore: 3, status: "Finished", date: "26 Apr 2026", time: "17:30"),
            
            Event(homeTeam: SimpleTeam(name: "Man United", logoUrl: "https://media.api-sports.io/football/teams/33.png"),
                  awayTeam: SimpleTeam(name: "Tottenham", logoUrl: "https://media.api-sports.io/football/teams/47.png"),
                  homeScore: 0, awayScore: 2, status: "Finished", date: "19 Apr 2026", time: "15:00")
        ]
    }

    private func getDummyTeams() -> [Team] {
        [
            Team(
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
            ),
            
            Team(
                key: "49",
                name: "Chelsea",
                logoUrl: "https://media.api-sports.io/football/teams/49.png",
                coachName: "Mauricio Pochettino",
                leagueName: "Premier League",
                countryName: "England",
                players: [
                    Player(name: "Enzo Fernández", position: "Midfielder", number: "8", imageUrl: ""),
                    Player(name: "Cole Palmer", position: "Forward", number: "20", imageUrl: ""),
                    Player(name: "Reece James", position: "Defender", number: "24", imageUrl: "")
                ]
            ),
            
            Team(
                key: "40",
                name: "Liverpool",
                logoUrl: "https://media.api-sports.io/football/teams/40.png",
                coachName: "Jürgen Klopp",
                leagueName: "Premier League",
                countryName: "England",
                players: []
            ),
            
            Team(
                key: "50",
                name: "Manchester City",
                logoUrl: "https://media.api-sports.io/football/teams/50.png",
                coachName: "Pep Guardiola",
                leagueName: "Premier League",
                countryName: "England",
                players: []
            ),
            
            Team(
                key: "47",
                name: "Tottenham",
                logoUrl: "https://media.api-sports.io/football/teams/47.png",
                coachName: "Ange Postecoglou",
                leagueName: "Premier League",
                countryName: "England",
                players: []
            ),
            
            Team(
                key: "33",
                name: "Manchester United",
                logoUrl: "https://media.api-sports.io/football/teams/33.png",
                coachName: "Erik ten Hag",
                leagueName: "Premier League",
                countryName: "England",
                players: []
            )
        ]
    }
}
