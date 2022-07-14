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
    private(set) var intensity: Intensity? // not set when type not set
    private(set) var duration: Duration
    private(set) var isService: Bool
    
    private init(id: UUID = UUID(), type: ExerciseType? = nil, name: String = "", isService: Bool = false, intensity: Intensity? = .activity, duration: Duration = .unknown) {
        self.id = id
        self.type = type
        self.name = name
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
        self.init(id: changeId ? UUID() : template.id, type: template.type, name: template.name, isService: template.isService, intensity: template.intensity, duration: template.duration)
    }
    
    var exerciseType: ExerciseType? {
        return type
    }
    
    static var pauseTemplate: ExerciseTemplate {
        let name = SettingsManager.pauseNameItem.value
        let duration: Duration = .known(SettingsManager.pauseDurationItem.value)
        return ExerciseTemplate(type: .timer, name: name, isService: true, intensity: .rest, duration: duration)
    }
    
    static var template: ExerciseTemplate {
        ExerciseTemplate(type: .flow)
    }
    
    // examples
    static let catCow = ExerciseTemplate(type: .timer, name: "Cat-Cow", intensity: .activity, duration: .known(90))
    static let balasana = ExerciseTemplate(type: .flow, name: "Balasana", intensity: .rest, duration: .unlimited)
    static let surjaNamascar = ExerciseTemplate(type: .flow, name: "Surja Namascar", intensity: .activity, duration: .unlimited)
    static let vasihsthasana = ExerciseTemplate(type: .tabata, name: "Vasihsthasana", duration: .unknown)
    static let concentration = ExerciseTemplate(type: .timer, name: "Concentration", intensity: .activity, duration: .known(360))
    static let catCowNoDuration = ExerciseTemplate(type: .timer, name: "Cat-Cow", intensity: .activity, duration: .unknown)
    static let catCowNoType = ExerciseTemplate(name: "Cat-Cow")
}
