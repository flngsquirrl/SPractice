//
//  SettingsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import Foundation

class SettingsManager: SignalChangeListener {

    var settings: Settings

    var restNameItem: SettingsItemStringWrapper
    var restDurationItem: SettingsItemIntWrapper
    var flowAutoFinishItem: SettingsItemBoolWrapper
    var flowAutoFinishAfterTimeItem: SettingsItemTimeWrapper
    var tabataWarmUpDurationItem: SettingsItemIntWrapper
    var tabataActivityDurationItem: SettingsItemIntWrapper
    var tabataRestDurationItem: SettingsItemIntWrapper
    var tabataCoolDownDurationItem: SettingsItemIntWrapper
    var tabataCyclesItem: SettingsItemIntWrapper

    override init() {
        let baseSettings = Settings()
        self.settings = baseSettings
        restNameItem = SettingsItemStringWrapper(for: baseSettings.getItem(.restName))
        restDurationItem = SettingsItemIntWrapper(for: baseSettings.getItem(.restDuration))
        flowAutoFinishItem = SettingsItemBoolWrapper(for: baseSettings.getItem(.flowAutoFinish))
        flowAutoFinishAfterTimeItem = SettingsItemTimeWrapper(for: baseSettings.getItem(.flowAutoFinishAfterTime))
        tabataWarmUpDurationItem = SettingsItemIntWrapper(for: baseSettings.getItem(.tabataWarmUpDuration))
        tabataActivityDurationItem = SettingsItemIntWrapper(for: baseSettings.getItem(.tabataActivityDuration))
        tabataRestDurationItem = SettingsItemIntWrapper(for: baseSettings.getItem(.tabataRestDuration))
        tabataCoolDownDurationItem = SettingsItemIntWrapper(for: baseSettings.getItem(.tabataCoolDownDuration))
        tabataCyclesItem = SettingsItemIntWrapper(for: baseSettings.getItem(.tabataCycles))

        super.init()

        let targets = [restNameItem.objectWillChange, restDurationItem.objectWillChange,
                       flowAutoFinishItem.objectWillChange, flowAutoFinishAfterTimeItem.objectWillChange,
                       tabataWarmUpDurationItem.objectWillChange, tabataActivityDurationItem.objectWillChange,
                       tabataRestDurationItem.objectWillChange, tabataCoolDownDurationItem.objectWillChange,
                       tabataCyclesItem.objectWillChange]
        listenTo(targets: targets) {
            baseSettings.save()
        }
    }

    var tabataExerciseDuration: Int {
        tabataWarmUpDurationItem.value + (tabataActivityDurationItem.value + tabataRestDurationItem.value)
            * tabataCyclesItem.value + tabataCoolDownDurationItem.value
    }

    var flowAutoFinishAfterTime: Int {
        let setupValue = flowAutoFinishAfterTimeItem.value
        if setupValue.timeInSeconds == 0 {
            return settings.getDefault(.flowAutoFinishAfterTime).getIntValue()
        }
        return setupValue.timeInSeconds
    }

    var restName: String {
        let setupValue = restNameItem.value.trimmingCharacters(in: .whitespacesAndNewlines)
        if setupValue.isEmpty {
            return settings.getDefault(.restName).value
        }
        return setupValue
    }

    func saveSettings() {
        settings.save()
    }

    func resetToDefauls() {
        settings.resetToDefauls()

        updateTabataWrappers()
        updateFlowWrappers()
        updatePauseWrappers()
    }

    func resetToDefauls(subgroup: SettingsSubGroup) {
        settings.resetToDefauls(subgroup: subgroup)

        switch subgroup {
        case .tabata:
            updateTabataWrappers()
        case .flow:
            updateFlowWrappers()
        case .rest:
            updatePauseWrappers()
        default:
            return
        }
    }

    func updatePauseWrappers() {
        restNameItem.updateWith(settings.getItem(.restName))
        restDurationItem.updateWith(settings.getItem(.restDuration))
    }

    func updateFlowWrappers() {
        flowAutoFinishItem.updateWith(settings.getItem(.flowAutoFinish))
        flowAutoFinishAfterTimeItem.updateWith(settings.getItem(.flowAutoFinishAfterTime))
    }

    func updateTabataWrappers() {
        tabataWarmUpDurationItem.updateWith(settings.getItem(.tabataWarmUpDuration))
        tabataActivityDurationItem.updateWith(settings.getItem(.tabataActivityDuration))
        tabataRestDurationItem.updateWith(settings.getItem(.tabataRestDuration))
        tabataCoolDownDurationItem.updateWith(settings.getItem(.tabataCoolDownDuration))
        tabataCyclesItem.updateWith(settings.getItem(.tabataCycles))
    }

    var hasChangesFromDefaults: Bool {
        settings.hasChangesFromDefaults
    }

    func hasChangesFromDefaults(in subgroup: SettingsSubGroup) -> Bool {
        settings.hasChangesFromDefaults(in: subgroup)
    }
}

class Settings {

    typealias SettingsType = [SettingsSubGroup: [SettingsItem]]
    var groups: SettingsType

    static private let saveKey = "settings"

    static private let defaultSettings: SettingsType = [
        .tabata: [.defaultTabataWarmUpDuration, .defaultTabataActivityDuration, .defaultTabataRestDuration,
            .defaultTabataCoolDownDuration, .defaultTabataCycles],
        .flow: [.defaultFlowAutoFinish, .defaultFlowAutoFinishAfterTime],
        .rest: [.defaultRestName, .defaultRestDuration]
    ]

    static private var defaults: SettingsType {
        return Self.defaultSettings.mapValues { $0.map { item in SettingsItem(from: item)} }
    }

    fileprivate init() {
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
        let items = Self.defaults.flatMap { $1 }
        let item = items.first(where: { $0.name == name})
        guard let item = item else {
            fatalError("Error getting default value of \(name)")
        }
        return item
    }

    fileprivate func resetToDefauls(subgroup: SettingsSubGroup) {
        if groups[subgroup] != nil {
            guard let defaultGroup = Self.defaults[subgroup] else {
                return
            }

            groups[subgroup] = defaultGroup
        }
    }

    fileprivate func resetToDefauls() {
        groups = Self.defaults
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
        let defaultItems = Self.defaults[subgroup]!

        for item in items {
            let defaultItem = defaultItems.first(where: { $0.name == item.name })!
            if defaultItem.value != item.value {
                return true
            }
        }

        return false
    }
}
