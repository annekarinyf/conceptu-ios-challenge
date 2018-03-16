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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        ApiHelper.getShows { (shows) in
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

