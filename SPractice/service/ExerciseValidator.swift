//
//  ExerciseValidator.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import Foundation

struct ExerciseValidator: TemplateValidator {

    private func isTimerValidToPractice(_ template: ExerciseTemplate) -> Bool {
        if !template.isService {
            if case .known(let time) = template.duration {
                return time != 0
            }
        }
        return true
    }

    func isValid(_ template: ExerciseTemplate) -> Bool {
        isNameValid(of: template)
    }

    func isValidToPractice(_ template: ExerciseTemplate) -> Bool {
        guard template.isTypeSet else {
            return false
        }

        if template.isTimer {
            return isTimerValidToPractice(template)
        }

        return true
    }
}
