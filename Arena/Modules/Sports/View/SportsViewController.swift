//
//  SportsViewController.swift
//  Arena
//
//  Created by Abdelrahman on 06/05/2026.
//

import UIKit

class SportsViewController: UIViewController, SportsViewProtocol {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var presenter: SportsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AppContainer.shared.makeSportsPresenter(view: self)
        setupCollectionView()
        presenter.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBarVisibilty(false)
    }
    
    private var hasLayedOut = false

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasLayedOut {
            hasLayedOut = true
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: "SportCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SportCell")
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
            layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension SportsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfSports
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCell", for: indexPath) as! SportCell
        
        let sport = presenter.getSport(at: indexPath.row)
        cell.configure(sport)
        
        return cell
    }
}

extension SportsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectSport(at: indexPath.row)

        guard let storyboard = self.storyboard else { return }
        
        let leaguesVC = AppRouter.makeLeaguesController(using: storyboard)
        self.navigationController?.pushViewController(leaguesVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing
        let width = (collectionView.bounds.width - totalSpacing) / 2
        return CGSize(width: width, height: width * 1.3)
    }
    
    
}
