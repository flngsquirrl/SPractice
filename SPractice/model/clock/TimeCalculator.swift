//
//  TimeCalculator.swift
//  SPractice
//
//  Created by Yuliya Charniak on 6.10.22.
//

import Foundation

enum TimeCalculator {

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
