//
//  LeagueCell.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import UIKit
import SDWebImage
class LeagueCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupImageView() {
        leagueImage.layer.cornerRadius = leagueImage.frame.height / 2
        leagueImage.clipsToBounds = true
        leagueImage.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leagueImage.layer.cornerRadius = leagueImage.frame.height / 2
    }
    
    func configure(_ league: League) {
        leagueName.text = league.name
        countryName.text = league.country
        leagueImage.sd_setImage(
            with: URL(string: league.imageUrl),
            placeholderImage: UIImage(named: "league_placeholder")
        )
    }
}
