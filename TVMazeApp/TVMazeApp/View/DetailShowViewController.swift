//
//  DetailShowViewController.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 17/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import UIKit

class DetailShowViewController: UIViewController {
    
    var show: Show?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let show = show {
            print(show.name)
        }
    }
}
