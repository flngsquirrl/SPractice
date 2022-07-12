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
    
    case pauseName
    case pauseDuration
}

struct Time {
    var minutes: Int
    var seconds: Int
}

class SettingsItem: ObservableObject, Codable {
    
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
        let minutes = ClockTime.getMinutes(of: timeInSeconds)
        let seconds = ClockTime.getSeconds(of: timeInSeconds)
        let time = Time(minutes: minutes, seconds: seconds)
        return time
    }
    
    static let defaultTabataWarmUpDuration = SettingsItem(name: .tabataWarmUpDuration, value: "10")
    static let defaultTabataActivityDuration = SettingsItem(name: .tabataActivityDuration, value: "20")
    static let defaultTabataRestDuration = SettingsItem(name: .tabataRestDuration, value: "10")
    static let defaultTabataCoolDownDuration = SettingsItem(name: .tabataCoolDownDuration, value: "10")
    static let defaultTabataCycles = SettingsItem(name: .tabataCycles, value: "8")
    static let defaultFlowAutoFinish = SettingsItem(name: .flowAutoFinish, value: "true")
    static let defaultFlowAutoFinishAfterTime = SettingsItem(name: .flowAutoFinishAfterTime, value: "3600")
    static let defaultPauseName = SettingsItem(name: .pauseName, value: "Pause")
    static let defaultPauseDuration = SettingsItem(name: .pauseDuration, value: "10")
}

protocol SettingsItemWrapper: ObservableObject {
    
    associatedtype T
    
    var settingsItem: SettingsItem {get}
    
    var value: T {get set}
}

class SettingsItemStringWrapper: SettingsItemWrapper {
    
    init(for settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        self.value = settingsItem.value
    }
    
    internal var settingsItem: SettingsItem
    
    @Published var value: String {
        didSet {
            settingsItem.value = value
        }
    }
}

class SettingsItemIntWrapper: SettingsItemWrapper {
    
    init(for settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        self.value = settingsItem.getIntValue()
    }
    
    internal var settingsItem: SettingsItem
    
    @Published var value: Int {
        didSet {
            settingsItem.value = String(value)
        }
    }
}

class SettingsItemBoolWrapper: SettingsItemWrapper {
    
    init(for settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        self.value = settingsItem.getBoolValue()
    }
    
    internal var settingsItem: SettingsItem
    
    @Published var value: Bool {
        didSet {
            settingsItem.value = String(value)
        }
    }
}

class SettingsItemTimeWrapper: SettingsItemWrapper {
    
    init(for settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
        
        let time = Int(settingsItem.value)!
        let minutes = ClockTime.getMinutes(of: time)
        let seconds = ClockTime.getSeconds(of: time)
        self.value = Time(minutes: minutes, seconds: seconds)
    }
    
    internal var settingsItem: SettingsItem
    
    @Published var value: Time {
        didSet {
            settingsItem.value = String(ClockTime.calculateDuration(minutes: value.minutes, seconds: value.seconds))
        }
    }
}
