//
//  ExerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ExerciseTemplate: Exercise, Named, Hashable, Codable {
    
    private(set) var id: UUID
    private(set) var type: ExerciseType?
    private(set) var name: String
    private(set) var description: String
    private(set) var intensity: Intensity? // not set when type not set
    private(set) var duration: Duration
    private(set) var isService: Bool
    
    private init(id: UUID = UUID(), type: ExerciseType? = nil, name: String = "", description: String = "", isService: Bool = false, intensity: Intensity? = .activity, duration: Duration = .unknown) {
        self.id = id
        self.type = type
        self.name = name.trim()
        self.description = description.trim()
        self.type = type
        self.isService = isService
        self.duration = duration
        self.intensity = intensity
        
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
    }
    
    /** the result has an id different from the source */
    init<T>(from template: T, changeId: Bool = true) where T: Exercise {
        self.init(id: changeId ? UUID() : template.id, type: template.type, name: template.name, description: template.description, isService: template.isService, intensity: template.intensity, duration: template.duration)
    }
    
    var exerciseType: ExerciseType? {
        return type
    }
    
    static var pauseTemplate: ExerciseTemplate {
        let name = SettingsManager.pauseName
        let duration: Duration = .known(SettingsManager.pauseDurationItem.value)
        return ExerciseTemplate(type: .timer, name: name, isService: true, intensity: .rest, duration: duration)
    }
    
    static var template: ExerciseTemplate {
        ExerciseTemplate(type: .flow)
    }
    
    // examples
    static let catCow = ExerciseTemplate(type: .timer, name: "Cat-Cow", description: "Gently change between two poses warming the body and bringing flexibility to the spine", intensity: .activity, duration: .known(90))
    static let balasana = ExerciseTemplate(type: .flow, name: "Balasana", description: "Child pose with the forehead on the mat", intensity: .rest, duration: .unlimited)
    static let surjaNamascarA = ExerciseTemplate(type: .flow, name: "Surja Namascar A", description: "Sun Salutation, start in Tadasana, go for at least five cycles", intensity: .activity, duration: .unlimited)
    static let vasihsthasana = ExerciseTemplate(type: .tabata, name: "Vasihsthasana", description: "Side plank on the straight arm or on the elbow",  duration: .unknown)
    static let shavasana = ExerciseTemplate(type: .timer, name: "Shavasana", description: "Relax all your body lying on the back with arms and legs on the floor", intensity: .rest, duration: .known(600))
    static let catCowNoDuration = ExerciseTemplate(type: .timer, name: "Cat-Cow", intensity: .activity, duration: .unknown)
    static let catCowNoType = ExerciseTemplate(name: "Cat-Cow")
}
