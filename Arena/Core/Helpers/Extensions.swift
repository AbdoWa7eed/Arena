//
//  Extensions.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation

import UIKit

extension UIViewController {
    func setupCustomTitleFont(title: String, fontName: String = "Lexend-Bold") {
        navigationController?.navigationBar.prefersLargeTitles = false
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: fontName, size: 20) ?? .systemFont(ofSize: 20, weight: .bold)
        
        label.textAlignment = .center
        label.textColor = UIColor(named: "HeadingText")
        label.sizeToFit()
        
        self.navigationItem.titleView = label
    }
    
    func setNavigationBarVisibilty(_ isVisible: Bool) {
        self.navigationController?.setNavigationBarHidden(!isVisible, animated: true)
    }
    
    func showAlert(
            title: String,
            message: String,
            actionTitle: String = "OK",
            action: (() -> Void)? = nil
        ) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: actionTitle, style: .default) { _ in
                action?()
            })
            present(alert, animated: true)
        }

    func showConfirmationAlert(
            title: String,
            message: String,
            confirmTitle: String = "Confirm",
            cancelTitle: String = "Cancel",
            onConfirm: (() -> Void)? = nil,
            onCancel: (() -> Void)? = nil
        ) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: confirmTitle, style: .destructive) { _ in
                onConfirm?()
            })
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                onCancel?()
            })
            present(alert, animated: true)
        }
    
}



extension UILabel {
    static func makeMessageLabel(message: String? = nil) -> UILabel {
        let label = UILabel()
        label.text = message ?? ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: "BodyText")
        label.font = UIFont(name: "Lexend-Regular", size: 16) ?? .systemFont(ofSize: 16)
        return label
    }
}
