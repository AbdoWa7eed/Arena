//
//  LeaguesViewProtocol.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

protocol LeaguesViewProtocol: AnyObject {
    var sport: Sport! {get}
    func showLeagues()
    func showLoading()
    func hideLoading()
    func showEmpty()
    func showError(_ message: String)
    func navigateToLeagueDetails(league:League)
}
