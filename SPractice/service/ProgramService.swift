//
//  ProgramService.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation
import Resolver

struct ProgramService {

    @Injected private var tabataSettings: TabataSettingsProvider
    @Injected private var restSettings: RestSettingsProvider

    func calculateDuration(for program: any Program, from startIndex: Int = 0) -> Duration {
        var totalDuration = 0
        for index in startIndex..<program.exercises.count {
            let exercise = program.exercises[index]
            var exerciseDuration: Int = 0
            if case .known(let duration) = exercise.duration {
                exerciseDuration = duration
            } else if exercise.type == .tabata {
                exerciseDuration = tabataSettings.exerciseDuration
            } else if exercise.isService {
                exerciseDuration = restSettings.restDuration
            }
            totalDuration += exerciseDuration
        }
        return totalDuration == 0 ? (program.hasFlowExercises(fromIndex: startIndex) ? .unlimited : .unknown) : .known(totalDuration)
    }
}
