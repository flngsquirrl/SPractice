//
//  SettingsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import Foundation

class SettingsManager {
    static var settings = Settings()

    private init() {
    }

    static var restNameItem: SettingsItemStringWrapper = SettingsItemStringWrapper(for: settings.getItem(.restName))
    static var restDurationItem: SettingsItemIntWrapper = SettingsItemIntWrapper(for: settings.getItem(.restDuration))
    static var flowAutoFinishItem: SettingsItemBoolWrapper = SettingsItemBoolWrapper(for: settings.getItem(.flowAutoFinish))
    static var flowAutoFinishAfterTimeItem: SettingsItemTimeWrapper = SettingsItemTimeWrapper(for: settings.getItem(.flowAutoFinishAfterTime))
    static var tabataWarmUpDurationItem: SettingsItemIntWrapper = SettingsItemIntWrapper(for: settings.getItem(.tabataWarmUpDuration))
    static var tabataActivityDurationItem: SettingsItemIntWrapper = SettingsItemIntWrapper(for: settings.getItem(.tabataActivityDuration))
    static var tabataRestDurationItem: SettingsItemIntWrapper = SettingsItemIntWrapper(for: settings.getItem(.tabataRestDuration))
    static var tabataCoolDownDurationItem: SettingsItemIntWrapper = SettingsItemIntWrapper(for: settings.getItem(.tabataCoolDownDuration))
    static var tabataCyclesItem: SettingsItemIntWrapper = SettingsItemIntWrapper(for: settings.getItem(.tabataCycles))

    static var tabataExerciseDuration: Int {
        tabataWarmUpDurationItem.value + (tabataActivityDurationItem.value + tabataRestDurationItem.value)
            * tabataCyclesItem.value + tabataCoolDownDurationItem.value
    }

    static var flowAutoFinishAfterTime: Int {
        let setupValue = flowAutoFinishAfterTimeItem.value
        if setupValue.timeInSeconds == 0 {
            return settings.getDefault(.flowAutoFinishAfterTime).getIntValue()
        }
        return setupValue.timeInSeconds
    }

    static var restName: String {
        let setupValue = restNameItem.value.trimmingCharacters(in: .whitespacesAndNewlines)
        if setupValue.isEmpty {
            return settings.getDefault(.restName).value
        }
        return setupValue
    }

    static func saveSettings() {
        settings.save()
    }

    static func resetToDefauls() {
        settings.resetToDefauls()

        updateTabataWrappers()
        updateFlowWrappers()
        updatePauseWrappers()
    }

    static func resetToDefauls(subgroup: SettingsSubGroup) {
        settings.resetToDefauls(subgroup: subgroup)

        switch subgroup {
        case .tabata:
            updateTabataWrappers()
        case .flow:
            updateFlowWrappers()
        case .rest:
            updatePauseWrappers()
        case .examples:
            return
        }
    }

    static func updatePauseWrappers() {
        restNameItem.updateWith(settings.getItem(.restName))
        restDurationItem.updateWith(settings.getItem(.restDuration))
    }

    static func updateFlowWrappers() {
        flowAutoFinishItem.updateWith(settings.getItem(.flowAutoFinish))
        flowAutoFinishAfterTimeItem.updateWith(settings.getItem(.flowAutoFinishAfterTime))
    }

    static func updateTabataWrappers() {
        tabataWarmUpDurationItem.updateWith(settings.getItem(.tabataWarmUpDuration))
        tabataActivityDurationItem.updateWith(settings.getItem(.tabataActivityDuration))
        tabataRestDurationItem.updateWith(settings.getItem(.tabataRestDuration))
        tabataCoolDownDurationItem.updateWith(settings.getItem(.tabataCoolDownDuration))
        tabataCyclesItem.updateWith(settings.getItem(.tabataCycles))
    }

    static var hasChangesFromDefaults: Bool {
        settings.hasChangesFromDefaults
    }

    static func hasChangesFromDefaults(in subgroup: SettingsSubGroup) -> Bool {
        settings.hasChangesFromDefaults(in: subgroup)
    }
}

class Settings: ObservableObject {

    typealias SettingsType = [SettingsSubGroup: [SettingsItem]]
    var groups: SettingsType

    static private let saveKey = "settingsNew"

    static private let defaults: SettingsType = [
        .tabata: [.defaultTabataWarmUpDuration, .defaultTabataActivityDuration, .defaultTabataRestDuration,
            .defaultTabataCoolDownDuration, .defaultTabataCycles],
        .flow: [.defaultFlowAutoFinish, .defaultFlowAutoFinishAfterTime],
        .rest: [.defaultRestName, .defaultRestDuration]
    ]

    private var defaults: SettingsType {
        return Self.defaults.mapValues { $0.map { item in SettingsItem(from: item)} }
    }

    fileprivate init() {
        // UserDefaults.standard.removeObject(forKey: "settings")
        if let savedItems = UserDefaults.standard.data(forKey: Self.saveKey) {
            let decoder = JSONDecoder()

            if let decoded = try? decoder.decode(SettingsType.self, from: savedItems) {
                groups = decoded
                return
            }
        }

        groups = Self.defaults
    }

    fileprivate func save() {
        objectWillChange.send()

        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(groups) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }

    fileprivate func getItem(_ name: SettingsItemName) -> SettingsItem {
        let items = groups.flatMap { $1 }
        let item = items.first(where: { $0.name == name})
        guard let item = item else {
            fatalError("Error getting value of \(name)")
        }
        return item
    }

    fileprivate func getDefault(_ name: SettingsItemName) -> SettingsItem {
        let items = defaults.flatMap { $1 }
        let item = items.first(where: { $0.name == name})
        guard let item = item else {
            fatalError("Error getting default value of \(name)")
        }
        return item
    }

    fileprivate func resetToDefauls(subgroup: SettingsSubGroup) {
        if groups[subgroup] != nil {
            guard let defaultGroup = defaults[subgroup] else {
                return
            }

            groups[subgroup] = defaultGroup
        }
    }

    fileprivate func resetToDefauls() {
        groups = defaults
    }

    var hasChangesFromDefaults: Bool {
        for key in groups.keys {
            let hasChanges = hasChangesFromDefaults(in: key)
            if hasChanges {
                return true
            }
        }

        return false
    }

    func hasChangesFromDefaults(in subgroup: SettingsSubGroup) -> Bool {
        let items = groups[subgroup]!
        let defaultItems = defaults[subgroup]!

        for item in items {
            let defaultItem = defaultItems.first(where: { $0.name == item.name })!
            if defaultItem.value != item.value {
                return true
            }
        }

        return false
    }
}
