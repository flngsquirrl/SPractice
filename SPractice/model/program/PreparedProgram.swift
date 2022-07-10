//
//  PreparedProgram.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.07.22.
//

import Foundation

struct PreparedProgram: Program {
    
    var id: UUID
    var name: String
    var useRest: Bool
    private var templateExercises = [ExerciseTemplate]()
    
    init(from template: ProgramTemplate) {
        self.init(name: template.name, useRest: template.useRest, exercises: template.exercises)
    }
    
    init(id: UUID = UUID(), name: String = "", useRest: Bool = false, exercises: [ExerciseTemplate] = []) {
        self.id = id
        self.name = name
        self.useRest = useRest
        self.templateExercises = exercises
    }
    
    var exercises: [ExerciseTemplate] {
        get {
            guard useRest else {
                return templateExercises
            }

            var all = [ExerciseTemplate]()
            for (index, exercise) in templateExercises.enumerated() {
                let exercise = ExerciseTemplate(from: exercise)
                all.append(exercise)

                if useRest && index != templateExercises.count - 1 {
                    all.append(ExerciseTemplate.restTemplate)
                }
            }
            return all
        }
    }
    
    // examples
    static let personal = PreparedProgram(from: ProgramTemplate.personal)
}
