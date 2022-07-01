//
//  ClockDisplay.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.06.22.
//

import Foundation

struct ClockTime {
    
    private(set) var timeInSeconds: Int = 0
    
    init(timeInSeconds: Int) {
        self.timeInSeconds = timeInSeconds
    }
    
    var isOut: Bool {
        timeInSeconds == 0
    }
    
    var secondsPart: Int {
        Self.getSeconds(of: timeInSeconds)
    }
    
    var minutesPart: Int {
        Self.getMinutes(of: timeInSeconds)
    }
    
    var minutesFirstDigit: Int {
        minutesPart / 10
    }
    
    var minutesSecondDigit: Int {
        minutesPart % 10
    }
    
    var secondsFirstDigit: Int {
        secondsPart / 10
    }
    
    var secondsSecondDigit: Int {
        secondsPart % 10
    }
    
    mutating func addSecond() {
        timeInSeconds += 1
    }
    
    mutating func substractSecond() {
        timeInSeconds -= 1
    }
}
