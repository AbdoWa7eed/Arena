//
//  AppContainer.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import Foundation

final class AppContainer {
    static let shared = AppContainer()
    
    private init() {}

    private let userDefaults: UserDefaultsManagerProtocol = UserDefaultsManager.shared
    
    private let apiClient: ApiClient = ApiClient()

    func makeSplashPresenter(view: SplashView) -> SplashViewPresenter {
        return SplashPresenter(view: view, userDefaults: userDefaults)
    }

    func makeOnboardingPresenter(view: OnboardingViewProtocol) -> OnboardingPresenterProtocol {
        return OnboardingPresenter(view: view, userDefaults: userDefaults)
    }
    
    func makeSportsPresenter(view: SportsViewProtocol) -> SportsPresenterProtocol {
        return SportsPresenter(view: view)
    }
    
    func makeLeaguesPresenter(view: LeaguesViewProtocol) -> LeaguesPresenterProtocol {
        return LeaguesPresenter(view: view, sport: view.sport)
    }
    
    func makeLeagueDetailsPresenter(view: LeagueDetailsViewProtocol) -> LeagueDetailsPresenterProtocol {
        return LeagueDetailsPresenter(view: view, league: view.league)
    }
}
