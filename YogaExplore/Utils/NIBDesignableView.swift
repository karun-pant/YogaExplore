//
//  NIBDesignableView.swift
//  YogaExplore
//
//  Created by Karun Pant on 14/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
//

import UIKit

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
