//
//  NIBDesignableView.swift
//  YogaExplore
//
//  Created by Karun Pant on 14/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

/// This class should be inherited by all NIb based views, this gives them independence of creating there own init without taking care of nitty gritties of creating a view from bundle.
/// Usage:
/// 1. Assign NIBDesignableView's subclass (view you wanna design in NIB) to FileOwner.
/// 2. Connect FileOwner's contentView to view in NIB
/// 3. Call init(contentClass: UIView.Type, nibName: String? = nil ) from your initializer.
/// 4. Use your initializer to get NIB view.
class NIBDesignableView: UIView {
    @IBOutlet var contentView: UIView!
    
    init(contentClass: UIView.Type, nibName: String? = .none) {
        super.init(frame: .zero)
        setupContentView(forClass: contentClass, nibName: nibName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView(forClass contentClass: AnyClass, nibName: String? = .none) {
        let safeNibName = nibName ?? String(describing: contentClass)
        Bundle.init(for: contentClass).loadNibNamed(safeNibName, owner: self, options: nil)
        addSubview(contentView)
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
