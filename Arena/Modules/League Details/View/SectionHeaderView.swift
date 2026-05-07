//
//  SectionHeaderView.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import Foundation
import UIKit

class SectionHeaderView: UICollectionReusableView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lexend-SemiBold", size: 18)
        label.textColor = UIColor(named: "BodyText")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String) {
        titleLabel.text = title
    }
}
