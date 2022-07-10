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
    let exercises: [PracticeExercise]
    
    init(from template: PreparedProgram) {
        self.name = template.name
        
        var exercises = [PracticeExercise]()
        for exerciseTemplate in template.exercises {
            let exercise = PracticeExercise(from: exerciseTemplate)
            exercises.append(exercise!)
        }
        self.exercises = exercises
    }
    
    // examples
    static let personal = PracticeProgram(from: PreparedProgram.personal)
}
