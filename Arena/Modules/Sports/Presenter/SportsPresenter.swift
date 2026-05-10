//
//  SportsPresenter.swift
//  Arena
//
//  Created by Abdelrahman on 06/05/2026.
//

import Foundation

class SportsPresenter: SportsPresenterProtocol {
    
    private weak var view: SportsViewProtocol?
    private var sports: [Sport] = Sport.allCases
    
    init(view: SportsViewProtocol) {
        self.view = view
    }
    
    var numberOfSports: Int {
        return sports.count
    }
    
    func viewDidLoad() {
        view?.reloadData()
    }
    
    func getSport(at index: Int) -> Sport {
        return sports[index]
    }
    
    func didSelectSport(at index: Int) {
        print("Selected: \(sports[index].rawValue)")
    }
}
