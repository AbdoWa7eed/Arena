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

    func makeSplashPresenter(view: SplashView) -> SplashViewPresenter {
        return SplashPresenter(view: view, userDefaults: userDefaults)
    }

    func makeOnboardingPresenter(view: OnboardingViewProtocol) -> OnboardingPresenterProtocol {
        return OnboardingPresenter(view: view, userDefaults: userDefaults)
    }
    
    func makeSportsPresenter(view: SportsViewProtocol) -> SportsPresenterProtocol {
        return SportsPresenter(view: view)
    }
}
