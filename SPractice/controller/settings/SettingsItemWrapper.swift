//
//  SettingsItemWrapper.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.10.22.
//

import Foundation
import Combine

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
