//
//  FavoritesViewController.swift
//  Arena
//
//  Created by Abdelrahman on 07/05/2026.
//

import UIKit

class FavoritesViewController: UIViewController, FavoritesViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    static let cellIdentifier = "LeagueCell"

    private var presenter: FavoritesPresenterProtocol!

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: "BodyText")
        label.font = UIFont(name: "Lexend-Regular", size: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritesPresenter(view: self)
        setupTableView()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarVisibilty(false)
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: FavoritesViewController.cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FavoritesViewController.cellIdentifier)
    }


    func showLoading() {
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
        tableView.reloadData()
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
        tableView.backgroundView = nil
    }

    func showFavorites() {
        tableView.backgroundView = nil
        tableView.reloadData()
    }

    func showEmpty() {
        messageLabel.text = "No favorites yet."
        tableView.backgroundView = messageLabel
        tableView.reloadData()
    }

    func showError(_ message: String) {
        showAlert(title: "No Internet Connection", message: message)
    }

    func deleteFavorite(at index: Int) {
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
    }
    
    func navigateToLeagueDetails(league: League) {
        // TODO: push LeagueDetailsViewController and pass league
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfFavorites
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesViewController.cellIdentifier, for: indexPath) as! LeagueCell
        cell.configure(presenter.getFavorite(at: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectFavorite(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { [weak self] _, _, completion in
            self?.presenter.didDeleteFavorite(at: indexPath.row)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "heart.slash.fill")
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
