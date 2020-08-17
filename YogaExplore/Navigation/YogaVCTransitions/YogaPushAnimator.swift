//
//  YogaViewAnimator.swift
//  YogaExplore
//
//  Created by Karun Pant on 16/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

class YogaPushAnimator: NSObject {
    let duration: TimeInterval = 0.3
    var presenting = true
    var originFrame = CGRect.zero
}

// MARK:- UIViewControllerAnimatedTransitioning

extension YogaPushAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) as? MainTabbarController,
            let yogaViewController = toViewController.viewControllers?.first as? YogaNavigationAnimatorProtocol,
            let fromViewController = transitionContext.viewController(forKey: .from) else {
                transitionContext.completeTransition(false)
                return
        }
        // reqired views
        let topImageView = YogaNavigationAnimationHelper.makeTopImage(yogaViewController)
        let ratingsAndBookmarkView = YogaNavigationAnimationHelper.makeRatingsAndBookmarkView(yogaViewController)
        let barBackButtonView = BarBackButtonView(width: yogaViewController.view.frame.width)
        
        // required size/frame calculation
        let ratingsAndBookmarkViewSize = RatingsAndBookmarkView.Style.estimatedSize(yogaViewController.view.frame.width)
        let snapShotRect = CGRect(origin: .zero, size: topImageView.size)
        let ratingsYPos = snapShotRect.maxY - ratingsAndBookmarkViewSize.height/2
        
        // container view
        let containerView = transitionContext.containerView
        containerView.backgroundColor = Colors.background.color
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        containerView.addSubview(topImageView)
        containerView.addSubview(ratingsAndBookmarkView)
        containerView.addSubview(barBackButtonView)
        
        // constraints
        let topImageHeightConstraint = topImageView.heightAnchor.constraint(equalToConstant: 0)
        let ratingsAndBookmarkwidthConstraint = ratingsAndBookmarkView.widthAnchor.constraint(equalToConstant: ratingsAndBookmarkViewSize.width/2)
        
        NSLayoutConstraint.activate([
            // barBackButtonView
            barBackButtonView.topAnchor.constraint(equalTo: containerView.topAnchor),
            barBackButtonView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            barBackButtonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            barBackButtonView.heightAnchor.constraint(equalToConstant: barBackButtonView.frame.height),
            
            // top image
            topImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            topImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            topImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topImageHeightConstraint,
            
            // ratings and bookmark
            ratingsAndBookmarkView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ratingsYPos),
            ratingsAndBookmarkView.heightAnchor.constraint(equalToConstant: ratingsAndBookmarkViewSize.height),
            ratingsAndBookmarkView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            ratingsAndBookmarkwidthConstraint
        ])
        containerView.layoutIfNeeded()
        
        // alpha changes
        topImageView.alpha = 0
        ratingsAndBookmarkView.alpha = 0
        barBackButtonView.alpha = 0
        fromViewController.view.alpha = 1
        toViewController.view.alpha = 0
        
        // constraint changes
        ratingsAndBookmarkwidthConstraint.constant = ratingsAndBookmarkViewSize.width
        topImageHeightConstraint.constant = topImageView.size.height
        
        // Animation
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.alpha = 0
            toViewController.view.alpha = 1
            topImageView.alpha = 1
            ratingsAndBookmarkView.alpha = 1
            barBackButtonView.alpha = 1
            containerView.layoutIfNeeded()
        },completion: { _ in
            ratingsAndBookmarkView.removeFromSuperview()
            barBackButtonView.removeFromSuperview()
            topImageView.removeFromSuperview()
            fromViewController.view.removeFromSuperview()
            yogaViewController.didCompletePushTransition()
            transitionContext.completeTransition(true)
        })
    }
}
