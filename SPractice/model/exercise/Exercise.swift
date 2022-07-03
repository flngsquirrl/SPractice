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
    
    let id = UUID()
    let type: ExerciseType
    let name: String
    var intensity: Intensity?
    private(set) var tasks: [Task]
    
    let isService: Bool
    
    var duration: Duration {
        guard type != .flow else {
            return .unlimited
        }
        var result = 0
        tasks.forEach {
            if case .known(let duration) = $0.duration {
                result += duration
            }
        }
        return result > 0 ? .known(result) : .unknown
    }
    
    init(type: ExerciseType, name: String, intensity: Intensity, isService: Bool = false, tasks: [Task] = []) {
        self.type = type
        self.name = name
        self.intensity = intensity
        self.isService = isService
        self.tasks = tasks
    }
    
    init?(from template: ExerciseTemplate) {
        guard template.type != nil else {
            return nil
        }
        
        self.init(type: template.type!, name: template.name, intensity: template.intensity!, isService: template.isService)
        self.tasks = prepareTasks(from: template)
    }
    
    func prepareTasks(from template: ExerciseTemplate) -> [Task] {
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
    
    private func prepareTabataTasks(from template: ExerciseTemplate) -> [Task]  {
        var tasks = [Task]()
        
        let warmUp = Task(intensity: .rest, name: "warm-up", duration: .known(SettingsManager.shared.getValue(of: .tabata_warmup)))
        tasks.append(warmUp)
        
        for i in 1...SettingsManager.shared.getValue(of: .tabata_repetitions){
            let activity = Task(intensity: .activity, name: "\(Intensity.activity.rawValue) \(i)", duration: .known(SettingsManager.shared.getValue(of: .tabata_activity)))
            let rest = Task(intensity: .rest, name: "\(Intensity.rest.rawValue) \(i)", duration: .known(SettingsManager.shared.getValue(of: .general_rest)))
            tasks.append(activity)
            tasks.append(rest)
        }
        
        let coolDown = Task(intensity: .rest, name: "cool-down", duration: .known(SettingsManager.shared.getValue(of: .tabata_cooldown)))
        tasks.append(coolDown)
        
        return tasks
    }
    
    private func prepareFlowTasks(from template: ExerciseTemplate) -> [Task] {
        let task = Task(intensity: template.intensity!, name: template.intensity!.rawValue, duration: .unlimited)
        return Array<Task>.wrapElement(element: task)
    }
    
    private func prepareTimerTasks(from template: ExerciseTemplate) -> [Task] {
        let intensity: Intensity = template.isService ? .rest : template.intensity!
        let task = Task(intensity: intensity, name: intensity.rawValue, duration: template.duration)
        return Array<Task>.wrapElement(element: task)
    }
    
    static let catCow = Exercise(from: ExerciseTemplate.catCow)!
    static let surjaNamascar = Exercise(from: ExerciseTemplate.surjaNamascar)!
    static let vasihsthasana = Exercise(from: ExerciseTemplate.vasihsthasana)!
    static let rest = Exercise(from: ExerciseTemplate.rest)!
}
