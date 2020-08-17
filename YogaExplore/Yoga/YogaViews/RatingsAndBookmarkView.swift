//
//  RatingsAndBookmarkView.swift
//  YogaExplore
//
//  Created by Karun Pant on 14/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

class RatingsAndBookmarkView: NIBDesignableView {
    struct Style {
        static let margin: CGFloat = 40
        static func estimatedSize(_ boundingWidth: CGFloat) -> CGSize {
            return .init(width: boundingWidth - (2 * margin), height: 60)
        }
    }
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var starStackView: UIStackView!
    @IBOutlet private var bookmarkImageView: UIImageView!
    var onBookmark: ((Bool) -> Void)?
    
    private (set) var rating: Double = 0 {
        didSet {
            let rating = RatingsAndBookmarkView.boundrifyRating(
                rating: self.rating,
                maxRatingStarsCount: starStackView.arrangedSubviews.count)
            ratingLabel.text = String(format: "%0.1f", rating)
            // this assumes we have a highlighted image for this
            // set highlighted image and use that for changing star state
            // highlightedImage will be selected
            // image will be normal state
            let maxRatingIndex = Int(rating)
            starStackView.arrangedSubviews.enumerated().forEach {
                guard let starIcon = $0.element as? UIImageView else {
                    return
                }
                starIcon.isHighlighted = $0.offset < maxRatingIndex
            }
        }
    }
    private (set) var isBookmarked: Bool = false {
        didSet {
            bookmarkImageView.isHighlighted.toggle()
            onBookmark?(bookmarkImageView.isHighlighted)
        }
    }
    
    init(rating: Double, isBookmarked: Bool) {
        super.init(contentClass: RatingsAndBookmarkView.self)
        self.isBookmarked = isBookmarked
        starStackView.arrangedSubviews.enumerated().forEach {
            guard let starIconButton = $0.element as? StarIconButton else {
                assertionFailure("Did you change type of star icon in starStackView 🤔")
                return
            }
            starIconButton.setAssociatedRating(rating: $0.offset + 1)
        }
        self.rating = rating
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func roundCornersAndDropShadow(boundingWidth: CGFloat, isShadowNeeded: Bool = true) {
        contentView.backgroundColor = Colors.background.color
        let shapeSize = Style.estimatedSize(boundingWidth)
        let radius = shapeSize.height/2
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = radius
        let shapePath = UIBezierPath(
            roundedRect: .init(origin: .zero, size: shapeSize),
            cornerRadius: radius)
        if isShadowNeeded {
            layer.shadowPath = shapePath.cgPath
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 20
            layer.shadowOffset = .zero
            layer.shadowOpacity = 0.1
            layer.masksToBounds = false
        } else {
            layer.shadowPath = nil
            layer.shadowOpacity = 0
        }
    }
    
    @IBAction private func handleRatingTap(sender: StarIconButton) {
        self.rating = Double(sender.associatedRating)
    }
    
    @IBAction func bookmarkIt(_ sender: Any) {
        isBookmarked.toggle()
    }
    
    /// This method checks rating values and sets them into boundry of `0 >= rating <= maxRatingStarsCount`
    private static func boundrifyRating(rating: Double, maxRatingStarsCount: Int) -> Double {
        let maxRatingStarsCount = Double(maxRatingStarsCount)
        guard rating >= 0 && rating <= maxRatingStarsCount else {
            assertionFailure("Ratings should be 0...5, defaulting to bounding range 😎")
            return rating < 0
                ? 0
                : rating > maxRatingStarsCount
                ? maxRatingStarsCount
                : rating
        }
        return floor(rating)
    }
}
