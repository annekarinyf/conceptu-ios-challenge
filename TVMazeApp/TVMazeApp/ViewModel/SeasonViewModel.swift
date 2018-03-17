//
//  SeasonViewModel.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 17/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class SeasonViewModel {
    
    let description: String
    private var season: Season
    
    init(season: Season) {
        self.season = season
        self.description = SeasonViewModel.getDescription(from: season)
    }
    
    private static func getDescription(from season: Season) -> String {
        if season.name != "" {
            return "Season \(season.number): \(season.name)"
        } else {
            return "Season \(season.number)"
        }
    }
}
