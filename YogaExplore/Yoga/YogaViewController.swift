//
//  YogaViewController.swift
//  YogaExplore
//
//  Created by Karun Pant on 8/11/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit
import CoreLocation

class YogaViewController: UIViewController {
    
    lazy var topImageView: BreadLoafedImageView = {
        let topImageSize: CGSize = .init(width: view.frame.width,
                                         height: view.frame.height * 0.5 + 17)
        let topImageView = BreadLoafedImageView(image: UIImage(named: "topImage"),
                                                size: topImageSize)
        return topImageView
    }()
    let ratingsAndBookmarkView: RatingsAndBookmarkView = RatingsAndBookmarkView(rating: 5, isBookmarked: true)
    private var barBackButtonView: BarBackButtonView!
    private var addressAndLocationView: AddressAndLocationView!
    private var scheduleView: TimingsAndScheduleView!
    private var descriptionView: DescriptionView!
    private var seeReviewsView: SeeReviewsTapableView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var scrollContentView: UIView!
    private let scrollViewContentMargin: CGFloat = 20
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background.color
        scrollView.contentInsetAdjustmentBehavior = .never
        setupView()
    }
    
    private func setupView() {
        // Order of calls matter here, it's in same order as they appear in view.
        setupTopImageView()
        setupRatingsAndBookmarkView()
        setupAddressAndLocationView()
        setupScheduleView()
        setupDescriptionView()
        setupSeeReviewsButton()
        setupGradientNavigationView()
    }
    private func navigateToMapView(_ location: CLLocation?) {
        //TODO: Navigate to Mapview
    }
    private func navigateToReviews() {
        //TODO: Navigate to Reviews
    }
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK:- View setup

extension YogaViewController {
    
    private func setupGradientNavigationView() {
        barBackButtonView = BarBackButtonView(width: view.frame.width)
        barBackButtonView.onBackTap = handleBack
        view.addSubview(barBackButtonView)
        NSLayoutConstraint.activate([
            barBackButtonView.topAnchor.constraint(equalTo: view.topAnchor),
            barBackButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            barBackButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            barBackButtonView.heightAnchor.constraint(equalToConstant: barBackButtonView.frame.height)
        ])
        view.bringSubviewToFront(barBackButtonView)
        barBackButtonView.isHidden = true
    }
    
    private func setupTopImageView() {
        scrollContentView.addSubview(topImageView)
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // TopImageView
            topImageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            topImageView.heightAnchor.constraint(equalToConstant: topImageView.size.height),
            topImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor)
        ])
        topImageView.isHidden = true
    }
    
    private func setupRatingsAndBookmarkView() {
        scrollContentView.addSubview(ratingsAndBookmarkView)
        ratingsAndBookmarkView.translatesAutoresizingMaskIntoConstraints = false
        let height = RatingsAndBookmarkView.Style.estimatedSize(view.frame.width).height
        NSLayoutConstraint.activate([
            ratingsAndBookmarkView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: RatingsAndBookmarkView.Style.margin),
            ratingsAndBookmarkView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -RatingsAndBookmarkView.Style.margin),
            ratingsAndBookmarkView.heightAnchor.constraint(equalToConstant: height),
            ratingsAndBookmarkView.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: -height/2)
        ])
        ratingsAndBookmarkView.roundCornersAndDropShadow(boundingWidth: view.frame.width)
        ratingsAndBookmarkView.isHidden = true
    }
    
    private func setupAddressAndLocationView() {
        addressAndLocationView = AddressAndLocationView(
            name: "Efficitur Resort Yoga centre",
            address: "755 Brickyard St., Lake Zurich, IL 60047",
            location: nil,
            onSeeMapTap: navigateToMapView)
        scrollContentView.addSubview(addressAndLocationView)
        addressAndLocationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressAndLocationView.topAnchor.constraint(equalTo: ratingsAndBookmarkView.bottomAnchor, constant: 40),
            addressAndLocationView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: scrollViewContentMargin),
            addressAndLocationView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -scrollViewContentMargin)
        ])
    }
    
    private func setupScheduleView() {
        scheduleView = TimingsAndScheduleView()
        scheduleView.updateTime(weekdayTimeFrame: "09.00 - 18.00", weekendTimeFrame: "08.30 - 17.30")
        scrollContentView.addSubview(scheduleView)
        scheduleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scheduleView.topAnchor.constraint(equalTo: addressAndLocationView.bottomAnchor, constant: 10),
            scheduleView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: scrollViewContentMargin),
            scheduleView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -scrollViewContentMargin)
        ])
    }
    
    private func setupDescriptionView() {
        descriptionView = DescriptionView(description: "Integer ac interdum lacus. Nunc porta semper lacus a varius. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis")
        scrollContentView.addSubview(descriptionView)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: scheduleView.bottomAnchor, constant: 15),
            descriptionView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: scrollViewContentMargin),
            descriptionView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -scrollViewContentMargin)
        ])
    }
    
    private func setupSeeReviewsButton() {
        seeReviewsView = SeeReviewsTapableView(onTap: navigateToReviews)
        seeReviewsView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(seeReviewsView)
        NSLayoutConstraint.activate([
            seeReviewsView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 15),
            seeReviewsView.heightAnchor.constraint(equalToConstant: 30),
            seeReviewsView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            seeReviewsView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            seeReviewsView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor, constant: -95)
        ])
    }
}

//MARK:- YogaTransitionAnimatable

extension YogaViewController: YogaNavigationAnimatorProtocol {
    
    func didCompletePushTransition() {
        topImageView.isHidden = false
        ratingsAndBookmarkView.isHidden = false
        barBackButtonView.isHidden = false
    }
}
