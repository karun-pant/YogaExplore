//
//  DescriptionView.swift
//  YogaExplore
//
//  Created by Karun Pant on 15/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class DescriptionView: UIView {
    
    let descriptionLabel: UILabel = UILabel()
    init(description: String) {
        super.init(frame: .zero)
        setupView()
        updateDescription(description: description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let titleLabel = UILabel()
        titleLabel.textColor = Colors.mainText.color
        titleLabel.font = UbuntuFont.regular.sized(size: 14)
        titleLabel.text = "Description"
        descriptionLabel.textColor = Colors.secondaryText.color
        descriptionLabel.font = UbuntuFont.regular.sized(size: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 253), for: .vertical)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        addSubview(stackView)
        
        let seperatorView = UIView(frame: .zero)
        seperatorView.backgroundColor = Colors.tertiaryText.color
        addSubview(seperatorView)
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // stackView
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            // seperatorView
            seperatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            seperatorView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func updateDescription(description: String) {
        descriptionLabel.text = description
    }
}
