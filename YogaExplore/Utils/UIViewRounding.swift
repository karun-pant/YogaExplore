//
//  UIViewRounding.swift
//  YogaExplore
//
//  Created by Karun Pant on 8/11/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

extension UIView {
    func roundedCapsule() {
        let cornerRadius = self.frame.height/2
        layer.cornerRadius = cornerRadius
    }
}
