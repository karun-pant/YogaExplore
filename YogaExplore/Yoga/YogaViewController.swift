//
//  YogaViewController.swift
//  YogaExplore
//
//  Created by Karun Pant on 8/11/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit
import CoreLocation

class YogaViewController: UIViewController {
    
    private var ratingsAndBookmarkView: RatingsAndBookmarkView!
    private var topImageView: UIImageView!
    private var addressAndLocationView: AddressAndLocationView!
    private var scheduleView: ScheduleView!
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
        let gradientViewSize: CGSize = .init(width: view.frame.width,
                                         height: 120)
        let gradientView = UIView(frame: .zero)
        let backButtonView = UIView(frame: .zero)
        let backImageView = UIImageView(image: UIImage(named: "back"))
        backImageView.contentMode = .scaleAspectFit
        backButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBack)))
        backButtonView.addSubview(backImageView)
        gradientView.addSubview(backButtonView)
        view.addSubview(gradientView)
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backButtonView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: gradientViewSize.height),
            // back button view
            backImageView.heightAnchor.constraint(equalToConstant: 25),
            backImageView.widthAnchor.constraint(equalToConstant: 25),
            backImageView.centerXAnchor.constraint(equalTo: backButtonView.centerXAnchor),
            backImageView.bottomAnchor.constraint(equalTo: backButtonView.bottomAnchor),
            backButtonView.heightAnchor.constraint(equalToConstant: 50),
            backButtonView.widthAnchor.constraint(equalToConstant: 50),
            backButtonView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 10),
            backButtonView.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 35)
        ])
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor(white: 0, alpha: 0.70).cgColor, UIColor.clear]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(origin: .zero, size: gradientViewSize)
        view.layer.insertSublayer(gradient, at: 1)
        view.bringSubviewToFront(gradientView)
    }
    private func setupTopImageView() {
        let height = view.frame.height * 0.5 + 17
        let topImageSize: CGSize = .init(width: view.frame.width,
                                         height: height)
        topImageView = UIImageView(image: UIImage(named: "topImage"))
        topImageView.contentMode = .scaleAspectFill
        scrollContentView.addSubview(topImageView)
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // TopImageView
            topImageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            topImageView.heightAnchor.constraint(equalToConstant: topImageSize.height),
            topImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            topImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor)
        ])
        let radius = topImageSize.width * 0.125
        let shapePath = UIBezierPath(roundedRect: .init(origin: .zero, size: topImageSize),
                                     byRoundingCorners: [.bottomLeft, .bottomRight],
                                     cornerRadii: .init(width: radius, height: radius))
        let shapeLayerMask = CAShapeLayer()
        shapeLayerMask.path = shapePath.cgPath
        topImageView.layer.mask = shapeLayerMask
        topImageView.layer.masksToBounds = true
    }
    private func setupRatingsAndBookmarkView() {
        ratingsAndBookmarkView = RatingsAndBookmarkView(rating: 5,
                                                        isBookmarked: true)
        scrollContentView.addSubview(ratingsAndBookmarkView)
        ratingsAndBookmarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingsAndBookmarkView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: RatingsAndBookmarkView.Style.margin),
            ratingsAndBookmarkView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -RatingsAndBookmarkView.Style.margin),
            ratingsAndBookmarkView.heightAnchor.constraint(equalToConstant: RatingsAndBookmarkView.Style.height),
            ratingsAndBookmarkView.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: -RatingsAndBookmarkView.Style.height/2)
        ])
        ratingsAndBookmarkView.capsuleAndDropShadow(boundingWidth: view.frame.width)
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
        scheduleView = ScheduleView()
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
