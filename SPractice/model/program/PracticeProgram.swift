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
    let baseExercises: [PracticeExercise]

    var useRest: Bool
    
    let isExample: Bool
    var exampleId: String?
    
    init(from template: ProgramTemplate, useRest: Bool = false) {
        self.name = template.name.trim()
        self.description = template.description.trim()
        
        var baseExercises = [PracticeExercise]()
        for exerciseTemplate in template.exercises {
            let exercise = PracticeExercise(from: exerciseTemplate)
            baseExercises.append(exercise!)
        }
        self.baseExercises = baseExercises

        self.useRest = useRest

        self.isExample = template.isExample
        self.exampleId = template.exampleId
    }

    var exercises: [PracticeExercise] {
        if !useRest {
            return baseExercises
        }
        
        var all = [PracticeExercise]()
        for (index, exercise) in baseExercises.enumerated() {
            all.append(exercise)
            if index != baseExercises.count - 1 {
                let pause = PracticeExercise(from: ExerciseTemplate.pauseTemplate)
                all.append(pause!)
            }
        }
        return all
    }
    
    // examples
    static let personal = PracticeProgram(from: ProgramTemplate.personal)
}
