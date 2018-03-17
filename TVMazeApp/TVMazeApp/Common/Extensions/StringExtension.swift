//
//  StringExtension.swift
//  TVMazeApp
//
//  Created by Anne Kariny Silva Freitas on 17/03/2018.
//  Copyright © 2018 Anne Kariny Silva Freitas. All rights reserved.
//

import Foundation

extension String {
    func removing(strings: [String], toPut replacingString: String = "") -> String {
        var mutableString = self
        
        for string in strings {
            mutableString = mutableString.replacingOccurrences(of: string, with: replacingString)
        }
        
        return mutableString
    }
}
