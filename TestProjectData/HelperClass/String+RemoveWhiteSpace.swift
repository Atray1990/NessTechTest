//
//  ImageView+Svg.swift
//  TestProjectData
//
//  Created by shashank atray on 15/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import Foundation

public extension String {
    
    func removingAllWhitespaces() -> String {
        return removingCharacters(from: .whitespaces)
    }

    func removingCharacters(from set: CharacterSet) -> String {
        var newString = self
        newString.removeAll { char -> Bool in
            guard let scalar = char.unicodeScalars.first else { return false }
            return set.contains(scalar)
        }
        return newString
    }
}
