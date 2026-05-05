//
//  OnboardingPresenterProtocol.swift
//  Arena
//
//  Created by Abdelrahman on 05/05/2026.
//

import Foundation


protocol OnboardingPresenterProtocol {
    var numberOfPages: Int { get }
    func viewDidLoad()
    func didTapNext()
    func didFinishSwiping(to index: Int)
    func getPageData(at index: Int) -> OnboardingPage?
}
