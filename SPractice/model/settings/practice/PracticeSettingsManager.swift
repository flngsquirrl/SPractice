//
//  PracticeSettingsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 22.08.22.
//

import Foundation

@MainActor class PracticeSettingsManager: PersistentDataManager {

    static var shared = PracticeSettingsManager()

    var items: [PracticeSettings]
    let saveKey = "practiceSettings"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([PracticeSettings].self, from: data) {
                items = decoded
                return
            }
        }
        items = []
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    func getSettings(for programId: UUID) -> PracticeSettings {
        let setting = items.first { $0.id == programId }
        if let setting = setting {
            return setting
        } else {
            return PracticeSettings(programId: programId)
        }
    }

    func areRestIntervalsUsed(for programId: UUID) -> Bool {
        let setting = items.first { $0.id == programId }
        if let setting = setting {
            return setting.addRestIntervals
        }
        return false
    }

    func arePausesUsed(for programId: UUID) -> Bool {
        let setting = items.first { $0.id == programId }
        if let setting = setting {
            return setting.pauseAfterExercise
        }
        return false
    }
}
