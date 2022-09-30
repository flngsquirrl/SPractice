//
//  ProgramValidator.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

struct ProgramValidator: TemplateValidator {

    func isValid(_ template: ProgramTemplate) -> Bool {
        isNameValid(of: template) && areExercisesValid(of: template)
    }

    private func areExercisesValid(of template: ProgramTemplate) -> Bool {
        !template.exercises.isEmpty
    }

    func isValidToPractice(_ template: ProgramTemplate) -> Bool {
        !template.hasExercisesMissingDuration && !template.hasExercisesWithoutType
    }
}
