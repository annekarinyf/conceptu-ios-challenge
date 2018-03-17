//
//  ApiHelper.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 15/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import Foundation
import Alamofire

public typealias JSON = [String: Any]

class ApiHelper {
    private static let baseUrl = "https://api.tvmaze.com"
    
    // MARK: - Shows Requests
    static func getShows(_ completion: @escaping (_ shows: [Show]) -> Void) {
        let url = "\(baseUrl)/shows"
        
        Alamofire.request(url).responseJSON { (response) -> Void in
            if let showsJson = response.result.value as? [JSON] {
                completion(showsJson.flatMap { Show(json: $0) })
            } else {
                completion([])
            }
        }
    }
    
    static func getShows(forSearchWords searchWord: String, _ completion: @escaping (_ shows: [Show]) -> Void) {
        let url = "\(baseUrl)/search/shows?q=\(searchWord)"

        Alamofire.request(url).responseJSON { (response) -> Void in
            if let showsJson = response.result.value as? [JSON] {
                completion(showsJson.flatMap { $0["show"] as? JSON }.flatMap { Show(json: $0) })
            } else {
                completion([])
            }
        }
    }
    
    // MARK: - Season Requests
    static func getSeasons(forShowId id: Int, _ completion: @escaping (_ seasons: [Season]) -> Void) {
        let url = "\(baseUrl)/shows/\(id)/seasons"
        
        Alamofire.request(url).responseJSON { (response) -> Void in
            if let seasonsJson = response.result.value as? [JSON] {
                completion(seasonsJson.flatMap { Season(json: $0) })
            } else {
                completion([])
            }
        }
    }
    
    // MARK: - Episodes Requests
    static func getEpisodes(forShowId id: Int, _ completion: @escaping (_ episodes: [Episode]) -> Void) {
        let url = "\(baseUrl)/shows/\(id)/episodes"
        
        Alamofire.request(url).responseJSON { (response) -> Void in
            if let episodesJson = response.result.value as? [JSON] {
                completion(episodesJson.flatMap { Episode(json: $0) })
            } else {
                completion([])
            }
        }
    }
    
}
