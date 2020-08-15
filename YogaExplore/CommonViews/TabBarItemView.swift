//
//  TabBarItemView.swift
//  YogaExplore
//
//  Created by Karun Pant on 13/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

final class TabBarItemView: UIView {
    static let itemHeight: CGFloat = 60
    private (set) var tabItem: TabItem
    private let title: UILabel
    private let icon: UIImageView
    private let onTap: (_ item: TabItem) -> Void
    
    init(item: TabItem,
         onTap: @escaping (_ item: TabItem) -> Void) {
        self.tabItem = item
        title = UILabel(frame: CGRect.zero)
        icon = UIImageView(frame: CGRect.zero)
        self.onTap = onTap
        super.init(frame: .zero)
        backgroundColor = .clear
        setupItem()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupItem() {
        title.attributedText = tabItem.item.displayTitle(isSelected: tabItem.isSelected)
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        title.clipsToBounds = true
        icon.image = tabItem.item.icon(isSelected: tabItem.isSelected)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        self.layer.backgroundColor = Colors.background.color.cgColor
        self.addSubview(icon)
        self.addSubview(title)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 23),
            icon.widthAnchor.constraint(equalToConstant: 23),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            title.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 8), // Position title label 4pts below item icon
        ])
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
    }
    
    func updateView(with tabItem: TabItem) {
        self.tabItem = tabItem
        UIView.transition(with: icon, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.icon.image = tabItem.item.icon(isSelected: tabItem.isSelected)
        })
        UIView.transition(with: title, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.title.attributedText = tabItem.item.displayTitle(isSelected: tabItem.isSelected)
        })
    }
    
    @objc private func handleTap() { onTap(tabItem) }
}
