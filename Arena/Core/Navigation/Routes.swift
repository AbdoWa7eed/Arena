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

    static func makeMainApp() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
    }
    
    static func setRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
        
        UIView.transition(with: sceneDelegate.window!,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            sceneDelegate.window?.rootViewController = viewController
        })
    }

}
