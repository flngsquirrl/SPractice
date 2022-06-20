//
//  Exercise.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Exercise: Identifiable, Equatable {
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.id == rhs.id
    }
    
    enum ExerciseType: String, CaseIterable {
        case flow
        case timer
        case tabata;
        
        var hasDuration: Bool {
            self != .flow
        }
    }
    
    let id = UUID()
    let type: ExerciseType
    let name: String
    let isService: Bool
    let tasks: [Task]
    
    var duration: Int? {
        guard type != .flow else {
            return nil
        }
        var duration = 0
        tasks.forEach { duration += $0.duration! }
        return duration
    }
    
    init(type: ExerciseType, name: String, isService: Bool = false, tasks: [Task] = []) {
        self.type = type
        self.name = name
        self.isService = isService
        self.tasks = tasks
    }
    
    init(from template: ExerciseTemplate) {
        let tasks = template.prepareTasks()
        self.init(type: template.type!, name: template.name, tasks: tasks)
    }
    
    static let catCow = Exercise(type: .timer, name: "Cat-Cow", isService: false, tasks: [Task.activity60])
    static let surjaNamascar = Exercise(type: .flow, name: "Surja Namascar", isService: false, tasks: [Task.activityFlow])
    static let vasihsthasana = Exercise(type: .tabata, name: "Vasihsthasana",  isService: false, tasks: [Task.restTabataWarmUp, Task.activityTabata1, Task.restTabata1, Task.activityTabata2, Task.restTabata2, Task.restTabataCoolDown])
    static let rest = Exercise(type: .timer, name: "Rest", isService: true, tasks: [Task.restService10])
}
