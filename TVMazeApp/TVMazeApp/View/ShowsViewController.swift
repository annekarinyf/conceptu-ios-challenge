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
        setTabBarItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let tabBarController = tabBarController {
            tabBarController.selectedIndex == 0 ? getShowsFromAPI() : getShowsFromDB()
        }
    }
    
    private func setTabBarItems(){
        if let tabBarController = tabBarController, let items = tabBarController.tabBar.items {
            let showsItem = items[0]
            showsItem.title = "Shows"
            showsItem.image = UIImage(named: "show")
            let favoritesItem = items[1]
            favoritesItem.title = "Favorites"
            favoritesItem.image = UIImage(named: "heart")
        }
    }
    
    private func getShowsFromDB() {
        if let shows = CoreDataStack.read() {
            self.shows = shows
            self.showsCollectionView.reloadData()
        }
    }
    
    private func getShowsFromAPI() {
        ApiHelper.getShows { (shows) in
            self.shows = shows
            self.showsCollectionView.reloadData()
        }
    }
    
    private func searchShows(forSearchText searchText: String) {
        if let tabBarController = tabBarController {
            tabBarController.selectedIndex == 0 ?  getShowsFromAPI(forSearchWord: searchText): getShowsFromDB(forSearchWord: searchText)
        }
        
    }
    
    private func getShowsFromAPI(forSearchWord word: String) {
        ApiHelper.getShows(forSearchWord: word) { (shows) in
            self.shows = shows
            self.showsCollectionView.reloadData()
        }
    }
    private func getShowsFromDB(forSearchWord word: String) {
        if let showsFromDB = CoreDataStack.read(withName: word) {
            self.shows = showsFromDB
            self.showsCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,
            let navigationController = segue.destination as? UINavigationController,
            let detailViewController = navigationController.viewControllers.first as? DetailShowViewController,
            let show = sender as? Show, identifier == "goToDetailView" {
            
            detailViewController.show = show
        }
    }
    
}

// MARK: - UICollectionViewDelegate
extension ShowsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetailView", sender: shows[indexPath.row])
    }
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
        if let tabBarController = tabBarController {
            if searchText == "" {
                tabBarController.selectedIndex == 0 ? getShowsFromAPI() : getShowsFromDB()
            } else {
                searchShows(forSearchText: searchText)
            }
        }
    }
}
