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
        self.minutes = TimeCalculator.getMinutes(of: timeInSeconds)
        self.seconds = TimeCalculator.getSeconds(of: timeInSeconds)
    }

    var timeInSeconds: Int {
        TimeCalculator.calculateDuration(minutes: minutes, seconds: seconds)
    }
}
