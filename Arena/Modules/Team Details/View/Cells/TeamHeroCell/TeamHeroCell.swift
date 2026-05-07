//
//  TeamDetailsCell.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//
import UIKit
import SDWebImage

class TeamHeroCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var coachNameLabel: UILabel!
    @IBOutlet weak var coachIconImageView: UIImageView!
    @IBOutlet weak var leagueTagLabel: UILabel!
    @IBOutlet weak var countryTagLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure(_ model: TeamDetailsModel) {
        teamNameLabel.text = model.teamName
        coachNameLabel.text = "Coach: \(model.coachName)"
        leagueTagLabel.text = model.leagueName.uppercased()
        countryTagLabel.text = model.countryName.uppercased()
        
        badgeImageView.sd_setImage(
            with: URL(string: model.logoUrl),
            placeholderImage: UIImage(named: "team_placeholder"))
    }

    private func setupUI() {
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true

        layer.masksToBounds = false
        layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 28).cgPath

        styleTag(leagueTagLabel)
        styleTag(countryTagLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 28).cgPath
    }
    
    private func styleTag(_ label: UILabel) {
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.backgroundColor = UIColor(named: "PrimaryBrand")?.withAlphaComponent(0.1)
        label.textColor = UIColor(named: "PrimaryBrand")
        label.textAlignment = .center
    }

}
