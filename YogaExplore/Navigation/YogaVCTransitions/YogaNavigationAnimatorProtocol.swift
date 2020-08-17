//
//  YogaNavigationAnimatorProtocol.swift
//  YogaExplore
//
//  Created by Karun Pant on 16/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

/// This protocol is compulsory for Yoga push and pop transitions to work, those transition can only be applied to VCs conforming to this.
protocol YogaNavigationAnimatorProtocol: UIViewController {
    var topImageView: BreadLoafedImageView { get }
    var ratingsAndBookmarkView: RatingsAndBookmarkView { get }
    func didCompletePushTransition()
}
