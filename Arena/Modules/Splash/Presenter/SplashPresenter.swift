//
//  SplashPresenter.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import Foundation

class SplashPresenter: SplashViewPresenter {
    private weak var view: SplashView?

    init(view: SplashView) {
        self.view = view
    }

    func splashAnimationDidFinish() {
        // TODO: CHECK IF THE ONBOARDING HAS BEEN SEEN OR NOT
        print("Splash Finished")
        view?.navigateToOnboarding()
    }
}
