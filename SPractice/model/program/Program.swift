//
//  Program.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.07.22.
//

import Foundation

protocol Program {
    associatedtype Item where Item: Exercise
    
    var id: UUID {get}
    var name: String {get}
    var exercises: [Item] {get}
}

extension Program {
    
    var duration: Duration {
        calculateDuration(fromIndex: 0)
    }
    
    func calculateDuration(fromIndex index: Int) -> Duration {
        var totalDuration = 0
        for i in index..<exercises.count {
            let exercise = exercises[i]
            if case .known(let duration) = exercise.duration {
                totalDuration += duration
            } else if exercise.type == .tabata {
                totalDuration += SettingsManager.shared.tabataExerciseDuration
            }
        }
        return totalDuration == 0 ? (hasFlowExercises(fromIndex: index) ? .unlimited : .unknown) : .known(totalDuration)
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
        hasExercisesMissingDuration(excludeTabata: true)
    }
    
    func hasExercisesMissingDuration(excludeTabata: Bool = true) -> Bool {
        let exerciseMissingDuration = exercises.first(where: {
            if case .unknown = $0.duration {
                return $0.type != .tabata
            } else {
                return false
            }
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
