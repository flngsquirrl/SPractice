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
    var usePauses: Bool
    private var templateExercises = [ExerciseTemplate]()
    
    init(from template: ProgramTemplate) {
        self.init(name: template.name, usePauses: template.usePauses, exercises: template.exercises)
    }
    
    init(id: UUID = UUID(), name: String = "", usePauses: Bool = false, exercises: [ExerciseTemplate] = []) {
        self.id = id
        self.name = name
        self.usePauses = usePauses
        self.templateExercises = exercises
    }
    
    var exercises: [ExerciseTemplate] {
        get {
            guard usePauses else {
                return templateExercises
            }

            var all = [ExerciseTemplate]()
            for (index, exercise) in templateExercises.enumerated() {
                let exercise = ExerciseTemplate(from: exercise)
                all.append(exercise)

                if usePauses && index != templateExercises.count - 1 {
                    all.append(ExerciseTemplate.pauseTemplate)
                }
            }
            return all
        }
    }
    
    // examples
    static let personal = PreparedProgram(from: ProgramTemplate.personal)
}
