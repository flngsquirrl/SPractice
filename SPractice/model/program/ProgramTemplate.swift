//
//  ProgramTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ProgramTemplate: Program, Codable {
    var id: UUID
    var name: String
    var description: String
    var usePauses: Bool
    var templateExercises = [ExerciseTemplate]()
    
    var isExample: Bool
    var exampleId: ProgramExampleId?
    
    private init(id: UUID = UUID(), name: String = "", description: String = "", usePauses: Bool = false, exercises: [ExerciseTemplate] = [], isExample: Bool = false, exampleId: ProgramExampleId? = nil) {
        self.id = id
        self.name = name.trim()
        self.description = description.trim()
        self.usePauses = usePauses
        self.templateExercises = exercises
        
        self.isExample = isExample
        if isExample {
            self.exampleId = exampleId
        }
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
    
    func isEqualToExample(example: ProgramTemplate) -> Bool {
        self.name == example.name &&
        self.description == example.description &&
        self.isExample == example.isExample &&
        self.exampleId == example.exampleId
    }
    
    // examples
    static let simple = ProgramTemplate(name: "Simple", description: "An example demo practice", exercises: [.catCow, .surjaNamascarA, .balasana, .vasihsthasana, .shavasana], isExample: true, exampleId: .simple)
    static let personal = ProgramTemplate(name: "Personal", description: "Practice once or twice a week", exercises: [.catCow, .surjaNamascarA, .vasihsthasana, .shavasana])
    static let dailyShort = ProgramTemplate(name: "Daily short", description: "Simple short practice for every day", exercises: [.catCow, .surjaNamascarA, .shavasana])
    static let shortForBack = ProgramTemplate(name: "Short for back", exercises: [.catCow])
}
