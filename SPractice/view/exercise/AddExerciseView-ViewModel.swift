//
//  AddExerciseView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import Foundation

extension AddExerciseView {
    @MainActor class ViewModel: ObservableObject {
        @Published var template = ExerciseTemplate.template
        
        var templateToAdd: ExerciseTemplate {
            ExerciseTemplate(from: template)
        }
        
        var isTemplateValid: Bool {
            ValidationService.isValid(template)
        }
    }
}
