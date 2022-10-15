//
//  ExerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ExerciseTemplate: ExampleExercise, Created, ExampleItem, Hashable, Codable {

    let id: UUID
    var type: ExerciseType?
    var name: String
    var description: String
    var intensity: Intensity? // not set when type not set
    var duration: Duration?
    private(set) var isService: Bool

    var isExample: Bool
    private(set) var exampleId: String?

    var creationDate: Date

    init(id: UUID = UUID(), type: ExerciseType? = nil, name: String = "", description: String = "", isService: Bool = false,
         intensity: Intensity? = nil, duration: Duration? = nil, isExample: Bool = false, exampleId: String? = nil) {
        self.id = id
        self.type = type
        self.name = name.trim()
        self.description = description.trim()
        self.type = type
        self.isService = isService
        self.duration = duration
        self.intensity = intensity

        self.isExample = isExample
        self.exampleId = exampleId

        self.creationDate = Date.now

        normalize()
    }

    mutating func normalize() {
        if let type = type {
            switch type {
            case .flow:
                self.duration = .unlimited
                self.isService = false
            case .timer:
                guard case .known = duration else {
                    self.duration = .known(0)
                    return
                }
                if isService {
                    self.name = ""
                    self.duration = .setting
                }
            case .tabata:
                self.duration = .setting
                self.isService = false
                self.intensity = .mixed
            }
        } else {
            self.intensity = nil
            self.duration = nil
            self.isService = false
        }
    }

    mutating func update<T: Exercise>(from template: T) {
        self.type = template.type
        self.name = template.name
        self.description = template.description
        self.intensity = template.intensity
        self.duration = template.duration
        self.isService = template.isService
    }

    init<T: Exercise>(from template: T) {
        self.init(type: template.type, name: template.name, description: template.description,
                  isService: template.isService, intensity: template.intensity, duration: template.duration)
    }

    static func getTemplate(from example: ExerciseTemplate) -> ExerciseTemplate {
        return ExerciseTemplate(from: example)
    }

    static var restTemplate: ExerciseTemplate {
        return ExerciseTemplate(type: .timer, isService: true, intensity: .rest)
    }

    static var template: ExerciseTemplate {
        ExerciseTemplate(type: .flow, intensity: .activity)
    }

    func isEqualTo(exercise: ExerciseTemplate) -> Bool {
        self.name == exercise.name &&
        self.type == exercise.type &&
        self.description == exercise.description &&
        self.intensity == exercise.intensity &&
        self.duration == exercise.duration &&
        self.isService == exercise.isService
    }

    func isEqualToExample(example: ExerciseTemplate) -> Bool {
        self.isEqualTo(exercise: example) &&
        self.isExample == example.isExample &&
        self.exampleId == example.exampleId
    }

    mutating func resetToExample(example: ExerciseTemplate) {
        self.name = example.name
        self.type = example.type
        self.description = example.description
        self.intensity = example.intensity
        self.duration = example.duration

        self.isExample = example.isExample
    }
}

// app examples
extension ExerciseTemplate {

    static let catCow = ExerciseTemplate(type: .timer, name: "Cat-Cow",
                                         description: "Gently change between two poses warming the body and bringing flexibility to the spine",
                                         intensity: .activity, duration: .known(90), isExample: true,
                                         exampleId: ExerciseExampleId.catCow.rawValue)

    static let balasana = ExerciseTemplate(type: .timer, name: "Balasana",
                                           description: "Child pose with the forehead on the mat",
                                           intensity: .rest, duration: .known(30), isExample: true,
                                           exampleId: ExerciseExampleId.balasana.rawValue)

    static let surjaNamascarA = ExerciseTemplate(type: .flow, name: "Surja Namascar A",
                                                 description: "Sun Salutation, start in Tadasana, go for at least 5 cycles",
                                                 intensity: .activity, duration: .unlimited, isExample: true,
                                                 exampleId: ExerciseExampleId.surjaNamascarA.rawValue)
    static let vasisthasana = ExerciseTemplate(type: .tabata, name: "Vasisthasana",
                                                description: "Side plank on the straight arm or on the elbow",
                                                isExample: true, exampleId: ExerciseExampleId.vasisthasana.rawValue)

    static let shavasana = ExerciseTemplate(type: .flow, name: "Shavasana",
                                            description: "Relax all your body lying on the back with arms and legs on the floor",
                                            intensity: .rest, duration: .unlimited, isExample: true,
                                            exampleId: ExerciseExampleId.shavasana.rawValue)

    static let plank = ExerciseTemplate(type: .tabata, name: "Plank (dynamic)",
                                        description: "Begin in high plank, lift one hand, move it to the body, place the hand back on the floor,"
                                        + " repeat changing sides",
                                        isExample: true, exampleId: ExerciseExampleId.plank.rawValue)

    static let squats = ExerciseTemplate(type: .flow, name: "Squats",
                                         description: "Send your hips back as if you’re sitting into an invisible chair,"
                                         + " keep the heels down and the chest lifted; repeat 50 times",
                                         intensity: .activity, duration: .unlimited, isExample: true,
                                         exampleId: ExerciseExampleId.squats.rawValue)

    static let jumpRope = ExerciseTemplate(type: .timer, name: "Jump rope",
                                         description: "Just keep jumping",
                                         intensity: .activity, duration: .known(120), isExample: true,
                                         exampleId: ExerciseExampleId.jumpRope.rawValue)
}

// internal examples
extension ExerciseTemplate {

    static let catCowNoDuration = ExerciseTemplate(type: .timer, name: "Cat-Cow", intensity: .activity, duration: .known(0))
    static let catCowNoType = ExerciseTemplate(name: "Cat-Cow")
}
