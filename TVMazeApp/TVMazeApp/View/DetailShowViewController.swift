//
//  DetailShowViewController.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 17/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class DetailShowViewController: UIViewController {
    
    var show: Show?
    var seasons = [Season]()
    var showViewModel: ShowViewModel?
    
    @IBOutlet var showPoster: UIImageView!
    @IBOutlet var detailsTableView: UITableView!
    @IBOutlet var favoriteShowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let show = show {
            showViewModel = ShowViewModel(show: show)
            checkImage()
            getSeasons(fromShowId: show.id)
        }
    }
    
    private func getSeasons(fromShowId id: Int) {
        ApiHelper.getSeasons(forShowId: id) { (seasons) in
            self.seasons = seasons
            self.detailsTableView.reloadData()
        }
    }
    
    private func checkImage() {
        if let show = show, let image = show.image {
            showPoster.image = image
        } else {
            showViewModel?.getImage({ (image) in
                self.showPoster.image = image
            })
        }
    }
    
    @IBAction func dismissDetailView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailShowViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Seasons"
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension DetailShowViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return seasons.count
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        guard let showViewModel = showViewModel else { return cell }
        
        if indexPath.section == 0 {
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = showViewModel.name
            case 1:
                cell.textLabel?.text = showViewModel.exibitionDayAndTime
            case 2:
                cell.textLabel?.text = showViewModel.genders
            default:
                cell.textLabel?.text = showViewModel.summary
            }
        } else {
            cell.selectionStyle = UITableViewCellSelectionStyle.default
            
            let seasonViewModel = SeasonViewModel(season: seasons[indexPath.row])
            cell.textLabel?.text = seasonViewModel.description
        }
         return cell
    }
}
