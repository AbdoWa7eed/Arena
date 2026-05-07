//
//  LeagueDetailsViewProtocol.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

protocol LeagueDetailsViewProtocol: AnyObject {
    var league: League! {get}
    func showLoading()
    func hideLoading()
    func showData()
    func showEmpty()
    func showError(_ message: String)
}
