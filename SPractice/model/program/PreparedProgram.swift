//
//  PreparedProgram.swift
//  SPractice
//
//  Created by Yuliya Charniak on 17.07.22.
//

import Foundation

struct PreparedProgram: Program, Named, Identifiable {
    
    let template: ProgramTemplate
    let countPauses: Bool
    
    var id: UUID {
        template.id
    }
    var name: String {
        template.name
    }
    var description: String {
        template.description
    }
    
    var exercises: [ExerciseTemplate] {
        if countPauses {
            return template.exercises
        } else {
            return template.templateExercises
        }
    }
    
    var isExample: Bool {
        template.isExample
    }
    
    init(from template: ProgramTemplate, countPauses: Bool = false) {
        self.template = template
        self.countPauses = countPauses
    }
    
}
