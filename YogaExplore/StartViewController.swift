//
//  StartViewController.swift
//  YogaExplore
//
//  Created by Karun Pant on 8/11/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, NavigationBarCustomizable {

    @IBOutlet weak var btnStart: UIButton! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStart.roundedCapsule()
        transparentNavigationBar()
        addCustomBackButton(UIImage(named: "back"), tapHandler: UITapGestureRecognizer(target: self, action: #selector(handleBackTap)))
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
