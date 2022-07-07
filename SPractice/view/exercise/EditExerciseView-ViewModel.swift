//
//  EditExerciseView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import Foundation

extension EditExerciseView {
    @MainActor class ViewModel: ObservableObject {
        @Published var template: ExerciseEditor.EditorTemplate
        
        init(template: ExerciseTemplate) {
            self.template = ExerciseEditor.EditorTemplate(from: template)
        }
        
        var templateToSave: ExerciseTemplate {
            template.exercise
        }
        
        var isSaveDisabled: Bool {
            !ValidationService.isValid(template.exercise)
        }
    }
}
