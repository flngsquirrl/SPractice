//
//  ExerciseTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ExerciseTemplate: Identifiable {
    
    let id = UUID()
    var type: Exercise.ExerciseType
    var name: String
    let isService: Bool
    var duration: Int? // for timer only
    
    init(type: Exercise.ExerciseType, name: String, isService: Bool = false, duration: Int? = nil) {
        self.type = type
        self.name = name
        self.isService = isService
        self.duration = duration
    }
    
    static var restTemplate: ExerciseTemplate {
        // todo: read rest duration from settings
        ExerciseTemplate(type: .timer, name: "Rest", isService: true, duration: 10)
    }
    
    // examples
    static let catCow = ExerciseTemplate(type: .timer, name: "Cat-Cow", duration: 90)
    static let surjaNamascar = ExerciseTemplate(type: .flow, name: "Surja Namascar")
    static let vasihsthasana = ExerciseTemplate(type: .tabata, name: "Vasihsthasana")
    static let rest = ExerciseTemplate(type: .timer, name: "Rest", isService: true, duration: 10)
    static let concentration = ExerciseTemplate(type: .timer, name: "Concentration", duration: 360)
    
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
        let task = Task(type: type, name: Task.TaskType.activity.rawValue, duration: duration)
        return Array<Task>.wrapElement(element: task)
    }
}
