//
//  PracticeProgram.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct PracticeProgram: Program {
    
    let id = UUID()
    let name: String
    let description: String
    let exercises: [PracticeExercise]
    
    let isExample: Bool
    
    init(from template: ProgramTemplate) {
        self.name = template.name.trim()
        self.description = template.description.trim()
        
        var exercises = [PracticeExercise]()
        for exerciseTemplate in template.exercises {
            let exercise = PracticeExercise(from: exerciseTemplate)
            exercises.append(exercise!)
        }
        self.exercises = exercises
        self.isExample = template.isExample
    }
    
    // examples
    static let personal = PracticeProgram(from: ProgramTemplate.personal)
}
