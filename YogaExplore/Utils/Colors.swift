//
//  Colors.swift
//  YogaExplore
//
//  Created by Karun Pant on 14/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

enum Colors: String {
    case background = "background"
    case componentBackground = "componentBackground"
    case mainText = "mainText"
    case secondaryText = "secondaryText"
    case tertiaryText = "tertiaryText"
    var color: UIColor {
        guard let color = UIColor(named: rawValue) else {
            assertionFailure("Hey did you removed or renamed \(rawValue) color in Colors.xcassets")
            return UIColor.clear
        }
        return color
    }
}
