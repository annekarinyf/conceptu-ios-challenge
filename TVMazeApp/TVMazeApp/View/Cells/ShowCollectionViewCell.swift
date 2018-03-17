//
//  ShowCollectionViewCell.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 15/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class ShowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var showImage: UIImageView!
    @IBOutlet var showName: UILabel!
    
    override func prepareForReuse() {
        showImage.image = nil
    }
    
    func displayContent(image: UIImage, title: String) {
        showImage.image = image
        showName.text = title
    }
}
