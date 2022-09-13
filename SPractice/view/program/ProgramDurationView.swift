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

    init<T>(for program: T, mode: DurationView.Mode = .padded) where T: Program {
        self.duration = program.duration
        self.mode = mode
        self.showAsApproximate = program.hasFlowExercises
    }

    init(for duration: Duration, mode: DurationView.Mode = .padded, showAsApproximate: Bool = false) {
        self.duration = duration
        self.mode = mode
        self.showAsApproximate = showAsApproximate
    }

    var body: some View {
        switch duration {
        case .known(let time):
            HStack {
                if showAsApproximate {
                    LayoutUtils.approximationMark
                }
                DurationView(duration: time, mode: mode)
            }
        case .unknown:
            LayoutUtils.unknownDurationText
        case .unlimited:
            if showAsApproximate {
                LayoutUtils.approximationMark
            }
        }
    }
}

struct ProgramDurationView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            HStack {
                ProgramDurationView(for: PracticeProgram.personal, mode: .extended)
            }
            HStack {
                ProgramDurationView(for: PracticeProgram.personal, mode: .padded)
            }
        }
    }
}
