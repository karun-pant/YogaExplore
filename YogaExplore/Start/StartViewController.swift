//
//  StartViewController.swift
//  YogaExplore
//
//  Created by Karun Pant on 8/11/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, NavigationBarCustomizable {
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transparentNavigationBar()
        roundCornersAndDropShadow()
    }
    private func roundCornersAndDropShadow() {
        let radius = startButton.frame.height/2
        startButton.layer.cornerRadius = radius
        startButton.layer.shadowColor = Colors.componentBackground.color.cgColor
        startButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        startButton.layer.shadowOpacity = 0.5
        startButton.layer.shadowRadius = 10
    }
    @IBAction func onStartTap(_ sender: Any) {
        if let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabbarController") {
            self.navigationController?.pushViewController(tabBarController, animated: true)
        }
    }
}
