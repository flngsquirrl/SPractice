//
//  PracticeSettings-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.08.22.
//

import Foundation

extension PracticeSettingsView {
    @MainActor class ViewModel: ObservableObject {

        let manager = PracticeSettingsManager()

        var template: ProgramTemplate
        @Published var settings: PracticeSettings

        init(for template: ProgramTemplate) {
            self.template = template
            self.settings = manager.getSettings(for: template.id)
        }

        func savePracticeSettings() {
            manager.updateOrAdd(settings)
        }

        var hasChangedSettings: Bool {
            let baseSettings = manager.getSettings(for: template.id)
            return settings != baseSettings
        }

        func applyNewSettings() {
            savePracticeSettings()
        }
    }
}
