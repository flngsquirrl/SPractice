//
//  ExerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ExerciseTemplate: Identifiable, Hashable {
    
    let id: UUID
    var type: ExerciseType?
    var name: String
    let isService: Bool
    var intensityType: IntensityType? // not set when type not set
    var duration: Int? // for timer only
    
    private init(id: UUID = UUID(), type: ExerciseType? = nil, name: String = "", isService: Bool = false, taskType: IntensityType? = .activity, duration: Int? = nil) {
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
        
        if type == nil {
            self.intensityType = nil
        } else if type == .tabata {
            self.intensityType = .activity
        } else {
            self.intensityType = taskType
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
        ExerciseTemplate(type: .timer, name: "Rest", isService: true, duration: SettingsManager.shared.getValue(of: .general_rest))
    }
    
    static var defaultTemplate = ExerciseTemplate(type: .flow)
    
    var isTimer: Bool {
        type == .timer
    }
    
    var isTypeSet: Bool {
        type != nil
    }
    
    // examples
    static let catCow = ExerciseTemplate(type: .timer, name: "Cat-Cow", taskType: .activity, duration: 90)
    static let surjaNamascar = ExerciseTemplate(type: .flow, name: "Surja Namascar", taskType: .activity)
    static let vasihsthasana = ExerciseTemplate(type: .tabata, name: "Vasihsthasana")
    static let rest = ExerciseTemplate(type: .timer, name: "Rest", isService: true, taskType: .rest, duration: 10)
    static let concentration = ExerciseTemplate(type: .timer, name: "Concentration", taskType: .activity, duration: 360)
    static let catCowDurationNoDuration = ExerciseTemplate(type: .timer, name: "Cat-Cow", taskType: .activity)
    static let catCowNoType = ExerciseTemplate(name: "Cat-Cow")
}
