//
//  ImageViewRoundable.swift
//  YogaExplore
//
//  Created by Karun Pant on 16/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

extension UIImageView {
    func breadloafed() {
        let size = frame.size
        let radius = size.width * 0.125
        let shapePath = UIBezierPath(roundedRect: .init(origin: .zero, size: size),
                                     byRoundingCorners: [.bottomLeft, .bottomRight],
                                     cornerRadii: .init(width: radius, height: radius))
        let shapeLayerMask = CAShapeLayer()
        shapeLayerMask.path = shapePath.cgPath
        layer.mask = shapeLayerMask
        layer.masksToBounds = true
    }
}
