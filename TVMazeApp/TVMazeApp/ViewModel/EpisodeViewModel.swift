//
//  EpisodeViewModel.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 18/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class EpisodeViewModel {
    
    let name: String
    var number: String
    var season: String
    var summary: String
    var image: UIImage?
    private var episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
        self.name = episode.name
        self.number = EpisodeViewModel.getFormattedNumber(from: episode)
        self.season = EpisodeViewModel.getFormattedSeason(from: episode)
        self.summary = EpisodeViewModel.getFormattedSummary(from: episode)
    }
    
    private static func getFormattedNumber(from episode: Episode) -> String {
        return "Episode #\(episode.number)"
    }
    
    private static func getFormattedSeason(from episode: Episode) -> String {
        return "Season \(episode.season)"
    }
    
    private static func getFormattedSummary(from episode: Episode) -> String {
        let formattedSummary = episode.summary.removing(strings: ["<p>", "</p>", "<b>", "</b>"], toPut: "")
        return formattedSummary
    }
    
    
    
}
