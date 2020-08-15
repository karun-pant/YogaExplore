//
//  ArrayExtension.swift
//  YogaExplore
//
//  Created by Karun Pant on 14/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
