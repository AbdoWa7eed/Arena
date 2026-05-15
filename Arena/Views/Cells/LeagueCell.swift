//
//  LeagueCell.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//
import UIKit
import SDWebImage

protocol LeagueCellDelegate: AnyObject {
    func didToggleFavorite(for cell: LeagueCell, isFavorite: Bool)
}

class LeagueCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    weak var delegate: LeagueCellDelegate?
    private var isFavorite: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.clipsToBounds = false
        setupImageView()
        setupFavoriteButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        leagueImage.layer.cornerRadius = leagueImage.frame.height / 2
    }

    private func setupImageView() {
        leagueImage.layer.cornerRadius = leagueImage.frame.height / 2
        leagueImage.clipsToBounds = true
        leagueImage.contentMode = .scaleAspectFit
    }

    private func setupFavoriteButton() {
        favoriteButton.tintColor = .systemGray3
        updateFavoriteIcon(animated: false)
    }

    func configure(_ league: League, showFavoriteButton: Bool = true) {
        leagueName.text = league.name
        countryName.text = league.country
        leagueImage.sd_setImage(
            with: URL(string: league.imageUrl),
            placeholderImage: UIImage(named: "league_placeholder")
        )
        self.isFavorite = league.isFavorite
        favoriteButton.isHidden = !showFavoriteButton
        updateFavoriteIcon(animated: false)
    }

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        print("Button physically tapped inside LeagueCell")
        delegate?.didToggleFavorite(for: self, isFavorite: isFavorite)
        updateFavoriteIcon(animated: true)
    }
    

    private func updateFavoriteIcon(animated: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        let color: UIColor = isFavorite ? .systemRed : .systemGray3
        let image = UIImage(systemName: imageName)

        if animated {
            UIView.animate(withDuration: 0.1, animations: {
                self.favoriteButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.favoriteButton.tintColor = color
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    self.favoriteButton.transform = .identity
                }
            }
            favoriteButton.setImage(image, for: .normal)
        } else {
            favoriteButton.setImage(image, for: .normal)
            favoriteButton.tintColor = color
        }
    }
}
