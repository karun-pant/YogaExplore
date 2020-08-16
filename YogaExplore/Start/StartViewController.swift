//
//  StartViewController.swift
//  YogaExplore
//
//  Created by Karun Pant on 8/11/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, NavigationBarCustomizable {
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundAndDropShadow()
        transparentNavigationBar()
        addCustomBackButton(UIImage(named: "back"), tapHandler: UITapGestureRecognizer(target: self, action: #selector(handleBackTap)))
    }
    private func roundAndDropShadow() {
        let radius = startButton.frame.height/2
        startButton.layer.cornerRadius = radius
        startButton.layer.shadowColor = Colors.componentBackground.color.cgColor
        startButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        startButton.layer.shadowOpacity = 0.5
        startButton.layer.shadowRadius = 10
        
    }
    @objc private func handleBackTap() {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func onStartTap(_ sender: Any) {
        if let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabbarController") {
            self.navigationController?.pushViewController(tabBarController, animated: true)
        }
    }
}
