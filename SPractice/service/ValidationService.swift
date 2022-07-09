//
//  ValidationService.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import Foundation

struct ValidationService {
    
    static func isValidForPractice(_ template: ExerciseTemplate) -> Bool {
        guard template.isTypeSet else {
            return false
        }
        
        if template.isTimer {
            return isValidTimer(template)
        }
        
        return true
    }
    
    private static func isValidTimer(_ template: ExerciseTemplate) -> Bool {
        template.duration != .unknown
    }
    
    static func isValid(_ template: ExerciseTemplate) -> Bool {
        isNameValid(of: template)
    }
    
    static func isNameValid(of template: ExerciseTemplate) -> Bool {
        isNameValid(template.name)
    }
    
    static func isValid(_ template: ProgramTemplate) -> Bool {
        isNameValid(of: template) && areExercisesValid(of: template)
    }
    
    static func isNameValid(of template: ProgramTemplate) -> Bool {
        isNameValid(template.name)
    }
    
    static func isNameValid(_ name: String) -> Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    static func areExercisesValid(of template: ProgramTemplate) -> Bool {
        !template.exercises.isEmpty
    }
    
    static func isValidToPractice(template: ProgramTemplate) -> Bool {
        !template.hasExercisesMissingDuration && !template.hasExercisesWithoutType
    }
}
