//
//  EventCell.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//
import UIKit

class EventCell: UICollectionViewCell {

    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        homeTeamLabel.superview?.layer.cornerRadius = 8

        layer.masksToBounds = false
        layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath

        homeTeamImageView.contentMode = .scaleAspectFit
        awayTeamImageView.contentMode = .scaleAspectFit
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
    }

    func configure(_ event: Event) {
        homeTeamImageView.sd_setImage(with: URL(string: event.homeTeam.logoUrl), placeholderImage: UIImage(named: "team_placeholder"))
        awayTeamImageView.sd_setImage(with: URL(string: event.awayTeam.logoUrl), placeholderImage: UIImage(named: "team_placeholder"))
        homeTeamLabel.text = event.homeTeam.name
        awayTeamLabel.text = event.awayTeam.name
        dateTimeLabel.text = "\(event.date) • \(event.time)"
    }
}
