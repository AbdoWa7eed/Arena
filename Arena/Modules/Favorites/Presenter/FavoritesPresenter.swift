//
//  FavoritesPresenter.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

class FavoritesPresenter: FavoritesPresenterProtocol {

    private weak var view: FavoritesViewProtocol?
    private var favorites: [League] = []

    init(view: FavoritesViewProtocol) {
        self.view = view
    }

    var numberOfFavorites: Int {
        return favorites.count
    }

    func viewDidLoad() {
        fetchFavorites()
    }

    func getFavorite(at index: Int) -> League {
        return favorites[index]
    }

    func didSelectFavorite(at index: Int) {
        // TODO: check internet connectivity here
        // If no internet → view?.showError("No internet connection.")
        // If connected → navigate to league details
        let league = getFavorite(at: index)
        view?.showError("You Selected this league : \(league.name) ")
        print("Selected favorite: \(league.name)")
    }
    
    func didDeleteFavorite(at index: Int) {
        // TODO: delete from CoreData here later
        favorites.remove(at: index)
        if favorites.isEmpty {
            view?.showEmpty()
        } else {
            view?.showFavorites()
        }
    }

    private func fetchFavorites() {
        view?.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            // TODO: replace with actual core data fetching
            self.favorites = self.getDummyFavorites()
            self.view?.hideLoading()
            if self.favorites.isEmpty {
                self.view?.showEmpty()
            } else {
                self.view?.showFavorites()
            }
        }
    }

    private func getDummyFavorites() -> [League] {
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
