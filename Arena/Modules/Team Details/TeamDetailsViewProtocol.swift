//
//  TeamDetailsViewProtocol.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

protocol TeamDetailsViewProtocol: AnyObject {
    var team: Team! {get}
    func showLoading()
    func hideLoading()
    func showData()
    func showError(message: String)
}
