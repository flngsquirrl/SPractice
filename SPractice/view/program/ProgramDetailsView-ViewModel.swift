//
//  ProgramDetailsView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import Foundation

extension ProgramDetailsView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var template: ProgramTemplate
        
        @Published var showPracticeView = false
        @Published var showEditTemplateView = false

        @Published var practiceSettings: PracticeSettings
        
        init(for template: ProgramTemplate) {
            self.template = template
            self.practiceSettings = PracticeSettingsManager.shared.getSettings(for: template.id)
        }
        
        func updateProgramTemplate(template: ProgramTemplate) {
            self.template = template
        }
        
        var isPracticeDisabled: Bool {
            !ValidationService.isValidToPractice(template: template)
        }
        
        var isUsePausesDisabled: Bool {
            template.exercises.count == 1
        }

        var hasMultipleExercises: Bool {
            template.exercises.count > 1
        }

        func updatePracticeSettings() {
            PracticeSettingsManager.shared.updateOrAdd(practiceSettings)
        }

        var practiceProgram: PracticeProgram {
            PracticeProgram(for: template, useRest: practiceSettings.addRestIntervals)
        }
    }
}
