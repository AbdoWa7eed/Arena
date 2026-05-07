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
    
}
