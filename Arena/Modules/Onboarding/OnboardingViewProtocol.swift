//
//  OnboardingView.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import Foundation


protocol OnboardingViewProtocol: AnyObject {
    func showPage(at index: Int, data: OnboardingPage)
    func updateButtonName(_ isLastPage: Bool)
    func updatePageControl(index: Int)
    func navigateToHome()
}
