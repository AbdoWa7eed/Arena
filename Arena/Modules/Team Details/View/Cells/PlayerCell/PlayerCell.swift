//
//  PlayerCell.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//
import UIKit
import SDWebImage
import UIKit
import SDWebImage

class PlayerCell: UICollectionViewCell {
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var mainContainer: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        mainContainer.layer.cornerRadius = 16
        mainContainer.layer.masksToBounds = true

        layer.masksToBounds = false
        layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6

        playerImageView.layer.cornerRadius = 10
        playerImageView.contentMode = .scaleAspectFill
        playerImageView.clipsToBounds = true

        positionLabel.textColor = .secondaryLabel
        numberLabel.textColor = UIColor.lightGray.withAlphaComponent(0.2)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
    }
    
    func configure(with player: Player) {
        nameLabel.text = player.name
        positionLabel.text = player.position
        numberLabel.text = player.number
        
        playerImageView.sd_setImage(with: URL(string: player.imageUrl), placeholderImage: UIImage(named: "player_placeholder"))
    }
}
