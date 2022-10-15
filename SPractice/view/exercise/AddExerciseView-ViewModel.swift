//
//  AddExerciseView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import Foundation

extension AddExerciseView {
    @MainActor class ViewModel: ObservableObject {

        @Published var template = ExerciseEditor.EditorTemplate(from: ExerciseTemplate.template)

        let exerciseValidator = ExerciseValidator()

        var templateToAdd: ExerciseTemplate {
            exerciseTemplate
        }

        var exerciseTemplate: ExerciseTemplate {
            ExerciseTemplate(from: template)
        }

        var isAddDisabled: Bool {
            !exerciseValidator.isValid(exerciseTemplate)
        }
    }
}
