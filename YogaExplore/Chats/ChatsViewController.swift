//
//  ChatsViewController.swift
//  YogaExplore
//
//  Created by Karun Pant on 8/11/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {

    @IBOutlet var pageName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageName.text = self.title
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

}

