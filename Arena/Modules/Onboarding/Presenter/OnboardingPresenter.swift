//
//  OnboardingPresenter.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import Foundation

class OnboardingPresenter: OnboardingPresenterProtocol {
    private weak var view: OnboardingViewProtocol?
    private var userDefaults: UserDefaultsManagerProtocol
    private var currentIndex = 0

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            imageName: "onboarding1",
            title: "Track Your Leagues",
            description: "Get updates, scores, and deep-dive statistics for all your favorite competitions."
        ),
        OnboardingPage(
            imageName: "onboarding2",
            title: "Never Miss a Match",
            description: "Save leagues to your favorites for instant access, even when you are offline."
        )
    ]

    var numberOfPages: Int { pages.count }

    init(view: OnboardingViewProtocol, userDefaults: UserDefaultsManagerProtocol) {
        self.view = view
        self.userDefaults = userDefaults
    }

    func viewDidLoad() {
        view?.showPage(at: currentIndex, data: pages[currentIndex])
    }

    func didTapNext() {
        if currentIndex < pages.count - 1 {
            currentIndex += 1
            view?.showPage(at: currentIndex, data: pages[currentIndex])
            view?.updateButtonName(currentIndex == pages.count - 1)
        } else {
            userDefaults.hasSeenOnboarding = true
            view?.navigateToHome()
        }
    }

    func didFinishSwiping(to index: Int) {
        currentIndex = index
        view?.updatePageControl(index: index)
        view?.updateButtonName(currentIndex == pages.count - 1)
    }

    func getPageData(at index: Int) -> OnboardingPage? {
        guard index >= 0 && index < pages.count else { return nil }
        return pages[index]
    }
}
