//
//  SportsPresenter.swift
//  Arena
//
//  Created by Abdelrahman on 06/05/2026.
//

import Foundation

class SportsPresenter: SportsPresenterProtocol {
    
    private weak var view: SportsViewProtocol?
    private var sports: [Sport] = [
        Sport(name: "Soccer", imageName: "bg_soccer"),
        Sport(name: "Basketball", imageName: "bg_basketball"),
        Sport(name: "Tennis", imageName: "bg_tennis"),
        Sport(name: "Cricket", imageName: "bg_cricket")
    ]
    
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
        print("Selected: \(sports[index].name)")
    }
}
