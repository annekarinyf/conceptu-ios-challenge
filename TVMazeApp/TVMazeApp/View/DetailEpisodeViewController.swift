//
//  DetailEpisodeViewController.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 18/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class DetailEpisodeViewController: UIViewController {
    
    var episode: Episode?
    
    @IBOutlet var episodeImage: UIImageView!
    @IBOutlet var detailEpisodeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkImage()
    }
    
    private func checkImage(){
        if let episode = episode, let imageUrl = episode.imageUrl, imageUrl != "" {
            UrlHelper.downloadImage(withURL: imageUrl, completion: { (image) in
                self.episodeImage.image = image
            })
        }
    }
}

extension DetailEpisodeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension DetailEpisodeViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailEpisode", for: indexPath)
        guard let episode = episode else { return cell}
        let episodeViewModel =  EpisodeViewModel(episode: episode)
        
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = episodeViewModel.name
        case 1:
            cell.textLabel?.text = episodeViewModel.number
        case 2:
            cell.textLabel?.text = episodeViewModel.season
        case 3:
            cell.textLabel?.text = episodeViewModel.summary
        default:
            cell.textLabel?.text = ""
        }
        return cell
    }
}
