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
    static let mainNavigationController = "MainNavigationController"
    static let mainStoryboard = "Main"
    static let leaguesViewController = "LeaguesViewController"
    static let leagueDetailsViewController = "LeagueDetailsViewController"
    static let teamDetailsViewController = "TeamDetailsViewController"


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
        let storyboard = UIStoryboard(name: Routes.mainStoryboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Routes.mainNavigationController)
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
    
    static func makeLeaguesController(_ sport: Sport) -> LeaguesViewController {
        let storyboard = UIStoryboard(name: Routes.mainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Routes.leaguesViewController) as! LeaguesViewController
        vc.sport = sport
        return vc
    }

    static func makeLeagueDetailsController(_ league: League) -> LeagueDetailsViewController {
        let storyboard = UIStoryboard(name: Routes.mainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Routes.leagueDetailsViewController) as! LeagueDetailsViewController
        vc.league = league
        return vc
    }

    static func makeTeamDetailsController(_ team: Team) -> TeamDetailsViewController {
        let storyboard = UIStoryboard(name: Routes.mainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Routes.teamDetailsViewController) as! TeamDetailsViewController
        vc.team = team
        return vc
    }

}
