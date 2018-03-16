//
//  ShowViewModel.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 15/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class ShowViewModel {
    
    let name: String
    var image: UIImage?
    
    private var show: Show
    
    init(show: Show) {
        self.show = show
        self.name = ShowViewModel.getFormattedName(from: show)
    }
    
    private static func getFormattedName(from show: Show) -> String {
        return show.name
    }
    
    func getImage(_ completion: @escaping (UIImage?)->Void) {
        
        if let image = show.image {
            completion(image)
        } else {
            UrlHelper.downloadImage(withURL: show.imageUrl) { (image) in
                self.show.image = image
                completion(image)
            }
        }
    }
    
}
