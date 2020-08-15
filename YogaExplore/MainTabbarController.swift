//
//  MainTabbarController.swift
//  YogaExplore
//
//  Created by Karun Pant on 8/11/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController, NavigationBarCustomizable {
    private var customTabBar: BreadLoafTabBar!
    private let tabBarHeight: CGFloat = 90
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTabBar { viewControllers in
            self.viewControllers = viewControllers
        }
        transparentNavigationBar()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func loadTabBar(_ completion: ([UIViewController]) -> Void){
        var viewControllers = [UIViewController]()
        var tabItems = [TabItem]()
        TabItem.Item.allCases.enumerated().forEach {
            let tabItem = TabItem(item: $0.element, isSelected: $0.offset == 0, position: $0.offset)
            viewControllers.append(tabItem.item.viewController)
            tabItems.append(tabItem)
        }
        tabBar.barTintColor = .clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        let frame = CGRect(origin: tabBar.frame.origin, size: .init(width: tabBar.frame.width, height: tabBarHeight))
        customTabBar = BreadLoafTabBar(tabItems, frame: frame)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.onItemTap = changeTab
        view.addSubview(customTabBar)
        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.layoutIfNeeded()
        self.selectedIndex = 0
        completion(viewControllers)
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}
