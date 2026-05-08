//
//  LeaguesPresenter.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

class LeaguesPresenter: LeaguesPresenterProtocol {

    private weak var view: LeaguesViewProtocol?
    private let service: LeaguesServiceProtocol
    private var sport: Sport!
    private var allLeagues: [League] = []
    private var filteredLeagues: [League] = []
    private var isSearching = false

    init(view: LeaguesViewProtocol, sport: Sport, service: LeaguesServiceProtocol) {
        self.view = view
        self.sport = sport
        self.service = service
    }

    var numberOfLeagues: Int {
        return isSearching ? filteredLeagues.count : allLeagues.count
    }

    func viewDidLoad() {
        fetchLeagues()
    }

    func getLeague(at index: Int) -> League {
        return isSearching ? filteredLeagues[index] : allLeagues[index]
    }

    func didSelectLeague(at index: Int) {
        let league = getLeague(at: index)
        print("Selected: \(league.name)")
    }

    func didSearch(query: String) {
        if query.isEmpty {
            didCancelSearch()
            return
        }
        isSearching = true
        filteredLeagues = allLeagues.filter {
            $0.name.lowercased().contains(query.lowercased()) ||
            $0.country.lowercased().contains(query.lowercased())
        }
        if filteredLeagues.isEmpty {
            view?.showEmpty()
        } else {
            view?.showLeagues()
        }
    }

    func didCancelSearch() {
        isSearching = false
        filteredLeagues = []
        if allLeagues.isEmpty {
            view?.showEmpty()
        } else {
            view?.showLeagues()
        }
    }


    private func fetchLeagues() {
        print("DEBUG: Starting fetch for \(sport.name)")
        view?.showLoading()
        service.fetchLeagues(sport: sport) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let leagues):
                    print("DEBUG: Received \(leagues.count) leagues") // Does this print?
                    self.allLeagues = leagues
                    leagues.isEmpty ? self.view?.showEmpty() : self.view?.showLeagues()
                case .failure(let error):
                    print("DEBUG: Failed with error: \(error)")
                    self.view?.showEmpty()
                }
            }
        }
    }
}
