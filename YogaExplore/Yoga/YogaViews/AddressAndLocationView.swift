//
//  AddressAndLocationView.swift
//  YogaExplore
//
//  Created by Karun Pant on 15/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit
import CoreLocation

class AddressAndLocationView: NIBDesignableView {

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    private let location: CLLocation?
    private let onSeeMapTap: (CLLocation?)->Void
    
    // MARK:- Initializers
    
    init(name: String,
         address: String,
         location: CLLocation? = nil,
         onSeeMapTap: @escaping (CLLocation?)->Void) {
        self.onSeeMapTap = onSeeMapTap
        self.location = location
        super.init(contentClass: AddressAndLocationView.self)
        updateDetails(name: name, address: address)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Updates name and address.
    /// - Parameters:
    ///   - name: if nil keeps the text in `nameLabel`
    ///   - address: if nil keeps the text in `addressLabel`
    func updateDetails(name: String? = nil, address: String? = nil) {
        nameLabel.text = name != nil ? nameLabel.text : name
        addressLabel.text = address != nil ? addressLabel.text : address
    }
    
    @IBAction func tapSeeOnMap(_ sender: UIButton) {
        onSeeMapTap(location)
    }
}
