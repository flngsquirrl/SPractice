//
//  ExerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ExerciseTemplate: Exercise, HavingCreationDate, ExampleItem, Hashable, Codable {
    
    private(set) var id: UUID
    private(set) var type: ExerciseType?
    private(set) var name: String
    private(set) var description: String
    private(set) var intensity: Intensity? // not set when type not set
    private(set) var duration: Duration
    private(set) var isService: Bool
    
    var isExample: Bool
    private(set) var exampleId: String?
    
    private(set) var creationDate: Date
    
    private init(id: UUID = UUID(), type: ExerciseType? = nil, name: String = "", description: String = "", isService: Bool = false, intensity: Intensity? = .activity, duration: Duration = .unknown, isExample: Bool = false, exampleId: String? = nil) {
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
                if case .known(let seconds) = duration {
                    self.duration = seconds > 0 ? duration : .unknown
                } else {
                    self.duration = .unknown
                }
            case .tabata:
                self.duration = .unknown
                self.isService = false
                self.intensity = .mixed
            }
        } else {
            self.intensity = nil
            self.duration = .unknown
            self.isService = false
        }
        
        if isService {
            self.name = ""
            self.duration = .unknown
        }
    }
    
    init<T>(from template: T, changeId: Bool = true, resetExampleState: Bool = false) where T: Exercise {
        self.init(id: changeId ? UUID() : template.id, type: template.type, name: template.name, description: template.description, isService: template.isService, intensity: template.intensity, duration: template.duration, isExample: resetExampleState ? false : template.isExample, exampleId: template.exampleId)
    }
    
    static func getTemplate(from example: ExerciseTemplate) -> ExerciseTemplate {
        return ExerciseTemplate(type: example.type, name: example.name, description: example.description, isService: example.isService, intensity: example.intensity, duration: example.duration)
    }
    
    var exerciseType: ExerciseType? {
        return type
    }
    
    static var pauseTemplate: ExerciseTemplate {
        return ExerciseTemplate(type: .timer, isService: true, intensity: .rest)
    }
    
    static var template: ExerciseTemplate {
        ExerciseTemplate(type: .flow)
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
        self.isService = example.isService
        
        self.isExample = example.isExample
        self.exampleId = example.exampleId
    }
    
    // examples
    
    static var defaultExamples: [ExerciseTemplate] {
        [catCow, surjaNamascarA, balasana, vasihsthasana, shavasana]
    }
    
    static let catCow = ExerciseTemplate(type: .timer, name: "Cat-Cow", description: "Gently change between two poses warming the body and bringing flexibility to the spine", intensity: .activity, duration: .known(90), isExample: true, exampleId: ExerciseExampleId.catCow.rawValue)
    static let balasana = ExerciseTemplate(type: .timer, name: "Balasana", description: "Child pose with the forehead on the mat", intensity: .rest, duration: .known(30), isExample: true, exampleId: ExerciseExampleId.balasana.rawValue)
    static let surjaNamascarA = ExerciseTemplate(type: .flow, name: "Surja Namascar A", description: "Sun Salutation, start in Tadasana, go for at least five cycles", intensity: .activity, duration: .unlimited, isExample: true, exampleId: ExerciseExampleId.surjaNamascarA.rawValue)
    static let vasihsthasana = ExerciseTemplate(type: .tabata, name: "Vasihsthasana", description: "Side plank on the straight arm or on the elbow",  duration: .unknown, isExample: true, exampleId: ExerciseExampleId.vasihsthasana.rawValue)
    static let shavasana = ExerciseTemplate(type: .flow, name: "Shavasana", description: "Relax all your body lying on the back with arms and legs on the floor", intensity: .rest, duration: .unknown, isExample: true, exampleId: ExerciseExampleId.shavasana.rawValue)
    
    static let catCowNoDuration = ExerciseTemplate(type: .timer, name: "Cat-Cow", intensity: .activity, duration: .unknown)
    static let catCowNoType = ExerciseTemplate(name: "Cat-Cow")
}
