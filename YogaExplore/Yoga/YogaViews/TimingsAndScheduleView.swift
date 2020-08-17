//
//  ScheduleView.swift
//  YogaExplore
//
//  Created by Karun Pant on 15/08/20.
//  Copyright © 2020 iSwiftCoder.com. All rights reserved.
//

import UIKit

class TimingsAndScheduleView: NIBDesignableView {
    @IBOutlet var weekdayTitleLabel: UILabel!
    @IBOutlet var weekendTitleLabel: UILabel!
    @IBOutlet var weekdayTimeLabel: UILabel!
    @IBOutlet var weekendTimeLabel: UILabel!
    init() {
        super.init(contentClass: TimingsAndScheduleView.self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateTime(weekdayTimeFrame: String, weekendTimeFrame: String) {
        weekdayTimeLabel.text = weekdayTimeFrame
        weekendTimeLabel.text = weekendTimeFrame
        weekdayTitleLabel.text = weekdayTimeFrame.isEmpty ? "" : "Weekdays"
        weekendTitleLabel.text = weekendTimeFrame.isEmpty ? "" : "Weekend"
    }
}
