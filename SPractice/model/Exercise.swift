//
//  Exercise.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Exercise: Identifiable {
    
    enum ExerciseType: String, CaseIterable {
        case flow
        case timer
        case tabata;
        
        var imageName: String {
            switch self {
            case .flow:
                return "heart.circle.fill"
            case .timer:
                return "clock.fill"
            case .tabata:
                return "t.circle.fill"
            }
        }
    }
    
    let id = UUID()
    let type: ExerciseType
    let name: String
    let isService: Bool
    let tasks: [Task]
    
    var wrappedDuration: String {
        if let duration = duration {
            return "\(duration) sec"
        } else {
            return ""
        }
    }
    
    init(type: ExerciseType, name: String, isService: Bool = false, tasks: [Task] = []) {
        self.type = type
        self.name = name
        self.isService = isService
        self.tasks = tasks
    }
    
    init(from template: ExerciseTemplate) {
        let tasks = template.prepareTasks()
        self.init(type: template.type, name: template.name, tasks: tasks)
    }
    
    var duration: Int? {
        guard type != .flow else {
            return nil
        }
        var duration = 0
        tasks.forEach { duration += $0.duration! }
        return duration
    }
    
    static let catCow = Exercise(type: .timer, name: "Cat-Cow", isService: false, tasks: [Task.activity60])
    static let surjaNamascar = Exercise(type: .flow, name: "Surja Namascar", isService: false, tasks: [Task.activityFlow])
    static let vasihsthasana = Exercise(type: .tabata, name: "Vasihsthasana",  isService: false, tasks: [Task.restTabataWarmUp, Task.activityTabata1, Task.restTabata1, Task.activityTabata2, Task.restTabata2, Task.restTabataCoolDown])
    static let rest = Exercise(type: .timer, name: "Rest", isService: true, tasks: [Task.restService10])
}
