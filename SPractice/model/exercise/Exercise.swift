//
//  ExerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct Exercise: Identifiable, Hashable {
    
    let id: UUID
    var type: ExerciseType?
    var name: String
    let isService: Bool
    var intensityType: IntensityType
    var duration: Int? // for timer only
    
    private init(id: UUID = UUID(), type: ExerciseType? = nil, name: String = "", isService: Bool = false, taskType: IntensityType = .activity, duration: Int? = nil) {
        self.id = id
        self.type = type
        self.name = name
        
        if type == .timer {
            if let duration = duration {
                self.duration = duration > 0 ? duration : nil
            } else {
                self.duration = nil
            }
            self.isService = isService
        } else {
            self.duration = nil
            self.isService = false
        }
        
        if type != .tabata {
            self.intensityType = taskType
        } else {
            self.intensityType = .activity
        }
    }
    
    /** the result has an id different from the source */
    init(from template: Exercise) {
        self.init(type: template.type, name: template.name, isService: template.isService, taskType: template.intensityType, duration: template.duration)
    }
    
    /** the result has the same id as the source */
    func makeCopy() -> Exercise {
        Exercise(id: id, type: type, name: name, isService: isService, taskType: intensityType, duration: duration)
    }
    
    static var restTemplate: Exercise {
        Exercise(type: .timer, name: "Rest", isService: true, duration: SettingsManager.shared.getValue(of: .general_rest))
    }
    
    static var defaultTemplate = Exercise(type: .flow)
    
    var isTimer: Bool {
        type == .timer
    }
    
    var isTypeSet: Bool {
        type != nil
    }
    
    // examples
    static let catCow = Exercise(type: .timer, name: "Cat-Cow", taskType: .activity, duration: 90)
    static let surjaNamascar = Exercise(type: .flow, name: "Surja Namascar", taskType: .activity)
    static let vasihsthasana = Exercise(type: .tabata, name: "Vasihsthasana")
    static let rest = Exercise(type: .timer, name: "Rest", isService: true, taskType: .rest, duration: 10)
    static let concentration = Exercise(type: .timer, name: "Concentration", taskType: .activity, duration: 360)
    static let catCowDurationNoDuration = Exercise(type: .timer, name: "Cat-Cow", taskType: .activity)
    static let catCowNoType = Exercise(name: "Cat-Cow")
}
