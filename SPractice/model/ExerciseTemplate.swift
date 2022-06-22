//
//  ExerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ExerciseTemplate: Identifiable, Hashable {
    
    let id: UUID
    var type: Exercise.ExerciseType?
    var name: String
    let isService: Bool
    var taskType: Task.TaskType? // for timer and flow
    var duration: Int? // for timer only
    
    private init(id: UUID = UUID(), type: Exercise.ExerciseType? = nil, name: String = "", isService: Bool = false, taskType: Task.TaskType? = nil, duration: Int? = nil) {
        self.id = id
        self.type = type
        self.name = name
        
        if type == .timer {
            self.duration = duration
            self.isService = isService
        } else {
            self.duration = nil
            self.isService = false
        }
        
        if type != .tabata {
            self.taskType = taskType
        } else {
            self.taskType = nil
        }
    }
    
    /** the result has an id different from the source */
    init(from template: ExerciseTemplate) {
        self.init(type: template.type, name: template.name, isService: template.isService, taskType: template.taskType, duration: template.duration)
    }
    
    /** the result has the same id as the source */
    func makeCopy() -> ExerciseTemplate {
        ExerciseTemplate(id: id, type: type, name: name, isService: isService, taskType: taskType, duration: duration)
    }
    
    static var restTemplate: ExerciseTemplate {
        // todo: read rest duration from settings
        ExerciseTemplate(type: .timer, name: "Rest", isService: true, duration: 10)
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
    static let catCowDuration0 = ExerciseTemplate(type: .timer, name: "Cat-Cow", taskType: .activity, duration: 0)
    static let catCowNoType = ExerciseTemplate(name: "Cat-Cow")
}
