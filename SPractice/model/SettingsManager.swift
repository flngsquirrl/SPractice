//
//  SettingsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.06.22.
//

import Foundation

class SettingsManager {
    
    private var settings = Settings()
    
    static let shared = SettingsManager()
    
    private init() {
    }
    
    func getSettings() -> Settings {
        return settings
    }
    
    func getValue(of type: SettingsItem.SettingsType) -> Int {
        guard let item = settings.items.first(where: {$0.type == type}) else {
            fatalError("Reading the setting of type \(type) has failed")
        }
        return item.value
    }
    
    var tabataExerciseDuration: Int {
        getValue(of: .tabata_warmup) + (getValue(of: .tabata_activity) + getValue(of: .tabata_rest)) * getValue(of: .tabata_repetitions) + getValue(of: .tabata_cooldown)
    }
}
