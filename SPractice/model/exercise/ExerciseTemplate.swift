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
    let isService: Bool
    var intensityType: IntensityType? // not set when type not set
    var duration: Duration
    
    private init(id: UUID = UUID(), type: ExerciseType? = nil, name: String = "", isService: Bool = false, taskType: IntensityType? = .activity, duration: Duration = .unknown) {
        self.id = id
        self.type = type
        self.name = name
        
        if let type = type {
            switch type {
            case .flow:
                self.duration = .unlimited
                self.isService = false
                self.intensityType = taskType
            case .timer:
                if case .known(let seconds) = duration {
                    self.duration = seconds > 0 ? duration : .unknown
                } else {
                    self.duration = .unknown
                }
                self.isService = isService
                self.intensityType = taskType
            case .tabata:
                self.duration = .unknown
                self.isService = false
                self.intensityType = .activity
            }
        } else {
            self.intensityType = nil
            self.duration = .unknown
            self.isService = false
        }
    }
    
    /** the result has an id different from the source */
    init(from template: ExerciseTemplate) {
        self.init(type: template.type, name: template.name, isService: template.isService, taskType: template.intensityType, duration: template.duration)
    }
    
    /** the result has the same id as the source */
    func makeCopy() -> ExerciseTemplate {
        ExerciseTemplate(id: id, type: type, name: name, isService: isService, taskType: intensityType, duration: duration)
    }
    
    static var restTemplate: ExerciseTemplate {
        ExerciseTemplate(type: .timer, name: "Rest", isService: true, duration: .known(SettingsManager.shared.getValue(of: .general_rest)))
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
    static let catCow = ExerciseTemplate(type: .timer, name: "Cat-Cow", taskType: .activity, duration: .known(90))
    static let surjaNamascar = ExerciseTemplate(type: .flow, name: "Surja Namascar", taskType: .activity, duration: .unlimited)
    static let vasihsthasana = ExerciseTemplate(type: .tabata, name: "Vasihsthasana", duration: .unknown)
    static let rest = ExerciseTemplate(type: .timer, name: "Rest", isService: true, taskType: .rest, duration: .known(10))
    static let concentration = ExerciseTemplate(type: .timer, name: "Concentration", taskType: .activity, duration: .known(360))
    static let catCowNoDuration = ExerciseTemplate(type: .timer, name: "Cat-Cow", taskType: .activity, duration: .unknown)
    static let catCowNoType = ExerciseTemplate(name: "Cat-Cow")
}
