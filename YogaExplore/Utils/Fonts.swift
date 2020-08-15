//
//  Fonts.swift
//  YogaExplore
//
//  Created by Karun Pant on 14/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

enum UbuntuFont: String {
    case bold = "Ubuntu-Bold"
    case medium = "Ubuntu-Medium"
    case regular = "Ubuntu-Regular"
    func sized(size: CGFloat) -> UIFont {
//        print("Ubuntu Fonts: \(UIFont.fontNames(forFamilyName: "Ubuntu"))")
        guard let font = UIFont(name: self.rawValue, size: size) else {
            assertionFailure("Font with name \(self.rawValue) not found")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
