//
//  FavoritesPresenter.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

class FavoritesPresenter: FavoritesPresenterProtocol {

    private weak var view: FavoritesViewProtocol?
    private let favoriteService: FavoriteLeagueServiceProtocol
    private let connectivityManager: ConnectivityManager

    private var favorites: [League] = []

    init(
        view: FavoritesViewProtocol,
        favoriteService: FavoriteLeagueServiceProtocol,
        connectivityManager: ConnectivityManager
    ) {
        self.view = view
        self.favoriteService = favoriteService
        self.connectivityManager = connectivityManager
    }

    var numberOfFavorites: Int {
        favorites.count
    }

    func viewDidLoad() {
        fetchFavorites()
    }

    func getFavorite(at index: Int) -> League {
        favorites[index]
    }

    func didSelectFavorite(at index: Int) {
        connectivityManager.checkRealConnection { [weak self] isConnected in
            guard let self = self else { return }
            
            if isConnected {
                let league = self.getFavorite(at: index)
                self.view?.navigateToLeagueDetails(league: league)
            } else {
                self.view?.showError("No internet connection.")
            }
        }
    }

    func didDeleteFavorite(at index: Int) {
        let league = favorites[index]
        favoriteService.deleteLeague(withKey: league.key)
        favorites.remove(at: index)

        if favorites.isEmpty {
            view?.showEmpty()
        } else {
            view?.deleteFavorite(at: index)
        }
    }

    private func fetchFavorites() {
        view?.showLoading()
        self.favorites = self.favoriteService.fetchLeagues()
        self.view?.hideLoading()
        if self.favorites.isEmpty {
            self.view?.showEmpty()
        } else {
            self.view?.showFavorites()
        }
    }
}
