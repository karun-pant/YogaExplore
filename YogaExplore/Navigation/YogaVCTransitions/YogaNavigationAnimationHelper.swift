//
//  YogaNavigationAnimationHelper.swift
//  YogaExplore
//
//  Created by Karun Pant on 16/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

struct YogaNavigationAnimationHelper {
    static func makeTopImage(_ vc: YogaTransitionAnimatable) -> BreadloafedImageView {
        let topImageView = vc.topImageView
        let copyImageView = BreadloafedImageView(image: topImageView.imageView.image,
                                                 size: topImageView.size)
        copyImageView.translatesAutoresizingMaskIntoConstraints = false
        return copyImageView
    }
    static func makeRatingsAndBookmarkView(_ vc: YogaTransitionAnimatable) -> UIView {
        let view = RatingsAndBookmarkView(rating: vc.ratingsAndBookmarkView.rating,
                                          isBookmarked: vc.ratingsAndBookmarkView.isBookmarked)
        view.capsuleAndDropShadow(boundingWidth: vc.view.frame.width, isShadowNeeded: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
