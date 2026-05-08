//
//  TeamCell.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//
import UIKit
import SDWebImage

class TeamCell: UICollectionViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = false
    }

    func configure(_ team: Team) {
        nameLabel.text = team.name
        logoImageView.sd_setImage(
            with: URL(string: team.logoUrl),
            placeholderImage: UIImage(named: "team_placeholder")
        )
    }
}
