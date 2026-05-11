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

    func configure(_ model: Team) {
        teamNameLabel.text = model.name

        if let coach = model.coachName, !coach.isEmpty {
            coachNameLabel.text = "Coach: \(coach)"
            coachNameLabel.isHidden = false
            coachIconImageView.isHidden = false
        } else {
            coachNameLabel.isHidden = true
            coachIconImageView.isHidden = true
        }

        if let league = model.leagueName, !league.isEmpty {
            leagueTagLabel.text = league.uppercased()
            leagueTagLabel.superview?.isHidden = false
        } else {
            leagueTagLabel.superview?.isHidden = true
        }

        if let country = model.countryName,
            !country.isEmpty,
            !country.lowercased().elementsEqual("unknown")
        {
            countryTagLabel.text = country.uppercased()
            countryTagLabel.superview?.isHidden = false
        } else {
            countryTagLabel.superview?.isHidden = true
        }

        badgeImageView.sd_setImage(
            with: URL(string: model.logoUrl),
            placeholderImage: UIImage(named: "team_placeholder")
        )
    }

    private func setupUI() {
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true

        layer.masksToBounds = false
        layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 28).cgPath
    }
}
