//
//  SettingsItem.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.07.22.
//

import Foundation
import Combine

enum SettingsItemName: Codable {
    case tabataWarmUpDuration
    case tabataActivityDuration
    case tabataRestDuration
    case tabataCoolDownDuration
    case tabataCycles

    case flowAutoFinish
    case flowAutoFinishAfterTime

    case restName
    case restDuration
}

class SettingsItem: Codable {

    var name: SettingsItemName
    var value: String

    init(name: SettingsItemName, value: String) {
        self.name = name
        self.value = value
    }

    init(from item: SettingsItem) {
        self.name = item.name
        self.value = item.value
    }

    static let defaultTabataWarmUpDuration = SettingsItem(name: .tabataWarmUpDuration, value: "10")
    static let defaultTabataActivityDuration = SettingsItem(name: .tabataActivityDuration, value: "20")
    static let defaultTabataRestDuration = SettingsItem(name: .tabataRestDuration, value: "10")
    static let defaultTabataCoolDownDuration = SettingsItem(name: .tabataCoolDownDuration, value: "10")
    static let defaultTabataCycles = SettingsItem(name: .tabataCycles, value: "8")
    static let defaultFlowAutoFinish = SettingsItem(name: .flowAutoFinish, value: "true")
    static let defaultFlowAutoFinishAfterTime = SettingsItem(name: .flowAutoFinishAfterTime, value: "3600")
    static let defaultRestName = SettingsItem(name: .restName, value: "Rest")
    static let defaultRestDuration = SettingsItem(name: .restDuration, value: "10")
}
