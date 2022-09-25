//
//  ProgramService.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation

class ProgramService: ObservableObject {

    var settingsManager = SettingsManager()

    func calculateDuration(for program: any Program, from startIndex: Int = 0) -> Duration {
        var totalDuration = 0
        for index in startIndex..<program.exercises.count {
            let exercise = program.exercises[index]
            var exerciseDuration: Int = 0
            if case .known(let duration) = exercise.duration {
                exerciseDuration = duration
            } else if exercise.type == .tabata {
                exerciseDuration = settingsManager.tabataExerciseDuration
            } else if exercise.isService {
                exerciseDuration = settingsManager.restDurationItem.value
            }
            totalDuration += exerciseDuration
        }
        return totalDuration == 0 ? (program.hasFlowExercises(fromIndex: startIndex) ? .unlimited : .unknown) : .known(totalDuration)
    }

}
