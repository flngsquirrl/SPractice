//
//  Exercise.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct PracticeExercise: Identifiable, Equatable {
    
    static func == (lhs: PracticeExercise, rhs: PracticeExercise) -> Bool {
        lhs.id == rhs.id
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
    
    init?(from template: Exercise) {
        guard template.type != nil else {
            return nil
        }
        
        self.init(type: template.type!, name: template.name)
        self.tasks = prepareTasks(from: template)
    }
    
    func prepareTasks(from template: Exercise) -> [Task] {
        var tasks = [Task]()
        
        switch type {
        case .flow:
            tasks = prepareFlowTasks(from: template)
        case .tabata:
            tasks = prepareTabataTasks(from: template)
        case .timer:
            tasks = prepareTimerTasks(from: template)
        }
        
        return tasks
    }
    
    private func prepareTabataTasks(from template: Exercise) -> [Task]  {
        var tasks = [Task]()
        
        let warmUp = Task(type: .rest, name: "warm-up", duration: SettingsManager.shared.getValue(of: .tabata_warmup))
        tasks.append(warmUp)
        
        for i in 1...SettingsManager.shared.getValue(of: .tabata_repetitions){
            let activity = Task(type: .activity, name: "\(IntensityType.activity.rawValue) \(i)", duration: SettingsManager.shared.getValue(of: .tabata_activity))
            let rest = Task(type: .rest, name: "\(IntensityType.rest.rawValue) \(i)", duration: SettingsManager.shared.getValue(of: .general_rest))
            tasks.append(activity)
            tasks.append(rest)
        }
        
        let coolDown = Task(type: .rest, name: "cool-down", duration: SettingsManager.shared.getValue(of: .tabata_cooldown))
        tasks.append(coolDown)
        
        return tasks
    }
    
    private func prepareFlowTasks(from template: Exercise) -> [Task] {
        let task = Task(type: template.intensityType, name: template.intensityType.rawValue)
        return Array<Task>.wrapElement(element: task)
    }
    
    private func prepareTimerTasks(from template: Exercise) -> [Task] {
        let taskType: IntensityType = template.isService ? .rest : template.intensityType
        let task = Task(type: taskType, name: taskType.rawValue, duration: template.duration)
        return Array<Task>.wrapElement(element: task)
    }
    
    static let catCow = PracticeExercise(type: .timer, name: "Cat-Cow", isService: false, tasks: [Task.activity60])
    static let surjaNamascar = PracticeExercise(type: .flow, name: "Surja Namascar", isService: false, tasks: [Task.activityFlow])
    static let vasihsthasana = PracticeExercise(type: .tabata, name: "Vasihsthasana",  isService: false, tasks: [Task.restTabataWarmUp, Task.activityTabata1, Task.restTabata1, Task.activityTabata2, Task.restTabata2, Task.restTabataCoolDown])
    static let rest = PracticeExercise(type: .timer, name: "Rest", isService: true, tasks: [Task.restService10])
}
