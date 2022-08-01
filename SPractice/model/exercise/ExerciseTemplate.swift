//
//  ExerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ExerciseTemplate: Exercise, Hashable, Codable {
    
    private(set) var id: UUID
    private(set) var type: ExerciseType?
    var name: String
    private(set) var description: String
    private(set) var intensity: Intensity? // not set when type not set
    private(set) var duration: Duration
    private(set) var isService: Bool
    
    private(set) var isExample: Bool
    private(set) var exampleId: ExerciseExampleId?
    
    private init(id: UUID = UUID(), type: ExerciseType? = nil, name: String = "", description: String = "", isService: Bool = false, intensity: Intensity? = .activity, duration: Duration = .unknown, isExample: Bool = false, exampleId: ExerciseExampleId? = nil) {
        self.id = id
        self.type = type
        self.name = name.trim()
        self.description = description.trim()
        self.type = type
        self.isService = isService
        self.duration = duration
        self.intensity = intensity
        
        self.isExample = isExample
        if isExample {
            self.exampleId = exampleId
        }
        
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
    
    /** the result has an id different from the source */
    init<T>(from template: T, changeId: Bool = true) where T: Exercise {
        self.init(id: changeId ? UUID() : template.id, type: template.type, name: template.name, description: template.description, isService: template.isService, intensity: template.intensity, duration: template.duration)
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
    
    // examples
    static let catCow = ExerciseTemplate(type: .timer, name: "Cat-Cow", description: "Gently change between two poses warming the body and bringing flexibility to the spine", intensity: .activity, duration: .known(90), isExample: true, exampleId: .catCow)
    static let balasana = ExerciseTemplate(type: .timer, name: "Balasana", description: "Child pose with the forehead on the mat", intensity: .rest, duration: .known(30), isExample: true, exampleId: .balasana)
    static let surjaNamascarA = ExerciseTemplate(type: .flow, name: "Surja Namascar A", description: "Sun Salutation, start in Tadasana, go for at least five cycles", intensity: .activity, duration: .unlimited, isExample: true, exampleId: .surjaNamascarA)
    static let vasihsthasana = ExerciseTemplate(type: .tabata, name: "Vasihsthasana", description: "Side plank on the straight arm or on the elbow",  duration: .unknown, isExample: true, exampleId: .vasihsthasana)
    static let shavasana = ExerciseTemplate(type: .flow, name: "Shavasana", description: "Relax all your body lying on the back with arms and legs on the floor", intensity: .rest, duration: .unknown, isExample: true, exampleId: .shavasana)
    static let catCowNoDuration = ExerciseTemplate(type: .timer, name: "Cat-Cow", intensity: .activity, duration: .unknown)
    static let catCowNoType = ExerciseTemplate(name: "Cat-Cow")
}
