//
//  YogaPopAnimator.swift
//  YogaExplore
//
//  Created by Karun Pant on 16/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class YogaPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 5
    var presenting = true
    var originFrame = CGRect.zero
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? MainTabbarController,
            let yogaViewController = fromViewController.viewControllers?.first as? YogaTransitionAnimatable,
            let toViewController = transitionContext.viewController(forKey: .to) else {
                transitionContext.completeTransition(false)
                return
        }
        
        // reqired views
        let topImageView = YogaNavigationAnimationHelper.makeTopImage(yogaViewController)
        let snapshotRatingsAndBookmarkView = YogaNavigationAnimationHelper.makeRatingsAndBookmarkView(yogaViewController)
        let barBackButtonView = BarBackButtonView(width: yogaViewController.view.frame.width)
        
        // required size/frame calculation
        let ratingsAndBookmarkViewSize = RatingsAndBookmarkView.Style.estimatedSize(yogaViewController.view.frame.width)
        let snapShotRect = CGRect(origin: .zero, size: topImageView.size)
        let ratingsYPos = snapShotRect.maxY - ratingsAndBookmarkViewSize.height/2
        
        // container view
        let containerView = transitionContext.containerView
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        containerView.addSubview(topImageView)
        containerView.addSubview(snapshotRatingsAndBookmarkView)
        containerView.addSubview(barBackButtonView)
        
        // constraints
        let topImageHeightConstraint = topImageView.heightAnchor.constraint(equalToConstant: topImageView.size.height)
        let ratingsAndBookmarkwidthConstraint = snapshotRatingsAndBookmarkView.widthAnchor.constraint(equalToConstant: ratingsAndBookmarkViewSize.width)
        
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
            snapshotRatingsAndBookmarkView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ratingsYPos),
            snapshotRatingsAndBookmarkView.heightAnchor.constraint(equalToConstant: ratingsAndBookmarkViewSize.height),
            snapshotRatingsAndBookmarkView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            ratingsAndBookmarkwidthConstraint
        ])
        containerView.layoutIfNeeded()
        
        // alpha changes
        topImageView.alpha = 1
        snapshotRatingsAndBookmarkView.alpha = 1
        barBackButtonView.alpha = 1
        toViewController.view.alpha = 0
        fromViewController.view.alpha = 1
        
        // constraint changes
        ratingsAndBookmarkwidthConstraint.constant = ratingsAndBookmarkViewSize.width/2
        topImageHeightConstraint.constant = 0
        
        // Animation
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.alpha = 0
            toViewController.view.alpha = 1
            topImageView.alpha = 0
            snapshotRatingsAndBookmarkView.alpha = 0
            barBackButtonView.alpha = 0
            containerView.layoutIfNeeded()
        },completion: { _ in
            snapshotRatingsAndBookmarkView.removeFromSuperview()
            barBackButtonView.removeFromSuperview()
            topImageView.removeFromSuperview()
            fromViewController.view.removeFromSuperview()
            yogaViewController.didCompletePushTransition()
            transitionContext.completeTransition(true)
        })
    }
}
