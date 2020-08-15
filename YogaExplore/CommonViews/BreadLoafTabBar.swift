//
//  BreadLoafTabBar.swift
//  YogaExplore
//
//  Created by Karun Pant on 13/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class BreadLoafTabBar: UIView {
    var onItemTap: ((_ tab: Int) -> ())?
    private var tabsStackView: UIStackView = UIStackView()
    private var activeItem: TabItem?
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    convenience init(_ tabItems: [TabItem], frame: CGRect) {
        self.init(frame: frame)
        layer.backgroundColor = UIColor.clear.cgColor
        setupTabbar(tabItems, frame: frame)
    }
    
    private func setupTabbar(_ tabItems: [TabItem], frame: CGRect) {
        let breadLoafView = breadLoafedView()
        addSubview(breadLoafView)
        tabsStackView.translatesAutoresizingMaskIntoConstraints = false
        tabsStackView.axis = .horizontal
        tabsStackView.spacing = 8
        tabsStackView.distribution = .fillEqually
        tabsStackView.backgroundColor = .red
        tabItems.enumerated().forEach {
            let tabBarItemView = TabBarItemView(item: $0.element, onTap: handleItemTap)
            tabBarItemView.tag = $0.offset
            tabsStackView.addArrangedSubview(tabBarItemView)
        }
        breadLoafView.addSubview(tabsStackView)
        NSLayoutConstraint.activate([
            tabsStackView.leadingAnchor.constraint(equalTo: breadLoafView.leadingAnchor, constant: 10),
            tabsStackView.trailingAnchor.constraint(equalTo: breadLoafView.trailingAnchor, constant: -10),
//            tabsStackView.topAnchor.constraint(equalTo: breadLoafView.topAnchor, constant: 10),
            tabsStackView.centerYAnchor.constraint(equalTo: breadLoafView.centerYAnchor),
            tabsStackView.heightAnchor.constraint(equalToConstant: TabBarItemView.itemHeight)
        ])
        activeItem = tabItems.first(where: { $0.isSelected })
    }
    
    func handleItemTap(item: TabItem) {
        guard let activeItem = activeItem else {
            assertionFailure("activeItem is not found, now why would taht be. Did you not set it 🤔")
            return
        }
        switchTab(from: activeItem, to: item)
    }
    
    func switchTab(from fromItem: TabItem, to toItem: TabItem) {
        guard toItem.position != fromItem.position else {
            return
        }
        let updatedToTabItem = TabItem(item: toItem.item, isSelected: true, position: toItem.position)
        let updatedFromTabItem = TabItem(item: fromItem.item, isSelected: false, position: fromItem.position)
        guard let toItemView = tabsStackView.arrangedSubviews[safe: toItem.position] as? TabBarItemView,
            let fromItemView = tabsStackView.arrangedSubviews[safe: fromItem.position] as? TabBarItemView else {
                assertionFailure("How did this happen, did you fill something else in stack 😭")
                return
        }
        toItemView.updateView(with: updatedToTabItem)
        fromItemView.updateView(with: updatedFromTabItem)
        activeItem = toItem
        onItemTap?(toItem.position)
    }
    
    private func breadLoafedView() -> UIView {
        let maskedBreadLoafView = UIView(frame: bounds)
        maskedBreadLoafView.backgroundColor = Colors.background.color
        let radius = bounds.size.width * 0.125
        let shapePath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: .init(width: radius, height: radius))
        let shapeLayerMask = CAShapeLayer()
        shapeLayerMask.path = shapePath.cgPath
        maskedBreadLoafView.layer.mask = shapeLayerMask
        layer.shadowPath = shapePath.cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -5)
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        return maskedBreadLoafView
    }
    
}

