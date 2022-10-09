//
//  PracticeSettingsManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 22.08.22.
//

import Foundation

class PracticeSettingsManager: JsonPersistentDataManager<PracticeSettings> {

    override func getFileName() -> String {
        "PracticeSettings"
    }

    func getSettings(for programId: UUID) -> PracticeSettings {
        let setting = list().first { $0.id == programId }
        if let setting = setting {
            return setting
        } else {
            return PracticeSettings(programId: programId)
        }
    }

    func areRestIntervalsUsed(for programId: UUID) -> Bool {
        let setting = list().first { $0.id == programId }
        if let setting = setting {
            return setting.addRestIntervals
        }
        return false
    }

    func arePausesUsed(for programId: UUID) -> Bool {
        let setting = list().first { $0.id == programId }
        if let setting = setting {
            return setting.pauseAfterExercise
        }
        return false
    }
}
