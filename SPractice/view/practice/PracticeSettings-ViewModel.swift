//
//  PracticeSettings-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.08.22.
//

import Foundation

extension PracticeSettingsView {
    @MainActor class ViewModel: ObservableObject {

        var practice: Practice
        @Published var settings: PracticeSettings

        init(for practice: Practice) {
            self.practice = practice
            self.settings = PracticeSettingsManager.shared.getSettings(for: practice.template.id)
        }

        var hasMultipleExercises: Bool {
            practice.program.exercises.count > 1
        }

        func savePracticeSettings() {
            PracticeSettingsManager.shared.updateOrAdd(settings)
        }

        var hasChangedSettings: Bool {
            let baseSettings = PracticeSettingsManager.shared.getSettings(for: practice.template.id)
            return settings != baseSettings
        }

        var shouldGetConfirmationForApply: Bool {
            return !practice.isFirstExercise || practice.isStarted
        }

        func applyNewSettings() {
            savePracticeSettings()
            practice.reset()
        }
    }
}
