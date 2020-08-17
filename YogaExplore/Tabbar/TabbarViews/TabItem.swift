//
//  TabItem.swift
//  YogaExplore
//
//  Created by Karun Pant on 14/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

struct TabItem {
    
    // MARK:- Item enum
    
    enum ItemType: String, CaseIterable {
        case yoga = "yoga"
        case chats = "chats"
        case articles = "articles"
        case settings = "settings"
        
        private var title: String {
            self.rawValue.capitalized
        }
        
        // attributed title for display
        func displayTitle(isSelected: Bool) -> NSAttributedString {
            let fontSize: CGFloat = 12
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: isSelected
                    ? Colors.componentBackground.color
                    : Colors.mainText.color,
                .font: isSelected
                    ? UbuntuFont.medium.sized(size: fontSize)
                    : UbuntuFont.regular.sized(size: fontSize)
            ]
            return NSAttributedString(string: title, attributes: attributes)
        }
        
        // view controller based on ItemType
        var viewController: UIViewController {
            let storyboardID: String = {
                switch self {
                case .yoga:
                    return self.rawValue
                case .articles, .chats, .settings:
                    return ItemType.chats.rawValue
                }
            }()
            let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyboardID)
            viewController.title = title
            return viewController
        }
        
        // icon for ItemType
        func icon(isSelected: Bool) -> UIImage {
            let imageName: String = {
                switch self {
                case .yoga:
                    return isSelected ? "yogaDark" : "yogaLight"
                case .articles:
                    return isSelected ? "articlesDark" : "articlesLight"
                case .chats:
                    return isSelected ? "chatsDark" : "chatsLight"
                case .settings:
                    return isSelected ? "settingsDark" : "settingsLight"
                }
            }()
            return UIImage(named: imageName) ?? UIImage()
        }
    }
    
    // MARK:- Properties
    
    let item: ItemType
    let isSelected: Bool
    let position: Int
}
