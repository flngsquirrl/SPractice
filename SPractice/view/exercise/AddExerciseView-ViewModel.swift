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
            ExerciseTemplate(from: template.exercise)
        }

        var isAddDisabled: Bool {
            !exerciseValidator.isValid(template.exercise)
        }
    }
}
