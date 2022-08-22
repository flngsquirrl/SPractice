//
//  ProgramTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ProgramTemplate: Program, HavingCreationDate, ExampleItem, Codable {
    
    var id: UUID
    var name: String
    var description: String

    var exercises = [ExerciseTemplate]()
    
    var isExample: Bool
    var exampleId: String?
    
    private(set) var creationDate: Date
    
    private init(id: UUID = UUID(), name: String = "", description: String = "", exercises: [ExerciseTemplate] = [], isExample: Bool = false, exampleId: String? = nil) {
        self.id = id
        self.name = name.trim()
        self.description = description.trim()

        self.exercises = exercises
        
        self.isExample = isExample
        self.exampleId = exampleId
        
        self.creationDate = Date.now
    }
    
    init(from template: ProgramTemplate) {
        self.init(name: template.name, description: template.description, exercises: template.exercises, isExample: template.isExample, exampleId: template.exampleId)
    }
    
    static var template: ProgramTemplate {
        ProgramTemplate()
    }
    
    func isEqualToExample(example: ProgramTemplate) -> Bool {
        self.name == example.name &&
        self.description == example.description &&
        self.isExample == example.isExample &&
        self.exampleId == example.exampleId &&
        exercisesEqualToExample(example: example)
    }
    
    func exercisesEqualToExample(example: ProgramTemplate) -> Bool {
        guard example.exercises.count == exercises.count else {
            return false
        }
        
        for index in 0..<example.exercises.count {
            let exampleExercise = example.exercises[index]
            let exercise = exercises[index]
            if !exercise.isEqualTo(exercise: exampleExercise) {
                return false
            }
        }
        
        return true
    }
    
    mutating func resetToExample(example: ProgramTemplate) {
        self.name = example.name
        self.description = example.description
        
        self.isExample = example.isExample
        self.exampleId = example.exampleId
        
        self.exercises = example.exercises
    }
    
    // examples
    
    static var defaultExamples: [ProgramTemplate] {
        [simple]
    }
    
    static let simple = ProgramTemplate(name: "Simple", description: "An example demo program", exercises: [ExerciseTemplate.getTemplate(from: .catCow), ExerciseTemplate.getTemplate(from: .surjaNamascarA), ExerciseTemplate.getTemplate(from: .balasana), ExerciseTemplate.getTemplate(from: .vasihsthasana), ExerciseTemplate.getTemplate(from: .shavasana)], isExample: true, exampleId: ProgramExampleId.simple.rawValue)
    
    static let personal = ProgramTemplate(name: "Personal", description: "Your personal program", exercises: [ExerciseTemplate.getTemplate(from: .catCow), ExerciseTemplate.getTemplate(from: .surjaNamascarA), ExerciseTemplate.getTemplate(from: .vasihsthasana), ExerciseTemplate.getTemplate(from: .shavasana)])
    static let dailyShort = ProgramTemplate(name: "Daily short", description: "Simple short everyday", exercises: [ExerciseTemplate.getTemplate(from: .catCow), ExerciseTemplate.getTemplate(from: .surjaNamascarA), ExerciseTemplate.getTemplate(from: .shavasana)])
    static let shortForBack = ProgramTemplate(name: "Short for back", exercises: [ExerciseTemplate.getTemplate(from: .catCow)])
}
