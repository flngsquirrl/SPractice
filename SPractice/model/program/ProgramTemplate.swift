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
    var useRest: Bool
    var exercises = [ExerciseTemplate]()
    
    init(id: UUID = UUID(), name: String = "", useRest: Bool = false, exercises: [ExerciseTemplate] = []) {
        self.id = id
        self.name = name
        self.useRest = useRest
        self.exercises = exercises
    }
    
    init(from template: ProgramTemplate) {
        self.init(name: template.name, useRest: template.useRest, exercises: template.exercises)
    }
    
    var hasExercises: Bool {
        !exercises.isEmpty
    }
    
    var preparedExercises: [ExerciseTemplate] {
        get {
            guard useRest else {
                return exercises
            }
            
            var all = [ExerciseTemplate]()
            for (index, exercise) in exercises.enumerated() {
                let exercise = ExerciseTemplate(from: exercise)
                all.append(exercise)
                
                if useRest && index != exercises.count - 1 {
                    all.append(ExerciseTemplate.restTemplate)
                }
            }
            return all
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
