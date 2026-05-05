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


    func makeSplashPresenter(view: SplashView) -> SplashViewPresenter {
        return SplashPresenter(view: view)
    }
}
