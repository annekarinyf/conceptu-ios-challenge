//
//  Season.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 17/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class Season {
    var id: Int
    var number: Int
    var name: String
    
    init?(json: JSON) {
        guard let id = json["id"] as? Int,
            let number = json["number"] as? Int,
            let name = json["name"] as? String else { return nil }
        
        self.id = id
        self.number = number
        self.name = name
    }
}
