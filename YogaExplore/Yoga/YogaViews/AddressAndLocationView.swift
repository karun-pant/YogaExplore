//
//  AddressAndLocationView.swift
//  YogaExplore
//
//  Created by Karun Pant on 15/08/20.
//  Copyright © 2020 DigitalMinds. All rights reserved.
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
    
    // MARK:- Helpers
    
    func updateDetails(name: String, address: String) {
        nameLabel.text = name
        addressLabel.text = address
    }
    @IBAction func tapSeeOnMap(_ sender: UIButton) {
        onSeeMapTap(location)
    }
}
