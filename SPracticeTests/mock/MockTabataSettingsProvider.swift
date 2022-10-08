//
//  MockTabataSettingsProvider.swift
//  SPracticeTests
//
//  Created by Yuliya Charniak on 8.10.22.
//

import Foundation

@testable import SPractice

struct MockTabataSettingsProvider: TabataSettingsProvider {

    static let testWarmUpDuration = 1
    static let testActivityDuration = 2
    static let testRestDuration = 3
    static let testCoolDownDuration = 4
    static let testCycles = 5

    var tabataWarmUpDuration: Int {
        Self.testWarmUpDuration
    }

    var tabataActivityDuration: Int {
        Self.testActivityDuration
    }

    var tabataRestDuration: Int {
        Self.testRestDuration
    }

    var tabataCoolDownDuration: Int {
        Self.testCoolDownDuration
    }

    var tabataCycles: Int {
        Self.testCycles
    }

}
