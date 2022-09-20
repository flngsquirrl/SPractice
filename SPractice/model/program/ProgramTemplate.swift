//
//  ProgramTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ProgramTemplate: Program, Created, ExampleItem, Codable, Hashable {

    var id: UUID
    var name: String
    var description: String

    var exercises = [ExerciseTemplate]()

    var isExample: Bool
    var exampleId: String?

    private(set) var creationDate: Date

    private init(id: UUID = UUID(), name: String = "", description: String = "", exercises: [ExerciseTemplate] = [],
                 isExample: Bool = false, exampleId: String? = nil) {
        self.id = id
        self.name = name.trim()
        self.description = description.trim()

        self.exercises = exercises

        self.isExample = isExample
        self.exampleId = exampleId

        self.creationDate = Date.now
    }

    init(from template: ProgramTemplate) {
        self.init(name: template.name, description: template.description,
                  exercises: template.exercises, isExample: template.isExample, exampleId: template.exampleId)
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
        [simpleYoga, simpleWorkout]
    }

    static let simpleYoga = ProgramTemplate(name: "Simple yoga", description: "Demo yoga program",
                                        exercises: [.getTemplate(from: .catCow), .getTemplate(from: .surjaNamascarA),
                                                    .getTemplate(from: .balasana), .getTemplate(from: .vasihsthasana),
                                                    ExerciseTemplate.getTemplate(from: .shavasana)],
                                        isExample: true, exampleId: ProgramExampleId.simpleYoga.rawValue)

    static let simpleWorkout = ProgramTemplate(name: "Simple workout", description: "Demo workout program",
                                               exercises: [.getTemplate(from: .plank), .getTemplate(from: .squats),
                                                           .getTemplate(from: .jumpRope)],
                                        isExample: true, exampleId: ProgramExampleId.simpleWorkout.rawValue)
}
