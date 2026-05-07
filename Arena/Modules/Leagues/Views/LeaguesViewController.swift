import UIKit

class LeaguesViewController: UIViewController, LeaguesViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var sport: Sport!
    
    static let cellIdentifier = "LeagueCell"

    private var presenter: LeaguesPresenterProtocol!

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let messageLabel: UILabel = UILabel.makeMessageLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AppContainer.shared.makeLeaguesPresenter(view: self)
        setupCustomTitleFont(title: sport.name)
        setupTableView()
        setupSearchBar()
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarVisibilty(true)
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: LeaguesViewController.cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: LeaguesViewController.cellIdentifier)
    }

    private func setupSearchBar() {
        searchBar.delegate = self
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

    func showLeagues() {
        tableView.backgroundView = nil
        tableView.reloadData()
    }

    func showEmpty() {
        messageLabel.text = "No leagues available."
        tableView.backgroundView = messageLabel
        tableView.reloadData()
    }

    func showError(_ message: String) {
        messageLabel.text = "Something went wrong:\n\(message)"
        tableView.backgroundView = messageLabel
        tableView.reloadData()
    }
}

extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfLeagues
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaguesViewController.cellIdentifier, for: indexPath) as! LeagueCell
        cell.configure(presenter.getLeague(at: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectLeague(at: indexPath.row)
        let league = presenter.getLeague(at: indexPath.row)
        guard let storyboard = self.storyboard else {return }
        navigationController?.pushViewController(AppRouter.makeLeagueDetailsController(using: storyboard , league: league), animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension LeaguesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.didSearch(query: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        presenter.didCancelSearch()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
