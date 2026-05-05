//
//  SplashPresenter.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import Foundation

class SplashPresenter: SplashViewPresenter {
    private weak var view: SplashView?
    private let userDefaults: UserDefaultsManagerProtocol

    init(view: SplashView, userDefaults: UserDefaultsManagerProtocol) {
        self.view = view
        self.userDefaults = userDefaults
    }

    func splashAnimationDidFinish() {
        if userDefaults.hasSeenOnboarding {
            view?.navigateToHome()
        } else {
            view?.navigateToOnboarding()
        }
    }
}
