//
//  LeagueDetailsViewController.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import UIKit

class LeagueDetailsViewController: UICollectionViewController, LeagueDetailsViewProtocol {


    private enum CellID {
        static let event  = "EventCell"
        static let latest = "LatestEventCell"
        static let team   = "TeamCell"
    }

    private enum HeaderID {
        static let section = "SectionHeaderView"
    }


    var league: League!

    private var presenter: LeagueDetailsPresenterProtocol!
    private var isLoading = true

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let messageLabel: UILabel = UILabel.makeMessageLabel()


    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AppContainer.shared.makeLeagueDetailsPresenter(view: self)
        setupCustomTitleFont(title: league.name)
        setupCollectionView()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarVisibilty(true)
    }


    private func setupCollectionView() {
        collectionView.collectionViewLayout = makeLayout()
        collectionView.showsVerticalScrollIndicator = false

        collectionView.register(UINib(nibName: CellID.event,  bundle: nil), forCellWithReuseIdentifier: CellID.event)
        collectionView.register(UINib(nibName: CellID.latest, bundle: nil), forCellWithReuseIdentifier: CellID.latest)
        collectionView.register(UINib(nibName: CellID.team,   bundle: nil), forCellWithReuseIdentifier: CellID.team)
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderID.section
        )
    }


    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self,
                  let section = LeagueDetailsSection(rawValue: sectionIndex) else { return nil }
            guard !self.isLoading, self.presenter.numberOfItems(in: section) > 0 else { return nil }

            return self.makeSection(for: section)
        }
    }

    private func makeSection(for section: LeagueDetailsSection) -> NSCollectionLayoutSection {
        switch section {
        case .upcomingEvents: return makeCarouselSection(section)
        case .latestEvents:   return makeVerticalListSection(section)
        case .teams:          return makeHorizontalListSection(section)
        }
    }

    private func makeCarouselSection(_ section: LeagueDetailsSection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let layout = NSCollectionLayoutSection(group: group)
        layout.orthogonalScrollingBehavior = .groupPaging
        layout.interGroupSpacing = 0
        layout.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 24, trailing: 0)
        if let header = makeSectionHeader(for: section) {
            layout.boundarySupplementaryItems = [header]
        }
        return layout
    }

    private func makeVerticalListSection(_ section: LeagueDetailsSection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let layout = NSCollectionLayoutSection(group: group)
        layout.interGroupSpacing = 12
        layout.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 24, trailing: 0)
        if let header = makeSectionHeader(for: section) {
            layout.boundarySupplementaryItems = [header]
        }
        return layout
    }

    private func makeHorizontalListSection(_ section: LeagueDetailsSection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let layout = NSCollectionLayoutSection(group: group)
        layout.orthogonalScrollingBehavior = .continuous
        layout.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 32, trailing: 0)
        if let header = makeSectionHeader(for: section) {
            layout.boundarySupplementaryItems = [header]
        }
        return layout
    }

    private func makeSectionHeader(for section: LeagueDetailsSection) -> NSCollectionLayoutBoundarySupplementaryItem? {
        guard !isLoading, presenter.numberOfItems(in: section) > 0 else { return nil }
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = .zero
        return header
    }


    func showLoading() {
        isLoading = true
        collectionView.collectionViewLayout.invalidateLayout()
        activityIndicator.startAnimating()
        collectionView.backgroundView = activityIndicator
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

    func showEmpty() {
        isLoading = false
        messageLabel.text = "No data available for this league at the moment."
        collectionView.backgroundView = messageLabel
        collectionView.reloadData()
    }

    func showError(_ message: String) {
        isLoading = false
        messageLabel.text = message
        collectionView.backgroundView = messageLabel
        collectionView.reloadData()
    }

    func navigateToTeamDetails(_ team: Team) {
        let vc = AppRouter.makeTeamDetailsController(team)
        navigationController?.pushViewController(vc, animated: true)
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        LeagueDetailsSection.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let s = LeagueDetailsSection(rawValue: section) else { return 0 }
        return presenter.numberOfItems(in: s)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = LeagueDetailsSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .upcomingEvents:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.event, for: indexPath) as! EventCell
            cell.configure(presenter.getUpcomingEvent(at: indexPath.item))
            return cell
        case .latestEvents:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.latest, for: indexPath) as! LatestEventCell
            cell.configure(presenter.getLatestEvent(at: indexPath.item))
            return cell
        case .teams:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.team, for: indexPath) as! TeamCell
            cell.configure(presenter.getTeam(at: indexPath.item))
            return cell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderID.section,
            for: indexPath
        ) as! SectionHeaderView
        header.configure(title: LeagueDetailsSection(rawValue: indexPath.section)?.title ?? "")
        return header
    }


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = LeagueDetailsSection(rawValue: indexPath.section) else { return }
        presenter.didSelectItem(in: section, at: indexPath.item)
    }
}
