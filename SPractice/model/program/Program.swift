//
//  Program.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.07.22.
//

import Foundation

protocol Program: HavingID, Named {
    associatedtype Item where Item: Exercise
    
    var id: UUID {get}
    var name: String {get}
    var description: String {get}
    var exercises: [Item] {get}
    
    var isExample: Bool {get}
    var exampleId: String? {get}
}

extension Program {
    
    var duration: Duration {
        calculateDuration(from: 0)
    }
    
    func calculateDuration(from startIndex: Int) -> Duration {
        var totalDuration = 0
        for index in startIndex..<exercises.count {
            let exercise = exercises[index]
            var exerciseDuration: Int = 0
            if case .known(let duration) = exercise.duration {
                exerciseDuration = duration
            } else if exercise.type == .tabata {
                exerciseDuration = SettingsManager.tabataExerciseDuration
            } else if exercise.isService {
                exerciseDuration = SettingsManager.pauseDurationItem.value
            }
            totalDuration += exerciseDuration
        }
        return totalDuration == 0 ? (hasFlowExercises(fromIndex: startIndex) ? .unlimited : .unknown) : .known(totalDuration)
    }
    
    var hasExercises: Bool {
        !exercises.isEmpty
    }
    
    var hasFlowExercises: Bool {
        hasFlowExercises(fromIndex: 0)
    }
    
    func hasFlowExercises(fromIndex index: Int) -> Bool {
        let subrange = Array(exercises[index...])
        let exerciseMissingDuration = subrange.first(where: {
            $0.type == .flow
        })
        return exerciseMissingDuration != nil
    }
    
    var hasExercisesMissingDuration: Bool {
        hasExercisesMissingDuration()
    }
    
    func hasExercisesMissingDuration(excludeTabata: Bool = true, excludeService: Bool = true) -> Bool {
        let exerciseMissingDuration = exercises.first(where: {
            if case .unknown = $0.duration {
                let foundTabata = !excludeTabata && $0.type == .tabata
                let foundService = !excludeService && $0.isService
                let foundOther = $0.type == .timer && !$0.isService
                return foundTabata || foundService || foundOther
            }
            return false
        })
        return exerciseMissingDuration != nil
    }
    
    var hasExercisesWithoutType: Bool {
        let exerciseWithoutType = exercises.first(where: {
            $0.type == nil
        })
        
        return exerciseWithoutType != nil
    }
}
