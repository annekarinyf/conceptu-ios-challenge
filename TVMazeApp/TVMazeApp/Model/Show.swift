//
//  Show.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 15/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class Show {
    
    var name: String
    var imageUrl: String
    var image: UIImage?
    
    init?(json: JSON) {
        guard let name = json["name"] as? String,
        let imageJson = json["image"] as? JSON,
        let imageUrl = imageJson["medium"] as? String else { return nil }
        
        self.name = name
        self.imageUrl = imageUrl
    }

}
