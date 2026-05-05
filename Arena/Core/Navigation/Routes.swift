//
//  Routes.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import Foundation


enum Routes {
    static let splash = "SplashViewController"
}

enum AppRouter {
    static func makeSplash() -> SplashViewController {
        SplashViewController(nibName: Routes.splash, bundle: nil)
    }
}
