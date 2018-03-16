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
    static func getShows(_ completion: @escaping (_ products: [Show]) -> Void) {
        let url = "\(baseUrl)/shows"
        
        Alamofire.request(url).responseJSON { (response) -> Void in
            if let showsJson = response.result.value as? [JSON] {
                completion(showsJson.flatMap { Show(json: $0) })
            } else {
                completion([])
            }
        }
    }
    
}
