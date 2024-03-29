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
    var exhibitionDayAndTime: String
    var genres: String
    var summary: String
    private var show: Show
    
    init(show: Show) {
        self.show = show
        self.name = show.name
        self.exhibitionDayAndTime = ShowViewModel.getExhibitionDayAndTime(from: show)
        self.genres = ShowViewModel.getGenresString(from: show)
        self.summary = ShowViewModel.getFormattedSummary(from: show)
    }
    
    private static func getExhibitionDayAndTime(from show: Show) -> String {
        let days = show.days.joined(separator: ", ")
        return "The show in on \(days) at \(show.time)"
    }
    
    private static func getGenresString(from show: Show) -> String {
        let genders = show.genres.joined(separator: ", ")
        return "Genders: \(genders)"
    }
    
    private static func getFormattedSummary(from show: Show) -> String {
        let formattedSummary = show.summary.removing(strings: ["<p>", "</p>", "<b>", "</b>"], toPut: "")
        return formattedSummary
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
