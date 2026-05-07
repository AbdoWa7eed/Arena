//
//  FavoritesPresenterProtocol.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

protocol FavoritesPresenterProtocol {
    var numberOfFavorites: Int { get }
    func viewDidLoad()
    func getFavorite(at index: Int) -> League
    func didSelectFavorite(at index: Int)
    func didDeleteFavorite(at index: Int)
}
