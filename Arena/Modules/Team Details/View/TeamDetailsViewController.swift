//
//  TeamDetailsViewController.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import UIKit

class TeamDetailsViewController: UICollectionViewController, TeamDetailsViewProtocol {

    
    private enum CellID {
        static let team   = "TeamHeroCell"
        static let player = "PlayerCell"
        static let empty  = "EmptyCell"
    }
    
    private enum HeaderID {
        static let section = "SectionHeaderView"
    }

    private var presenter: TeamDetailsPresenterProtocol!
    private var isLoading: Bool = true

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let messageLabel: UILabel = UILabel.makeMessageLabel()
    
    var team: Team!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AppContainer.shared.makeTeamDetailsPresenter(view:self, team:team)
        setupCollectionView()
        presenter.viewDidLoad()
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = makeLayout()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = false

        collectionView.register(UINib(nibName: CellID.team, bundle: nil), forCellWithReuseIdentifier: CellID.team)
        collectionView.register(UINib(nibName: CellID.player, bundle: nil), forCellWithReuseIdentifier: CellID.player)
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: CellID.empty)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderID.section)
    }

    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self, let section = TeamDetailsSection(rawValue: sectionIndex) else { return nil }
            switch section {
            case .hero:  return self.makeHeroSection()
            case .squad: return self.makeSquadSection()
            }
        }
    }

    private func makeHeroSection() -> NSCollectionLayoutSection {
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(340))
        let item      = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(340))
        let group     = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let layout    = NSCollectionLayoutSection(group: group)
        layout.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 24, trailing: 16)
        return layout
    }

    private func makeSquadSection() -> NSCollectionLayoutSection {
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let item      = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group     = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let layout    = NSCollectionLayoutSection(group: group)
        layout.interGroupSpacing = 12
        layout.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 32, trailing: 0)
        layout.boundarySupplementaryItems = [makeSectionHeader()]
        return layout
    }

    private func makeSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }

    func showLoading() {
        isLoading = true
        activityIndicator.startAnimating()
        collectionView.backgroundView = activityIndicator
        collectionView.reloadData()
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
        collectionView.backgroundView = nil
    }

    func showData() {
        isLoading = false
        collectionView.backgroundView = nil
        collectionView.reloadData()
    }

    func showError(message: String) {
        isLoading = false
        messageLabel.text = message
        collectionView.backgroundView = messageLabel
        collectionView.reloadData()
    }
}

extension TeamDetailsViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        isLoading || presenter.getTeam() == nil ? 0 : TeamDetailsSection.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let s = TeamDetailsSection(rawValue: section) else { return 0 }
        return presenter.numberOfItems(in: s)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = TeamDetailsSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .hero:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.team, for: indexPath) as! TeamHeroCell
            if let team = presenter.getTeam() { cell.configure(team) }
            return cell

        case .squad:
            if !presenter.hasPlayers() {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.empty, for: indexPath) as! EmptyCell
                cell.configure(message: "No squad data available for this team.")
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.player, for: indexPath) as! PlayerCell
            cell.configure(with: presenter.getPlayer(at: indexPath.item))
            return cell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderID.section, for: indexPath) as! SectionHeaderView
        header.configure(title: TeamDetailsSection(rawValue: indexPath.section)?.title ?? "")
        return header
    }
}
