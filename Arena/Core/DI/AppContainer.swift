//
//  AppContainer.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import Foundation

final class AppContainer {
    
    static let shared = AppContainer()
    
    private init() {
        self.connectivityManager = ConnectivityManager()
        self._userDefaults = UserDefaultsManager()
        
        self.apiClient = ApiClient(connectivity: connectivityManager)
        
    }
    
    private let connectivityManager: ConnectivityManager
    private let apiClient: ApiClientProtocol
    
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
    
    private lazy var favoriteLeagueService: FavoriteLeagueServiceProtocol = {
        return FavoriteLeagueService(
            persistenceController: PersistenceController.shared
        )
    }()


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
        return LeaguesPresenter(view: view, sport: view.sport, service: leaguesService, favoriteService: favoriteLeagueService)
    }
    
    func makeLeagueDetailsPresenter(view: LeagueDetailsViewProtocol) -> LeagueDetailsPresenterProtocol {
        return LeagueDetailsPresenter(view: view, league: view.league,
        service: leagueDetailsService)
    }
    
    func makeTeamDetailsPresenter(view: TeamDetailsViewProtocol, team:Team) -> TeamDetailsPresenterProtocol {
        return TeamDetailsPresenter(view: view, team: team)
    }
    
    func makeFavoritesPresenter(
        view: FavoritesViewProtocol
    ) -> FavoritesPresenterProtocol {
        FavoritesPresenter(
            view: view,
            favoriteService: favoriteLeagueService,
            connectivityManager: connectivityManager
        )
    }
}
