//
//  StarIconButton.swift
//  YogaExplore
//
//  Created by Karun Pant on 15/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

class StarIconButton: UIButton {
    
    private (set) var associatedRating: Int = -1
    
    func setAssociatedRating(rating: Int) {
        guard rating > 0 else {
            return
        }
        associatedRating = rating
    }
}
