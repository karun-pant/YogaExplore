//
//  RatingsAndBookmarkView.swift
//  YogaExplore
//
//  Created by Karun Pant on 14/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class RatingsAndBookmarkView: NIBDesignableView {
    struct Style {
        static let margin: CGFloat = 40
        static let height: CGFloat = 60
        static func estimatedSize(_ boundingWidth: CGFloat) -> CGSize {
            return .init(width: boundingWidth - (2 * margin), height: height)
        }
    }
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var starStackView: UIStackView!
    @IBOutlet var bookmarkImageView: UIImageView!
    var onBookmark: ((Bool) -> Void)?
    
    init?(rating: Double, isBookmarked: Bool) {
        super.init(contentClass: RatingsAndBookmarkView.self)
        bookmarkImageView.isHighlighted = isBookmarked
        starStackView.arrangedSubviews.enumerated().forEach {
            guard let starIconButton = $0.element as? StarIconButton else {
                assertionFailure("Did you change type of star icon in starStackView 🤔")
                return
            }
            starIconButton.setAssociatedRating(rating: $0.offset + 1)
        }
        updateRating(rating: rating)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func capsuleAndDropShadow(boundingWidth: CGFloat) {
        contentView.backgroundColor = Colors.background.color
        let shapeSize = Style.estimatedSize(boundingWidth)
        let radius = shapeSize.height/2
        let shapePath = UIBezierPath(
            roundedRect: .init(origin: .zero, size: shapeSize),
            cornerRadius: radius)
        let shapeLayerMask = CAShapeLayer()
        shapeLayerMask.path = shapePath.cgPath
        contentView.layer.masksToBounds = true
        contentView.layer.mask = shapeLayerMask
        layer.shadowPath = shapePath.cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 20
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }
    
    @IBAction private func handleRatingTap(sender: StarIconButton) {
        updateRating(rating: Double(sender.associatedRating))
    }
    
    private func updateRating(rating: Double) {
        let rating = RatingsAndBookmarkView.boundrifyRating(
            rating: rating,
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
    
    
    @IBAction func bookmarkIt(_ sender: Any) {
        bookmarkImageView.isHighlighted.toggle()
        onBookmark?(bookmarkImageView.isHighlighted)
    }
    
    private static func boundrifyRating(rating: Double, maxRatingStarsCount: Int) -> Double {
        guard rating >= 0 && rating <= Double(maxRatingStarsCount) else {
            assertionFailure("Ratings should be 0...5, defaulting to bounding range 😎")
            return rating < 0
                ? 0
                : rating > 5
                ? 5
                : rating
        }
        return floor(rating)
    }
}
