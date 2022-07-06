//
//  ProgramTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ProgramTemplate: Program, Identifiable, Codable {
    
    var id: UUID
    var name: String
    var useRest: Bool
    private var templateExercises = [ExerciseTemplate]()
    
    init(id: UUID = UUID(), name: String = "", useRest: Bool = false, exercises: [ExerciseTemplate] = []) {
        self.id = id
        self.name = name
        self.useRest = useRest
        self.templateExercises = exercises
    }
    
    init(from template: ProgramTemplate) {
        self.init(name: template.name, useRest: template.useRest, exercises: template.templateExercises)
    }
    
    var hasExercises: Bool {
        !templateExercises.isEmpty
    }
    
    var exercises: [ExerciseTemplate] {
        get {
            guard useRest else {
                return templateExercises
            }
            
            var exercises = [ExerciseTemplate]()
            for (index, exercise) in templateExercises.enumerated() {
                let exercise = ExerciseTemplate(from: exercise)
                exercises.append(exercise)
                
                if useRest && index != templateExercises.count - 1 {
                    exercises.append(ExerciseTemplate.restTemplate)
                }
            }
            return exercises
        }
        
        set {
            templateExercises = newValue
        }
    }
    
    static var template: ProgramTemplate {
        ProgramTemplate()
    }
    
    // examples
    static let personal = ProgramTemplate(name: "Personal", exercises: [ExerciseTemplate.catCow, ExerciseTemplate.surjaNamascar, ExerciseTemplate.vasihsthasana])
    static let dailyShort = ProgramTemplate(name: "Daily short", exercises: [ExerciseTemplate.concentration, ExerciseTemplate.catCow])
    static let shortForBack = ProgramTemplate(name: "Short for back", exercises: [ExerciseTemplate.catCow])
}
