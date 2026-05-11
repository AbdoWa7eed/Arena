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
    private let service: LeagueDetailsServiceProtocol
    private let league: League

    private var upcomingEvents: [Event] = []
    private var latestEvents: [Event]   = []
    private var teams: [Team] = []

    init(view: LeagueDetailsViewProtocol,
         league: League,
         service: LeagueDetailsServiceProtocol) {
        self.view  = view
        self.league  = league
        self.service = service
    }

    func viewDidLoad() {
        fetchData()
    }

    func numberOfItems(in section: LeagueDetailsSection) -> Int {
        switch section {
        case .upcomingEvents: return upcomingEvents.count
        case .latestEvents:   return latestEvents.count
        case .teams:  return teams.count
        }
    }

    func getUpcomingEvent(at index: Int) -> Event { upcomingEvents[index] }
    func getLatestEvent(at index: Int)   -> Event { latestEvents[index]   }
    func getTeam(at index: Int)          -> Team  { teams[index]          }

    func didSelectItem(in section: LeagueDetailsSection, at index: Int) {
        if section == .teams {
            let team = getTeam(at: index)
            view?.navigateToTeamDetails(team)
        }
    }

    private func fetchData() {
        view?.showLoading()
        let group = DispatchGroup()
        var eventsError: Error?
        var teamsError: Error?

        group.enter()
        service.fetchEvents(league) { [weak self] result in
            switch result {
            case .success(let events):
                self?.filterEvents(events)
            case .failure(let error):
                eventsError = error
            }
            group.leave()
        }

        group.enter()
        service.fetchTeams(league) { [weak self] result in
            switch result {
            case .success(let teams):
                self?.teams = teams
            case .failure(let error):
                teamsError = error
            }
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.view?.hideLoading()

            if eventsError != nil && teamsError != nil {
                self.view?.showError(eventsError!.localizedDescription)
                return
            }

            if self.upcomingEvents.isEmpty && self.latestEvents.isEmpty && self.teams.isEmpty {
                self.view?.showEmpty()
            } else {
                self.view?.showData()
            }
        }
    }
    
    private func filterEvents(_ allEvents: [Event]) {
        
        let formatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            df.timeZone = TimeZone.current
            return df
        }()
        
        let today = Calendar.current.startOfDay(for: Date())
        
        
        self.upcomingEvents = allEvents.filter {
            guard let date = formatter.date(from: $0.date) else { return false }
            return date >= today
        }
        
        self.latestEvents = allEvents.filter {
            guard let date = formatter.date(from: $0.date) else { return false }
            return date < today
        }
    }
}
