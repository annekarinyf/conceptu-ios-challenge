//
//  Show.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 15/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class Show {
    
    var id: Int
    var name: String
    var imageUrl: String
    var image: UIImage?
    var time: String
    var days: [String]
    var genres: [String]
    var summary: String
    var seasons = [Season]()
    
    init?(json: JSON) {
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let imageJson = json["image"] as? JSON,
            let imageUrl = imageJson["medium"] as? String,
            let schedule = json["schedule"] as? JSON,
            let time = schedule["time"] as? String,
            let days = schedule["days"] as? [String],
            let genres = json["genres"] as? [String],
            let summary = json["summary"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.time = time
        self.days = days
        self.genres = genres
        self.summary = summary
    }
    
    init(id: Int, name: String, imageUrl: String, time: String, days: [String], genres: [String], summary: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.time = time
        self.days = days
        self.genres = genres
        self.summary = summary
    }
}
