//
//  LeaguesPresenterProtocol.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

protocol LeaguesPresenterProtocol: AnyObject {
    var numberOfLeagues: Int { get }
    func viewDidLoad()
    func getLeague(at index: Int) -> League
    func didSelectLeague(at index: Int)
    func didToggleFavorite(at: Int)
    func didSearch(query: String)
    func didCancelSearch()
}
