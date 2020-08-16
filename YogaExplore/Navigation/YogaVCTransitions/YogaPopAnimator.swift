//
//  YogaPopAnimator.swift
//  YogaExplore
//
//  Created by Karun Pant on 16/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class YogaPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 0.3
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
        let snapshotTopImageView = YogaNavigationAnimationHelper.makeTopImage(yogaViewController)
        let snapshotRatingsAndBookmarkView = YogaNavigationAnimationHelper.makeRatingsAndBookmarkView(yogaViewController)
        let ratingsAndBookmarkViewSize = RatingsAndBookmarkView.Style.estimatedSize(yogaViewController.view.frame.width)
        let barBackButtonView = BarBackButtonView(width: yogaViewController.view.frame.width)
        
        // hide rating and top image
        yogaViewController.topImageView.isHidden = true
        yogaViewController.ratingsAndBookmarkView.isHidden = true
        // container view
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(snapshotTopImageView)
        containerView.addSubview(snapshotRatingsAndBookmarkView)
        containerView.addSubview(barBackButtonView)
        
        // constraints
        let topImageTopConstraint = snapshotTopImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0)
        let topImageWidthConstraint = snapshotTopImageView.widthAnchor.constraint(equalToConstant: snapshotTopImageView.frame.width)
        let widthConstraint = snapshotRatingsAndBookmarkView.widthAnchor.constraint(equalToConstant: ratingsAndBookmarkViewSize.width)
        let ratingsTopFromContainerTop = snapshotTopImageView.frame.maxY - ratingsAndBookmarkViewSize.height/2
        NSLayoutConstraint.activate([
            // barBackButtonView
            barBackButtonView.topAnchor.constraint(equalTo: containerView.topAnchor),
            barBackButtonView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            barBackButtonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            barBackButtonView.heightAnchor.constraint(equalToConstant: barBackButtonView.frame.height),
            // top image
            topImageTopConstraint,
            snapshotTopImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            topImageWidthConstraint,
            snapshotTopImageView.heightAnchor.constraint(equalToConstant: snapshotTopImageView.frame.height),
            
            // ratings and bookmark
            snapshotRatingsAndBookmarkView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ratingsTopFromContainerTop),
            snapshotRatingsAndBookmarkView.heightAnchor.constraint(equalToConstant: ratingsAndBookmarkViewSize.height),
            snapshotRatingsAndBookmarkView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            widthConstraint
        ])
        containerView.layoutIfNeeded()
        
        // alpha changes
        snapshotTopImageView.alpha = 1
        toViewController.view.alpha = 0
        fromViewController.view.alpha = 1
        snapshotRatingsAndBookmarkView.alpha = 1
        barBackButtonView.alpha = 1
        
        // constraint changes
        topImageTopConstraint.constant = -(snapshotTopImageView.frame.height - 40)
        widthConstraint.constant = ratingsAndBookmarkViewSize.width/2
        
        // Animation
        UIView.animate(withDuration: duration, animations: {
            snapshotTopImageView.alpha = 0
            fromViewController.view.alpha = 0
            toViewController.view.alpha = 1
            snapshotRatingsAndBookmarkView.alpha = 0
            barBackButtonView.alpha = 0
            containerView.layoutIfNeeded()
        },completion: { _ in
            snapshotRatingsAndBookmarkView.removeFromSuperview()
            snapshotTopImageView.removeFromSuperview()
            barBackButtonView.removeFromSuperview()
            fromViewController.view.removeFromSuperview()
//            yogaViewController.didCompletePushTransition()
            transitionContext.completeTransition(true)
        })
    }
    private static func makeTopImage(_ vc: YogaTransitionAnimatable) -> UIView {
        let copyImageView = UIImageView(image: vc.topImageView.image)
        copyImageView.frame = vc.topImageView.frame
        copyImageView.contentMode = vc.topImageView.contentMode
        copyImageView.breadloafed()
        copyImageView.translatesAutoresizingMaskIntoConstraints = false
        return copyImageView
    }
    private static func makeRatingsAndBookmarkView(_ vc: YogaTransitionAnimatable) -> UIView {
        let view = RatingsAndBookmarkView(rating: vc.ratingsAndBookmarkView.rating,
                                          isBookmarked: vc.ratingsAndBookmarkView.isBookmarked)
        view.capsuleAndDropShadow(boundingWidth: vc.view.frame.width, isShadowNeeded: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
