//
//  Routes.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import Foundation
import UIKit

enum Routes {
    static let splash = "SplashViewController"
    static let onboardingStoryboard = "Onboarding"
    static let onboardingVC = "OnboardingViewController"
    static let onboardingContentVC = "OnboardingContentViewController"
}

enum AppRouter {
    static func makeSplash() -> SplashViewController {
        SplashViewController(nibName: Routes.splash, bundle: nil)
    }

    static func makeOnboarding() -> OnboardingViewController {
        let storyboard = UIStoryboard(name: Routes.onboardingStoryboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Routes.onboardingVC) as! OnboardingViewController
    }

}
