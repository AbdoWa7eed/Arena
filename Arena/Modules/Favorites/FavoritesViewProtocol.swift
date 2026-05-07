//
//  FavoritesViewProtocol.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation


protocol FavoritesViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showFavorites()
    func showEmpty()
    func showError(_ message: String)
    func deleteFavorite(at index: Int)
    func navigateToLeagueDetails(league: League)
}
