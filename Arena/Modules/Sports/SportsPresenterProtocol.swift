//
//  SportsPresenterProtocol.swift
//  Arena
//
//  Created by Abdelrahman on 06/05/2026.
//

import Foundation

protocol SportsPresenterProtocol: AnyObject {
    var numberOfSports: Int { get }
    func getSport(at index: Int) -> Sport
    func viewDidLoad()
    func didSelectSport(at index: Int)
}
