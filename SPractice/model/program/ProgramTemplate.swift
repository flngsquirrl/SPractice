//
//  ProgramTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ProgramTemplate: Program, Named, Identifiable, Codable {
    var id: UUID
    var name: String
    var description: String
    var usePauses: Bool
    var templateExercises = [ExerciseTemplate]()
    
    private init(id: UUID = UUID(), name: String = "", description: String = "", usePauses: Bool = false, exercises: [ExerciseTemplate] = []) {
        self.id = id
        self.name = name.trim()
        self.description = description.trim()
        self.usePauses = usePauses
        self.templateExercises = exercises
    }
    
    init(from template: ProgramTemplate) {
        self.init(name: template.name, description: template.description, usePauses: template.usePauses, exercises: template.templateExercises)
    }
    
    var exercises: [ExerciseTemplate] {
        get {
            guard usePauses else {
                return templateExercises
            }

            var all = [ExerciseTemplate]()
            for (index, exercise) in templateExercises.enumerated() {
                all.append(exercise)

                if usePauses && index != templateExercises.count - 1 {
                    all.append(ExerciseTemplate.pauseTemplate)
                }
            }
            return all
        }
    }
    
    static var template: ProgramTemplate {
        ProgramTemplate()
    }
    
    // examples
    static let personal = ProgramTemplate(name: "Personal", description: "Do once or twice a week", exercises: [.catCow, .surjaNamascarA, .vasihsthasana, .shavasana])
    static let dailyShort = ProgramTemplate(name: "Daily short", description: "Simple short practice for every day", exercises: [.catCow, .surjaNamascarA, .shavasana])
    static let shortForBack = ProgramTemplate(name: "Short for back", exercises: [.catCow])
}
