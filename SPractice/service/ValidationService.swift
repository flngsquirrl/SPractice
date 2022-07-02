//
//  ValidationService.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import Foundation

struct ValidationService {
    
    static func isValid(_ template: ExerciseTemplate) -> Bool {
        isValidName(of: template)
    }
    
    static func isValidName(of template: ExerciseTemplate) -> Bool {
        template.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
