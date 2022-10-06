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
    fileprivate(set) var value: String

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

protocol SettingsItemWrapper: ObservableObject {

    associatedtype ValueType

    var settingsItem: SettingsItem {get set}
    var value: ValueType {get set}

    func convertToString(_ value: ValueType) -> String
    func convertToValue(_ string: String) -> ValueType
}

extension SettingsItemWrapper where Self.ObjectWillChangePublisher == ObservableObjectPublisher {

    var value: ValueType {
        get {
            convertToValue(settingsItem.value)
        }
        set {
            settingsItem.value = convertToString(newValue)
            objectWillChange.send()
        }
    }

    func convertToString(_ value: ValueType) -> String {
        fatalError("implement in specific class")
    }

    func convertToValue(_ string: String) -> ValueType {
        fatalError("implement in specific class")
    }
}

class SettingsItemHolder: ObservableObject {

    var settingsItem: SettingsItem {
        willSet {
            objectWillChange.send()
        }
    }

    init(_ settingsItem: SettingsItem) {
        self.settingsItem = settingsItem
    }
}

class SettingsItemStringWrapper: SettingsItemHolder, SettingsItemWrapper {

    func convertToString(_ value: String) -> String {
        value
    }

    func convertToValue(_ string: String) -> String {
        string
    }
}

class SettingsItemIntWrapper: SettingsItemHolder, SettingsItemWrapper {

    func convertToString(_ value: Int) -> String {
        String(value)
    }

    func convertToValue(_ string: String) -> Int {
        guard let value = Int(settingsItem.value) else {
            fatalError("Can not convert to Int the value of \(settingsItem.name)")
        }
        return value
    }
}

class SettingsItemBoolWrapper: SettingsItemHolder, SettingsItemWrapper {

    func convertToString(_ value: Bool) -> String {
        String(value)
    }

    func convertToValue(_ string: String) -> Bool {
        guard let result = Bool(settingsItem.value) else {
            fatalError("Can not convert to Bool the value of \(settingsItem.name)")
        }
        return result
    }
}

class SettingsItemTimeWrapper: SettingsItemHolder, SettingsItemWrapper {

    func convertToString(_ value: Time) -> String {
        String(TimeCalculator.calculateDuration(minutes: value.minutes, seconds: value.seconds))
    }

    func convertToValue(_ string: String) -> Time {
        guard let timeInSeconds = Int(settingsItem.value) else {
            fatalError("Can not convert to Bool the value of \(settingsItem.name)")
        }
        let time = Time(timeInSeconds)
        return time
    }
}
