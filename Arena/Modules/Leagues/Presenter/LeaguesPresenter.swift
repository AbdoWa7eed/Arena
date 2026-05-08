//
//  LeaguesPresenter.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

class LeaguesPresenter: LeaguesPresenterProtocol {

    private weak var view: LeaguesViewProtocol?
    private var sport: Sport!
    private var allLeagues: [League] = []
    private var filteredLeagues: [League] = []
    private var isSearching = false

    init(view: LeaguesViewProtocol, sport: Sport) {
        self.view = view
        self.sport = sport
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
        view?.showLoading()
        // TODO: replace with real API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.allLeagues = self.getDummyLeagues()
            self.view?.hideLoading()
            if self.allLeagues.isEmpty {
                self.view?.showEmpty()
            } else {
                self.view?.showLeagues()
            }
        }
    }

    private func getDummyLeagues() -> [League] {
        return [
            League(
                key: "39",
                name: "Premier League",
                country: "England",
                imageUrl: "https://media.api-sports.io/football/leagues/39.png"
            ),
            League(
                key: "140",
                name: "La Liga",
                country: "Spain",
                imageUrl: "https://media.api-sports.io/football/leagues/140.png"
            ),
            League(
                key: "135",
                name: "Serie A",
                country: "Italy",
                imageUrl: "https://media.api-sports.io/football/leagues/135.png"
            ),
            League(
                key: "78",
                name: "Bundesliga",
                country: "Germany",
                imageUrl: "https://media.api-sports.io/football/leagues/78.png"
            ),
            League(
                key: "61",
                name: "Ligue 1",
                country: "France",
                imageUrl: "https://media.api-sports.io/football/leagues/61.png"
            )
        ]
    }
}
