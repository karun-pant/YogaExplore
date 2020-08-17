//
//  BreadloafedImageView.swift
//  YogaExplore
//
//  Created by Karun Pant on 17/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class BreadLoafedImageView: UIView {
    let imageView: UIImageView
    let size: CGSize
    
    init(image: UIImage?, size: CGSize) {
        self.size = size
        imageView = UIImageView(image: image)
        super.init(frame: .zero)
        contentMode = .redraw
        setupImageView(image: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupImageView(image: UIImage?) {
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func draw(_ rect: CGRect) {
        let radius = frame.size.width * 0.125
        let shapePath = UIBezierPath(roundedRect: frame, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: .init(width: radius, height: radius))
        let shapeLayerMask = CAShapeLayer()
        shapeLayerMask.path = shapePath.cgPath
        layer.mask = shapeLayerMask
        layer.masksToBounds = true
    }
}
