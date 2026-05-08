//
//  AppContainer.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import Foundation

final class AppContainer {
    
    static let shared = AppContainer()
    
    private let connectivityManager: ConnectivityManager
    private let apiClient: ApiClient
    
    private let _userDefaults: UserDefaultsManagerProtocol
        var userDefaults: UserDefaultsManagerProtocol {
            get { _userDefaults }
        }
    
    private lazy var leaguesService: LeaguesServiceProtocol = {
            return LeaguesService(apiClient: self.apiClient)
        }()
    
    private lazy var leagueDetailsService: LeagueDetailsServiceProtocol = {
            return LeagueDetailsService(apiClient: self.apiClient)
        }()
    
    private init() {
        self.connectivityManager = ConnectivityManager()
        self._userDefaults = UserDefaultsManager()
        
        self.apiClient = ApiClient(connectivity: connectivityManager)
        
    }

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
        return LeaguesPresenter(view: view, sport: view.sport, service: leaguesService)
    }
    
    func makeLeagueDetailsPresenter(view: LeagueDetailsViewProtocol) -> LeagueDetailsPresenterProtocol {
        return LeagueDetailsPresenter(view: view, league: view.league, sport:view.sport,
        service: leagueDetailsService)
    }
    
    func makeTeamDetailsPresenter(view: TeamDetailsViewProtocol, team:Team) -> TeamDetailsPresenterProtocol {
        return TeamDetailsPresenter(view: view, team: team)
    }
}
