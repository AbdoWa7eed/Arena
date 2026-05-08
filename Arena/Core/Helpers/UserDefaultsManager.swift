//
//  UserDefaultsManager.swift
//  Arena
//
//  Created by Abdelrahman on 06/05/2026.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    var hasSeenOnboarding: Bool { get set }
    var isDarkMode: Bool { get set }
}

class UserDefaultsManager : UserDefaultsManagerProtocol {

    private let defaults = UserDefaults.standard

    private enum Keys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
        static let isDarkMode        = "isDarkMode"
    }

    var hasSeenOnboarding: Bool {
        get { defaults.bool(forKey: Keys.hasSeenOnboarding) }
        set { defaults.set(newValue, forKey: Keys.hasSeenOnboarding) }
    }

    var isDarkMode: Bool {
        get { defaults.bool(forKey: Keys.isDarkMode) }
        set { defaults.set(newValue, forKey: Keys.isDarkMode) }
    }
}
