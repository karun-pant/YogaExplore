//
//  SeeReviewsTapableView.swift
//  YogaExplore
//
//  Created by Karun Pant on 15/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class SeeReviewsTapableView: UIView {
    private let onTap: () -> ()
    init(onTap: @escaping ()->()) {
        self.onTap = onTap
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        let pencilImageView = UIImageView(image: UIImage(named: "pencil"))
        pencilImageView.translatesAutoresizingMaskIntoConstraints = false
        pencilImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        pencilImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        let title = UILabel()
        title.font = UbuntuFont.medium.sized(size: 20)
        title.text = "Reviews"
        title.textColor = Colors.componentBackground.color
        let stackView = UIStackView(arrangedSubviews: [pencilImageView, title])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    @objc private func handleTap() {
        onTap()
    }
}
