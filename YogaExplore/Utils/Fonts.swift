//
//  Fonts.swift
//  YogaExplore
//
//  Created by Karun Pant on 14/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

enum UbuntuFont: String {
    case bold = "Ubuntu-Bold"
    case medium = "Ubuntu-Medium"
    case regular = "Ubuntu-Regular"
    func sized(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: self.rawValue, size: size) else {
            assertionFailure("Font with name \(self.rawValue) not found")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
