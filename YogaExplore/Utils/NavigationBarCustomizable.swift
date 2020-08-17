//
//  TransparentNavigationBar.swift
//  YogaExplore
//
//  Created by Karun Pant on 15/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

protocol NavigationBarCustomizable: UIViewController {
    func transparentNavigationBar()
}

extension NavigationBarCustomizable {
    public func transparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.backgroundColor = .clear
    }
}
