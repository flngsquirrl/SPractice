//
//  Settings.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.05.22.
//

import Foundation
import SwiftUI

class Settings: ObservableObject {
    
    @Published var items: [SettingsItem]
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "settings") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode(Array<SettingsItem>.self, from: savedItems) {
                items = decoded
                return
            }
        }
        
        items = Settings.defaults
    }
    
    static let defaults: [SettingsItem] = [SettingsItem(type: .tabata_warmup, value: 10),
                                           SettingsItem(type: .tabata_activity, value: 20),
                                           SettingsItem(type: .tabata_rest, value: 10),
                                           SettingsItem(type: .tabata_cooldown, value: 10),
                                           SettingsItem(type: .tabata_cycles, value: 8),
                                           SettingsItem(type: .general_rest, value: 10)]
    
    func getItem(withType type: SettingsItemType) -> SettingsItem? {
        items.first(where: {$0.type == type})
    }
    
    func save() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "settings")
        }
    }
    
    func restoreDefaults() {
        items = Settings.defaults
    }
}
