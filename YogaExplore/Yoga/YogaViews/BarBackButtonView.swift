//
//  BarBackButtonView.swift
//  YogaExplore
//
//  Created by Karun Pant on 16/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

class BarBackButtonView: UIView {
    
    var onBackTap: (() -> Void)?
    
    init(width: CGFloat) {
        let gradientViewSize: CGSize = .init(width: width,
                                             height: 120)
        super.init(frame: .init(origin: .zero, size: gradientViewSize))
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let layerView = UIView(frame: frame)
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor(white: 0, alpha: 0.70).cgColor, UIColor.clear]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = frame
        layerView.layer.insertSublayer(gradient, at: 1)
        addSubview(layerView)
        let backButtonView = UIView(frame: .zero)
        let backImageView = UIImageView(image: UIImage(named: "back"))
        backImageView.contentMode = .scaleAspectFit
        backButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        backButtonView.addSubview(backImageView)
        addSubview(backButtonView)
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backButtonView.translatesAutoresizingMaskIntoConstraints = false
        layerView.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backImageView.heightAnchor.constraint(equalToConstant: 25),
            backImageView.widthAnchor.constraint(equalToConstant: 25),
            backImageView.centerXAnchor.constraint(equalTo: backButtonView.centerXAnchor),
            backImageView.bottomAnchor.constraint(equalTo: backButtonView.bottomAnchor),
            backButtonView.heightAnchor.constraint(equalToConstant: 50),
            backButtonView.widthAnchor.constraint(equalToConstant: 50),
            backButtonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButtonView.topAnchor.constraint(equalTo: topAnchor, constant: 35),
            // layer view
            layerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            layerView.trailingAnchor.constraint(equalTo: leadingAnchor),
            layerView.topAnchor.constraint(equalTo: topAnchor),
            layerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func handleBack() {
        onBackTap?()
    }
}
