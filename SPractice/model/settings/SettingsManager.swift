//
//  SettingsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import Foundation

class SettingsManager {
    var settings = Settings()
    
    static let shared = SettingsManager()
    
    private init() {
    }
    
    var pauseNameItem: SettingsItemStringWrapper {
        SettingsItemStringWrapper(for: settings.getItem(.pauseName))
    }
    
    var pauseDurationItem: SettingsItemIntWrapper {
        SettingsItemIntWrapper(for: settings.getItem(.pauseDuration))
    }
    
    var flowAutoFinishItem: SettingsItemBoolWrapper {
        SettingsItemBoolWrapper(for: settings.getItem(.flowAutoFinish))
    }
    
    var flowAutoFinishAfterTimeItem: SettingsItemTimeWrapper {
        SettingsItemTimeWrapper(for: settings.getItem(.flowAutoFinishAfterTime))
    }
    
    var tabataWarmUpDurationItem: SettingsItemIntWrapper {
        SettingsItemIntWrapper(for: settings.getItem(.tabataWarmUpDuration))
    }
    
    var tabataActivityDurationItem: SettingsItemIntWrapper {
        SettingsItemIntWrapper(for: settings.getItem(.tabataActivityDuration))
    }
    
    var tabataRestDurationItem: SettingsItemIntWrapper {
        SettingsItemIntWrapper(for: settings.getItem(.tabataRestDuration))
    }
    
    var tabataCoolDownDurationItem: SettingsItemIntWrapper {
        SettingsItemIntWrapper(for: settings.getItem(.tabataCoolDownDuration))
    }
    
    var tabataCyclesItem: SettingsItemIntWrapper {
        SettingsItemIntWrapper(for: settings.getItem(.tabataCycles))
    }
    
    var tabataExerciseDuration: Int {
        tabataActivityDurationItem.value + (tabataActivityDurationItem.value + tabataRestDurationItem.value) * tabataCyclesItem.value + tabataCoolDownDurationItem.value
    }
    
    func saveSettings() {
        settings.save()
    }
    
    func resetToDefauls() {
        settings.resetToDefauls()
    }
    
    func resetToDefauls(subgroup: SettingsSubGroup) {
        settings.resetToDefauls(subgroup: subgroup)
    }
}

class Settings: ObservableObject {
    
    typealias SettingsType = Dictionary<SettingsSubGroup, [SettingsItem]>
    var groups: SettingsType
    
    static private let saveKey = "settingsNew"
    
    static private let defaults: SettingsType = [
        .tabata: [.defaultTabataWarmUpDuration, .defaultTabataActivityDuration, .defaultTabataRestDuration, .defaultTabataCoolDownDuration, .defaultTabataCycles],
        .flow: [.defaultFlowAutoFinish, .defaultFlowAutoFinishAfterTime],
        .pause: [.defaultPauseName, .defaultPauseDuration]
    ]
    
    private var defaults: SettingsType {
        return Self.defaults.mapValues { $0.map { item in SettingsItem(from: item)} }
    }
    
    fileprivate init() {
        //UserDefaults.standard.removeObject(forKey: "settings")
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
        let items = groups.flatMap{ $1 }
        let item = items.first(where: { $0.name == name})
        guard let item = item else {
            fatalError("Error getting value of \(name)")
        }
        return item
    }
    
    fileprivate func resetToDefauls(subgroup: SettingsSubGroup) {
        guard let _ = groups[subgroup] else {
            return
        }
        
        guard let defaultGroup = defaults[subgroup] else {
            return
        }
        
        groups[subgroup] = defaultGroup
    }
    
    fileprivate func resetToDefauls() {
        groups = defaults
    }
}
