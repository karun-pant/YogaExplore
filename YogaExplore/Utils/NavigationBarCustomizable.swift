//
//  TransparentNavigationBar.swift
//  YogaExplore
//
//  Created by Karun Pant on 15/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

protocol NavigationBarCustomizable: UIViewController {
    func transparentNavigationBar()
    func addCustomBackButton(_ image: UIImage?, tapHandler backTap: UITapGestureRecognizer)
}
extension NavigationBarCustomizable {
    public func transparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.backgroundColor = .clear
    }
    func addCustomBackButton(_ image: UIImage?, tapHandler backTap: UITapGestureRecognizer) {
        self.navigationItem.hidesBackButton = true
        let backButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.frame = CGRect(x: 10, y: 20, width: 20, height: 20)
        backButtonView.addSubview(imageView)
        backButtonView.addGestureRecognizer(backTap)
        let backButton = UIBarButtonItem(customView: backButtonView)
        self.navigationItem.leftBarButtonItem = backButton
    }
}
