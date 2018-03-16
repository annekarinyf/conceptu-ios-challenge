//
//  UrlHelper.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 15/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class UrlHelper {
    
    static func downloadImage(withURL imageURL: String, completion: @escaping (UIImage?)->Void) {
        let imageDownloadQueue = DispatchQueue(label: "tvmazeapp.imageDownload", qos: .userInitiated)
        let safeImageUrl = imageURL.replacingOccurrences(of: "http:", with: "https:") //Includes 's' on the http from url to a secure request
        
        imageDownloadQueue.async {
            if let url = URL(string: safeImageUrl) {
                do {
                    let data = try Data(contentsOf: url)
                    
                    DispatchQueue.main.sync {
                        completion(UIImage(data: data))
                    }
                } catch {
                    print("Error trying to download image from internet")
                    completion(nil)
                }
            }
        }
    }
}
