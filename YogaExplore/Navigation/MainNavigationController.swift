//
//  MainNavigationController.swift
//  YogaExplore
//
//  Created by Karun Pant on 15/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController, NavigationBarCustomizable {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension MainNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .push:
            return YogaPushAnimator()
        case .pop:
            return YogaPopAnimator()
        default:
            return nil
        }
    }
}
