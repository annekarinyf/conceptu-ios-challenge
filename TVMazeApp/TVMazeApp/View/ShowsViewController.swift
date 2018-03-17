//
//  ShowsViewController.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 15/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {
    
    var shows = [Show]()
    
    @IBOutlet var showsCollectionView: UICollectionView!
    @IBOutlet var showSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSearchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getShows()
    }
    
    private func getShows() {
        ApiHelper.getShows { (shows) in
            self.shows = shows
            self.showsCollectionView.reloadData()
        }
    }
    
    private func searchShows(forSearchText searchText: String) {
        ApiHelper.getShows(forSearchWords: searchText) { (shows) in
            self.shows = shows
            self.showsCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ShowsViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension ShowsViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showCollectionViewCell", for: indexPath) as! ShowCollectionViewCell
        
        let showViewModel = ShowViewModel(show: shows[indexPath.row])
        cell.showName.text = showViewModel.name
        showViewModel.getImage { (image) in
            cell.showImage.image = image
        }
    
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension ShowsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchText == ""  ? getShows() : searchShows(forSearchText: searchText)
    }
}

