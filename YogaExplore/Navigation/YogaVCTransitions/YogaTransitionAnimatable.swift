//
//  YogaTransitionAnimatable.swift
//  YogaExplore
//
//  Created by Karun Pant on 16/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

protocol YogaTransitionAnimatable: UIViewController {
    var topImageView: UIImageView { get }
    var ratingsAndBookmarkView: RatingsAndBookmarkView { get }
    func didCompletePushTransition()
}
