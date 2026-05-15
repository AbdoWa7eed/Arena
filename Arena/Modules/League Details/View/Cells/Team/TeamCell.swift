//
//  TeamCell.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//
import UIKit
import SDWebImage

class TeamCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {

        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true

        layer.masksToBounds = false
        layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6

        logoImageView.contentMode = .scaleAspectFit
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 16
        ).cgPath
    }

    func configure(_ team: Team) {
        nameLabel.text = team.name
        logoImageView.sd_setImage(
            with: URL(string: team.logoUrl),
            placeholderImage: UIImage(named: "team_placeholder")
        )
    }
}
