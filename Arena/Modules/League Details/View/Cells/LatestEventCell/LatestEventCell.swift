//
//  LatestEventCell.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import UIKit


class LatestEventCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var awayScoreLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!

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

        homeTeamImageView.contentMode = .scaleAspectFit
        awayTeamImageView.contentMode = .scaleAspectFit

        dividerView.backgroundColor = UIColor(named: "BodyText")?.withAlphaComponent(0.2)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
    }

    func configure(_ event: Event) {
        homeTeamLabel.text = event.homeTeam.name
        awayTeamLabel.text = event.awayTeam.name
        homeTeamImageView.sd_setImage(with: URL(string: event.homeTeam.logoUrl), placeholderImage: UIImage(named: "team_placeholder"))
        awayTeamImageView.sd_setImage(with: URL(string: event.awayTeam.logoUrl), placeholderImage: UIImage(named: "team_placeholder"))
        homeScoreLabel.text = "\(event.homeScore ?? 0)"
        awayScoreLabel.text = "\(event.awayScore ?? 0)"
        statusLabel.text = event.status
        dateLabel.text = event.date
    }
}
