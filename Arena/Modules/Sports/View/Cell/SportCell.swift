//
//  SportCell.swift
//  Arena
//
//  Created by Abdelrahman on 06/05/2026.
//

import UIKit

class SportCell: UICollectionViewCell {
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupElevation()
    }
    
    private func setupElevation() {
        self.contentView.layer.cornerRadius = 16
        self.contentView.layer.masksToBounds = true
        self.sportImage.contentMode = .scaleToFill

        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 6
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 16).cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 16).cgPath
    }
    
    func configure(_ sport: Sport) {
        self.sportImage.image = UIImage(named: sport.imageName)
        self.sportLabel.text = sport.rawValue.capitalized
    }
}
