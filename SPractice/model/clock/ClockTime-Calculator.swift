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
        guard let result = positionalMinSecFormatter.string(from: TimeInterval(duration)) else {
            return ""
        }
        return result
    }
    
    static var positionalMinSecFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }
    
    static var briefHrMinSecFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        return formatter
    }
}
