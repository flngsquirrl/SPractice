//
//  ExerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ExerciseTemplate: Identifiable, Hashable, Codable {
    
    var id: UUID
    var type: ExerciseType?
    var name: String
    var intensityType: Intensity? // not set when type not set
    var duration: Duration
    
    let isService: Bool
    
    private init(id: UUID = UUID(), type: ExerciseType? = nil, name: String = "", isService: Bool = false, intensity: Intensity? = .activity, duration: Duration = .unknown) {
        self.id = id
        self.type = type
        self.name = name
        
        if let type = type {
            switch type {
            case .flow:
                self.duration = .unlimited
                self.isService = false
                self.intensityType = intensity
            case .timer:
                if case .known(let seconds) = duration {
                    self.duration = seconds > 0 ? duration : .unknown
                } else {
                    self.duration = .unknown
                }
                self.isService = isService
                self.intensityType = intensity
            case .tabata:
                self.duration = .known(SettingsManager.shared.tabataExerciseDuration)
                self.isService = false
                self.intensityType = .mixed
            }
        } else {
            self.intensityType = nil
            self.duration = .unknown
            self.isService = false
        }
    }
    
    /** the result has an id different from the source */
    init(from template: ExerciseTemplate) {
        self.init(type: template.type, name: template.name, isService: template.isService, intensity: template.intensityType, duration: template.duration)
    }
    
    /** the result has the same id as the source */
    func makeCopy() -> ExerciseTemplate {
        ExerciseTemplate(id: id, type: type, name: name, isService: isService, intensity: intensityType, duration: duration)
    }
    
    static var restTemplate: ExerciseTemplate {
        ExerciseTemplate(type: .timer, name: "Rest", isService: true, intensity: .rest, duration: .known(SettingsManager.shared.getValue(of: .general_rest)))
    }
    
    static var template: ExerciseTemplate {
        ExerciseTemplate(type: .flow)
    }
    
    var isTimer: Bool {
        type == .timer
    }
    
    var isTypeSet: Bool {
        type != nil
    }
    
    // examples
    static let catCow = ExerciseTemplate(type: .timer, name: "Cat-Cow", intensity: .activity, duration: .known(90))
    static let balasana = ExerciseTemplate(type: .flow, name: "Balasana", intensity: .rest, duration: .unlimited)
    static let surjaNamascar = ExerciseTemplate(type: .flow, name: "Surja Namascar", intensity: .activity, duration: .unlimited)
    static let vasihsthasana = ExerciseTemplate(type: .tabata, name: "Vasihsthasana", duration: .unknown)
    static let rest = ExerciseTemplate(type: .timer, name: "Rest", isService: true, intensity: .rest, duration: .known(10))
    static let concentration = ExerciseTemplate(type: .timer, name: "Concentration", intensity: .activity, duration: .known(360))
    static let catCowNoDuration = ExerciseTemplate(type: .timer, name: "Cat-Cow", intensity: .activity, duration: .unknown)
    static let catCowNoType = ExerciseTemplate(name: "Cat-Cow")
}
