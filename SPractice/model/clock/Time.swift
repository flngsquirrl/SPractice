//
//  Time.swift
//  SPractice
//
//  Created by Yuliya Charniak on 6.10.22.
//

import Foundation

struct Time: Equatable {
    var minutes: Int
    var seconds: Int

    init(_ timeInSeconds: Int) {
        self.minutes = ClockTime.getMinutes(of: timeInSeconds)
        self.seconds = ClockTime.getSeconds(of: timeInSeconds)
    }

    var timeInSeconds: Int {
        ClockTime.calculateDuration(minutes: minutes, seconds: seconds)
    }
}
