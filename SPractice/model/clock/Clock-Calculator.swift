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
    
    static func getDisplayDuration(for duration: Int) -> String {
        let minutes = getMinutes(of: duration)
        let seconds = getSeconds(of: duration)
        
        let minutesPart = minutes != 0 ? "\(minutes) min" : ""
        let secondsPart = "\(seconds) sec"
        
        return !minutesPart.isEmpty ? "\(minutesPart) \(secondsPart)" : "\(secondsPart)"
    }
}
