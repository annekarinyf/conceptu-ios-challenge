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
    var showViewModel: ShowViewModel?
    var seasonViewModel: SeasonViewModel?
    
    @IBOutlet var showPoster: UIImageView!
    @IBOutlet var detailsTableView: UITableView!
    @IBOutlet var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let show = show {
            showViewModel = ShowViewModel(show: show)
            checkImages()
            getSeasons(fromShow: show, { (finished) in
                if finished {
                    self.getEpisodes(fromShow: show)
                }
            })
        }
    }
    
    private func getSeasons(fromShow show: Show, _ completion: @escaping (_ finished: Bool) -> Void) {
        ApiHelper.getSeasons(forShowId: show.id) { (seasons) in
            if let _ = self.show {
                self.show?.seasons = seasons
                self.detailsTableView.reloadData()
                completion(true)
            }
        }
    }
    
    private func getEpisodes(fromShow show: Show) {
        ApiHelper.getEpisodes(forShowId: show.id) { (episodes) in
            if let _ = self.show {
                for season in show.seasons {
                    for episode in episodes {
                        if season.number == episode.season {
                            season.episodes.append(episode)
                        }
                    }
                }
                self.detailsTableView.reloadData()
            }
        }
    }
    
    private func checkImages() {
        if let show = show, let image = show.image {
            showPoster.image = image
        } else {
            showViewModel?.getImage({ (image) in
                self.showPoster.image = image
            })
        }
    
        if let show = show, let _ = CoreDataStack.read(withId: show.id) {
            favoriteButton.setBackgroundImage(UIImage(named: "favorite-heart"), for: .normal)
        }
    }
    
    @IBAction func favoriteShow(_ sender: UIButton) {
        guard let show = show else { return }
        
        if let _ = CoreDataStack.read(withId: show.id) {
            CoreDataStack.delete(withId: show.id)
            favoriteButton.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        } else {
            CoreDataStack.save(show)
            favoriteButton.setBackgroundImage(UIImage(named: "favorite-heart"), for: .normal)
        }
    }
    
    
    @IBAction func dismissDetailView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "goToDetailEpisode" {
                if let detailEpisodeViewController = segue.destination as? DetailEpisodeViewController, let episode = sender as? Episode {
                    detailEpisodeViewController.episode = episode
                }
            }
        }
    }
}

extension DetailShowViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = show, let seasons = show?.seasons {
            return seasons.count+1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section != 0 {
            if let _ = show, let season = show?.seasons[section-1] {
                seasonViewModel = SeasonViewModel(season: season)
                if let seasonViewModel = seasonViewModel {
                    return seasonViewModel.description
                } else {
                    return nil
                }
            }
        } else {
            return nil
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let show = show {
             performSegue(withIdentifier: "goToDetailEpisode", sender: show.seasons[indexPath.section-1].episodes[indexPath.row])
        }
    }
}

extension DetailShowViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            if let show = show {
                for season in show.seasons {
                    if section == season.number {
                        return season.episodes.count
                    }
                }
            }
            return 0
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
            if let show = show {
                let season = show.seasons[indexPath.section-1]
                let episode = season.episodes[indexPath.row]
                cell.textLabel?.text = episode.name
            }
        }
         return cell
    }
}
