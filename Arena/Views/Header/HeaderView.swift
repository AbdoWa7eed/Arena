//
//  HeaderView.swift
//  Arena
//
//  Created by Abdelrahman on 11/05/2026.
//

import Foundation
import UIKit

class HeaderView: UIView {

    private let titleLabel = UILabel()
    private let themeButton = UIButton(type: .system)
    private var userDefaults = AppContainer.shared.userDefaults

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor(named: "PrimaryBackground")

        titleLabel.font = UIFont(name: "Lexend-Bold", size: 42)
        titleLabel.textColor = UIColor(named: "PrimaryBrand")
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        themeButton.translatesAutoresizingMaskIntoConstraints = false
        themeButton.tintColor = .label
        themeButton.addAction(UIAction { [weak self] _ in
            self?.toggleTapped()
        }, for: .touchUpInside)

        addSubview(titleLabel)
        addSubview(themeButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            themeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            themeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            themeButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            themeButton.widthAnchor.constraint(equalToConstant: 36),
            themeButton.heightAnchor.constraint(equalToConstant: 36)
        ])

        updateIcon()
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    private func toggleTapped() {
        let isDark = !currentIsDark
        userDefaults.isDarkMode = isDark
        applyTheme(isDark ? .dark : .light)
        updateIcon()
    }

    func updateIcon() {
        let icon = currentIsDark ? "sun.max.fill" : "moon.fill"
        themeButton.setImage(UIImage(systemName: icon), for: .normal)
        themeButton.tintColor = UIColor(named: "PrimaryBrand")
    }

    private func applyTheme(_ style: UIUserInterfaceStyle) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.forEach { $0.overrideUserInterfaceStyle = style }
    }

    private var currentIsDark: Bool {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return userDefaults.isDarkMode
        }
        return window.overrideUserInterfaceStyle == .dark
    }
}
