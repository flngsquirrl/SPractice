//
//  Clock-Calculator.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.06.22.
//

import Foundation

extension ClockTime {
    
    static func calculateDuration(minutes: Int, seconds: Int) -> Int {
        minutes * 60 + seconds
    }
    
    static func getMinutes(of duration: Int) -> Int {
        duration / 60
    }
    
    static func getSeconds(of duration: Int) -> Int {
        duration % 60
    }
    
    static func getExtendedPresentation(for duration: Int) -> String {
        guard let result = briefHrMinSecFormatter.string(from: TimeInterval(duration)) else {
            return ""
        }
        return result
    }
    
    static func getPaddedPresentation(for duration: Int) -> String {
        var units: NSCalendar.Unit = [.minute, .second]
        if duration > 60 * 60 {
            units = [.hour, .minute, .second]
        }
        guard let result = getPositionalFormatter(for: units).string(from: TimeInterval(duration)) else {
            return ""
        }
        return result
    }
    
    static func getPositionalFormatter(for units: NSCalendar.Unit = [.minute, .second]) -> DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }
    
    static var briefHrMinSecFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        return formatter
    }
}
