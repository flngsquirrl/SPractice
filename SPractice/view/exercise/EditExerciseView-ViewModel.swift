//
//  EditExerciseView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import Foundation

extension EditExerciseView {
    @MainActor class ViewModel: ObservableObject {
        @Published var template: ExerciseTemplate
        
        init(template: ExerciseTemplate) {
            self.template = template
        }
        
        var templateToSave: ExerciseTemplate {
            template.makeCopy()
        }
        
        var isTemplateValid: Bool {
            ValidationService.isValid(template)
        }
    }
}
