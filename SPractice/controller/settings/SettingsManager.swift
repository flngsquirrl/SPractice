//
//  SettingsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import Foundation

class SettingsManager: SignalChangeListener {

    var settings = Settings()

    lazy var restNameItem = SettingsItemStringWrapper(settings.getItem(.restName))
    lazy var restDurationItem = SettingsItemIntWrapper(settings.getItem(.restDuration))
    lazy var flowAutoFinishItem = SettingsItemBoolWrapper(settings.getItem(.flowAutoFinish))
    lazy var flowAutoFinishAfterTimeItem = SettingsItemTimeWrapper(settings.getItem(.flowAutoFinishAfterTime))
    lazy var tabataWarmUpDurationItem = SettingsItemIntWrapper(settings.getItem(.tabataWarmUpDuration))
    lazy var tabataActivityDurationItem = SettingsItemIntWrapper(settings.getItem(.tabataActivityDuration))
    lazy var tabataRestDurationItem = SettingsItemIntWrapper(settings.getItem(.tabataRestDuration))
    lazy var tabataCoolDownDurationItem = SettingsItemIntWrapper(settings.getItem(.tabataCoolDownDuration))
    lazy var tabataCyclesItem = SettingsItemIntWrapper(settings.getItem(.tabataCycles))

    override init() {
        super.init()

        let targets = [restNameItem.objectWillChange, restDurationItem.objectWillChange,
                       flowAutoFinishItem.objectWillChange, flowAutoFinishAfterTimeItem.objectWillChange,
                       tabataWarmUpDurationItem.objectWillChange, tabataActivityDurationItem.objectWillChange,
                       tabataRestDurationItem.objectWillChange, tabataCoolDownDurationItem.objectWillChange,
                       tabataCyclesItem.objectWillChange]
        listenTo(targets: targets) { [weak self] in
            self?.settings.save()
        }
    }

    var flowAutoFinishAfterTime: Int {
        let setupValue = flowAutoFinishAfterTimeItem.value
        if setupValue.timeInSeconds == 0 {
            return SettingsItemIntWrapper(settings.getDefault(.flowAutoFinishAfterTime)).value
        }
        return setupValue.timeInSeconds
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
        restNameItem.settingsItem = settings.getItem(.restName)
        restDurationItem.settingsItem = settings.getItem(.restDuration)
    }

    func updateFlowWrappers() {
        flowAutoFinishItem.settingsItem = settings.getItem(.flowAutoFinish)
        flowAutoFinishAfterTimeItem.settingsItem = settings.getItem(.flowAutoFinishAfterTime)
    }

    func updateTabataWrappers() {
        tabataWarmUpDurationItem.settingsItem = settings.getItem(.tabataWarmUpDuration)
        tabataActivityDurationItem.settingsItem = settings.getItem(.tabataActivityDuration)
        tabataRestDurationItem.settingsItem = settings.getItem(.tabataRestDuration)
        tabataCoolDownDurationItem.settingsItem = settings.getItem(.tabataCoolDownDuration)
        tabataCyclesItem.settingsItem = settings.getItem(.tabataCycles)
    }

    var hasChangesFromDefaults: Bool {
        settings.hasChangesFromDefaults
    }

    func hasChangesFromDefaults(in subgroup: SettingsSubGroup) -> Bool {
        settings.hasChangesFromDefaults(in: subgroup)
    }
}

extension SettingsManager: TabataSettingsProvider {

    var tabataWarmUpDuration: Int {
        tabataWarmUpDurationItem.value
    }

    var tabataActivityDuration: Int {
        tabataActivityDurationItem.value
    }

    var tabataRestDuration: Int {
        tabataRestDurationItem.value
    }

    var tabataCoolDownDuration: Int {
        tabataCoolDownDurationItem.value
    }

    var tabataCycles: Int {
        tabataCyclesItem.value
    }
}

extension SettingsManager: RestSettingsProvider {

    var restName: String {
        let setupValue = restNameItem.value.trimmingCharacters(in: .whitespacesAndNewlines)
        if setupValue.isEmpty {
            return settings.getDefault(.restName).value
        }
        return setupValue
    }

    var restDuration: Int {
        restDurationItem.value
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
