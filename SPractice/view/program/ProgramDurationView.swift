//
//  ProgramDurationView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 1.07.22.
//

import SwiftUI

struct ProgramDurationView: View {

    private let duration: Duration
    private let mode: DurationView.Mode
    private let showAsApproximate: Bool
    private let showZeroAsUnknown: Bool

    private var programService = ProgramService()

    init<T>(for program: T, mode: DurationView.Mode = .padded) where T: Program {
        self.duration = programService.calculateDuration(of: program)
        self.mode = mode
        self.showAsApproximate = program.hasFlowExercises
        self.showZeroAsUnknown = true
    }

    init<E>(for exercises: [E], duration: Duration, mode: DurationView.Mode = .padded) where E: Exercise {
        self.duration = duration
        self.mode = mode
        self.showAsApproximate = exercises.hasFlowExercises()
        self.showZeroAsUnknown = false
    }

    var body: some View {
        if case .known(let time) = duration {
            if time != 0 || !showZeroAsUnknown {
                HStack {
                    if showAsApproximate {
                        LayoutUtils.approximationMark
                    }
                    DurationView(duration: time, mode: mode)
                }
            } else {
                if showAsApproximate {
                    LayoutUtils.approximationMark
                } else {
                    LayoutUtils.unknownDurationText
                }
            }
        }
    }
}

struct ProgramDurationView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            HStack {
                ProgramDurationView(for: ProgramTemplate.simpleYoga, mode: .extended)
            }
            HStack {
                ProgramDurationView(for: ProgramTemplate.simpleYoga, mode: .padded)
            }
        }
    }
}
