//
//  Clock-Converters.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.06.22.
//

import Foundation

extension Clock {
    
    static func calculateDuration(minutes: Int, seconds: Int) -> Int {
        minutes * 60 + seconds
    }
    
    static func getMinutes(of duration: Int) -> Int {
        duration / 60
    }
    
    static func getSeconds(of duration: Int) -> Int {
        duration % 60
    }
}
