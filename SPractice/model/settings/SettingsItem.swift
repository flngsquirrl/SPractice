//
//  SettingsItem.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.07.22.
//

import Foundation

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

class SettingsItem: Codable {

    var name: SettingsItemName
    fileprivate(set) var value: String

    init(name: SettingsItemName, value: String) {
        self.name = name
        self.value = value
    }

    init(from item: SettingsItem) {
        self.name = item.name
        self.value = item.value
    }

    func getIntValue() -> Int {
        guard let value = Int(value) else {
            fatalError("Can not convert to Int the value of \(name)")
        }
        return value
    }

    func getBoolValue() -> Bool {
        guard let result = Bool(value) else {
            fatalError("Can not convert to Bool the value of \(name)")
        }
        return result
    }

    func getTimeValue() -> Time {
        guard let timeInSeconds = Int(value) else {
            fatalError("Can not convert to Bool the value of \(name)")
        }
        let time = Time(timeInSeconds)
        return time
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

protocol SettingsItemWrapper: ObservableObject {

    associatedtype ValueType

    var settingsItem: SettingsItem {get}

    var value: ValueType {get set}
}

class SettingsItemStringWrapper: SettingsItemWrapper {

    internal var settingsItem: SettingsItem

    @Published var value: String {
        willSet {
            settingsItem.value = newValue
        }
    }

    init(for settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        self.value = settingsItem.value
    }

    func updateWith(_ settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        value = settingsItem.value
    }
}

class SettingsItemIntWrapper: SettingsItemWrapper {
    internal var settingsItem: SettingsItem

    @Published var value: Int {
        willSet {
            settingsItem.value = String(newValue)
        }
    }

    init(for settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        self.value = settingsItem.getIntValue()
    }

    func updateWith(_ settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        value = settingsItem.getIntValue()
    }
}

class SettingsItemBoolWrapper: SettingsItemWrapper {

    internal var settingsItem: SettingsItem

    @Published var value: Bool {
        willSet {
            settingsItem.value = String(newValue)
        }
    }

    init(for settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        self.value = settingsItem.getBoolValue()
    }

    func updateWith(_ settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        value = settingsItem.getBoolValue()
    }
}

class SettingsItemTimeWrapper: SettingsItemWrapper {

    internal var settingsItem: SettingsItem

    @Published var value: Time {
        willSet {
            settingsItem.value = String(ClockTime.calculateDuration(minutes: newValue.minutes, seconds: newValue.seconds))
        }
    }

    init(for settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        self.value = settingsItem.getTimeValue()
    }

    func updateWith(_ settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        value = settingsItem.getTimeValue()
    }
}
