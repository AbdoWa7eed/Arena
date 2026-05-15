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
    private let favoriteService: FavoriteLeagueServiceProtocol
    private var sport: Sport!
    private var allLeagues: [League] = []
    private var filteredLeagues: [League] = []
    private var isSearching = false

    init(view: LeaguesViewProtocol, sport: Sport, service: LeaguesServiceProtocol, favoriteService: FavoriteLeagueServiceProtocol) {
        self.view = view
        self.sport = sport
        self.service = service
        self.favoriteService = favoriteService
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
        view?.navigateToLeagueDetails(league: league)
    }

    func didToggleFavorite(at index: Int) {
        let league = isSearching ? filteredLeagues[index] : allLeagues[index]
        if league.isFavorite {
            favoriteService.deleteLeague(withKey: league.key)
        } else {
            favoriteService.saveLeague(league)
        }
        let newState = !league.isFavorite
        update(in: &allLeagues, key: league.key, isFavorite: newState)
        update(in: &filteredLeagues, key: league.key, isFavorite: newState)
        view?.showLeagues()
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
        filteredLeagues.isEmpty ? view?.showEmpty() : view?.showLeagues()
    }

    func didCancelSearch() {
        isSearching = false
        filteredLeagues = []
        allLeagues.isEmpty ? view?.showEmpty() : view?.showLeagues()
    }

    private func fetchLeagues() {
        view?.showLoading()
        service.fetchLeagues(sport: sport) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let leagues):
                    self.handleFetchSuccess(leagues)
                case .failure(let error):
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }

    private func handleFetchSuccess(_ leagues: [League]) {
        allLeagues = mergeWithFavorites(leagues)
        allLeagues.isEmpty ? view?.showEmpty() : view?.showLeagues()
    }


    private func mergeWithFavorites(_ leagues: [League]) -> [League] {
        let favoriteKeys = Set(favoriteService.fetchLeagues().map { $0.key })
        return leagues.map {
            var league = $0
            league.isFavorite = favoriteKeys.contains($0.key)
            return league
        }
    }

    private func update(in array: inout [League], key: String, isFavorite: Bool) {
        guard let index = array.firstIndex(where: { $0.key == key }) else { return }
        array[index].isFavorite = isFavorite
    }
}
