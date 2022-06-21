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
    private(set) var tasks: [Task]
    
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
    
    init?(from template: ExerciseTemplate) {
        guard template.type != nil else {
            return nil
        }
        
        self.init(type: template.type!, name: template.name)
        self.tasks = prepareTasks()
    }
    
    func prepareTasks() -> [Task] {
        var tasks = [Task]()
        
        switch type {
        case .flow:
            tasks = prepareFlowTasks()
        case .tabata:
            tasks = prepareTabataTasks()
        case .timer:
            tasks = prepareTimerTasks()
        }
        
        return tasks
    }
    
    private func prepareTabataTasks() -> [Task]  {
        var tasks = [Task]()
        
        // todo: read duration from settings
        let warmUp = Task(type: .rest, name: "warm-up", duration: 10)
        tasks.append(warmUp)
        
        for i in 1...2 {
            // todo: read rest duration from settings
            let activity = Task(type: .activity, name: "\(Task.TaskType.activity.rawValue) \(i)", duration: 20)
            // todo: read rest duration from settings
            let rest = Task(type: .rest, name: "\(Task.TaskType.rest.rawValue) \(i)", duration: 10)
            tasks.append(activity)
            tasks.append(rest)
        }
        
        // todo: read rest duration from settings
        let coolDown = Task(type: .rest, name: "cool-down", duration: 10)
        tasks.append(coolDown)
        
        return tasks
    }
    
    private func prepareFlowTasks() -> [Task] {
        let task = Task(type: .activity, name: Task.TaskType.activity.rawValue)
        return Array<Task>.wrapElement(element: task)
    }
    
    private func prepareTimerTasks() -> [Task] {
        let type: Task.TaskType = isService ? .rest : .activity
        let task = Task(type: type, name: type.rawValue, duration: duration)
        return Array<Task>.wrapElement(element: task)
    }
    
    static let catCow = Exercise(type: .timer, name: "Cat-Cow", isService: false, tasks: [Task.activity60])
    static let surjaNamascar = Exercise(type: .flow, name: "Surja Namascar", isService: false, tasks: [Task.activityFlow])
    static let vasihsthasana = Exercise(type: .tabata, name: "Vasihsthasana",  isService: false, tasks: [Task.restTabataWarmUp, Task.activityTabata1, Task.restTabata1, Task.activityTabata2, Task.restTabata2, Task.restTabataCoolDown])
    static let rest = Exercise(type: .timer, name: "Rest", isService: true, tasks: [Task.restService10])
}
