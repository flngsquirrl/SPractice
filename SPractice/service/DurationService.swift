//
//  DurationService.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation
import Resolver

protocol DurationService {

    func calculateDuration(of program: any Program) -> Duration
    func calculateDuration(of exercises: [any Exercise]) -> Duration
}

struct BasicDurationService: DurationService {

    @Injected private var tabataSettings: TabataSettingsProvider
    @Injected private var restSettings: RestSettingsProvider

    func calculateDuration(of program: any Program) -> Duration {
        calculateDuration(of: program.exercises)
    }

    func calculateDuration(of exercises: [any Exercise]) -> Duration {
        var totalDuration = 0
        for index in 0..<exercises.count {
            let exercise = exercises[index]
            var exerciseDuration: Int = 0
            if case .known(let duration) = exercise.duration {
                exerciseDuration = duration
            } else if .setting == exercise.duration {
                if exercise.type == .tabata {
                    exerciseDuration = tabataSettings.exerciseDuration
                } else if exercise.isService {
                    exerciseDuration = restSettings.restDuration
                }
            }
            totalDuration += exerciseDuration
        }
        return .known(totalDuration)
    }
}
