//
//  Exercise.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct PracticeExercise: Exercise, Equatable {

   static func == (lhs: PracticeExercise, rhs: PracticeExercise) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    let exerciseType: ExerciseType
    let name: String
    let description: String
    var exerciseIntensity: Intensity
    var isService: Bool
    
    private(set) var tasks: [Task]
    
    private init(type: ExerciseType, name: String, description: String, intensity: Intensity, isService: Bool = false, tasks: [Task] = []) {
        self.exerciseType = type
        self.name = name.trim()
        self.description = description.trim()
        self.exerciseIntensity = intensity
        self.isService = isService
        self.tasks = tasks
    }
    
    init?(from template: ExerciseTemplate) {
        guard template.type != nil else {
            return nil
        }
        
        self.init(type: template.type!, name: template.name, description: template.description, intensity: template.intensity!, isService: template.isService)
        self.tasks = prepareTasks(from: template)
    }
    
    var type: ExerciseType? {
        return exerciseType
    }
    
    var intensity: Intensity? {
        return exerciseIntensity
    }
    
    var duration: Duration {
        guard exerciseType != .flow else {
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
    
    func prepareTasks(from template: ExerciseTemplate) -> [Task] {
        var tasks = [Task]()
        
        switch exerciseType {
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
        
        let warmUp = Task(intensity: .rest, name: "warm-up", duration: .known(SettingsManager.tabataWarmUpDurationItem.value))
        tasks.append(warmUp)
        
        for i in 1...SettingsManager.tabataCyclesItem.value {
            let activity = Task(intensity: .activity, name: "\(Intensity.activity.rawValue) \(i)", duration: .known(SettingsManager.tabataActivityDurationItem.value))
            let rest = Task(intensity: .rest, name: "\(Intensity.rest.rawValue) \(i)", duration: .known(SettingsManager.tabataRestDurationItem.value))
            tasks.append(activity)
            tasks.append(rest)
        }
        
        let coolDown = Task(intensity: .rest, name: "cool-down", duration: .known(SettingsManager.tabataCoolDownDurationItem.value))
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
    
    static let catCow = PracticeExercise(from: ExerciseTemplate.catCow)!
    static let surjaNamascar = PracticeExercise(from: ExerciseTemplate.surjaNamascar)!
    static let vasihsthasana = PracticeExercise(from: ExerciseTemplate.vasihsthasana)!
}
