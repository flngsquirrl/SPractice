//
//  Settings.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.05.22.
//

import Foundation
import SwiftUI

class Settings {
    
    var items: [SettingsItem] = []
    
    static private let defaults: [SettingsItem] = [SettingsItem(type: .tabata_warmup, value: 10),
                                                   SettingsItem(type: .tabata_activity, value: 20),
                                                   SettingsItem(type: .tabata_rest, value: 10),
                                                   SettingsItem(type: .tabata_cooldown, value: 10),
                                                   SettingsItem(type: .tabata_repetitions, value: 8),
                                                   SettingsItem(type: .general_rest, value: 10)]
    
    init() {
        //UserDefaults.standard.removeObject(forKey: "settings")
        if let savedItems = UserDefaults.standard.data(forKey: "settings") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode(Array<SettingsItem>.self, from: savedItems) {
                items = decoded
                return
            }
        }
        
        items = getDefaults()
    }
    
    func getItem(with type: SettingsItem.SettingsType) -> SettingsItem {
        guard let item = items.first(where: {$0.type == type}) else {
            fatalError("Reading the setting of type \(type) has failed")
        }
        return item
    }
    
    func save() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "settings")
        }
    }
    
    func restoreDefaults() {
        for item in items {
            let defaultItem = Settings.defaults.first(where: {$0.type == item.type})
            if let defaultItem = defaultItem {
                item.value = defaultItem.value
            }
        }
    }
    
    func getDefaults() -> [SettingsItem] {
        var result: [SettingsItem] = []
        for item in Settings.defaults {
            result.append(SettingsItem(from: item))
        }
        return result
    }
}
