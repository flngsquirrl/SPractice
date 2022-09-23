//
//  ExerciseValidator.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import Foundation

class ExerciseValidator: TemplateValidator {

    private func isValidTimer(_ template: ExerciseTemplate) -> Bool {
        if !template.isService {
            return template.duration != .unknown
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
            return isValidTimer(template)
        }

        return true
    }
}
