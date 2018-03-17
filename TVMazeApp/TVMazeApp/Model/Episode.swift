//
//  Episode.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 17/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class Episode {
    var name: String
    var number: Int
    var season: Int
    var image: UIImage?
    var imageUrl: String?
    var summary: String
    
    init?(json: JSON) {
        guard let name = json["name"] as? String,
            let number = json["number"] as? Int,
            let season = json["season"] as? Int,
            let imageJson = json["image"] as? JSON,
            let imageUrl = imageJson["medium"] as? String,
            let summary = json["summary"] as? String else { return nil }
        
        self.name = name
        self.number = number
        self.season = season
        self.imageUrl = imageUrl
        self.summary = summary
    }
}
