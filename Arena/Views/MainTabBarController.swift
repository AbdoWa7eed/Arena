//
//  BaseViewController.swift
//  Arena
//
//  Created by Abdelrahman on 11/05/2026.
//

import Foundation

import UIKit


class MainTabBarController: UITabBarController {

    private var headerView: HeaderView!
    private let titles = ["Arena", "Favorites"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        delegate = self
    }

    private func setupHeader() {
        headerView = HeaderView()
        headerView.setTitle(titles[0])
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        headerView.setTitle(titles[selectedIndex])
    }
}
