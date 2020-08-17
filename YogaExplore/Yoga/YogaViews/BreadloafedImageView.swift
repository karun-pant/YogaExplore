//
//  BreadloafedImageView.swift
//  YogaExplore
//
//  Created by Karun Pant on 17/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

class BreadLoafedImageView: UIView {
    let imageView: UIImageView
    let size: CGSize
    
    init(image: UIImage?, size: CGSize) {
        self.size = size
        imageView = UIImageView(image: image)
        super.init(frame: .zero)
        setupImageView(image: image)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupImageView(image: UIImage?) {
        clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        layer.cornerRadius = size.width * 0.125
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
